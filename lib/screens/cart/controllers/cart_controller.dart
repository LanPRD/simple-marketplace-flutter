import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocer/models/cart_product.dart';
import 'package:greengrocer/models/order.dart';
import 'package:greengrocer/models/product.dart';
import 'package:greengrocer/screens/auth/controllers/auth_controller.dart';
import 'package:greengrocer/screens/cart/components/payment_dialog.dart';
import 'package:greengrocer/screens/cart/repositories/cart_repository.dart';
import 'package:greengrocer/screens/cart/result/cart_result.dart';
import 'package:greengrocer/utils/utils.dart';

class CartController extends GetxController {
  final cartReposiroty = CartRepository();
  final authController = Get.find<AuthController>();
  final utils = Utils();

  List<CartProduct> productCarts = [];

  bool isCheckoutLoading = false;

  @override
  void onInit() {
    super.onInit();

    getCartItems();
  }

  double cartTotalPrice() {
    double total = 0;

    for (final item in productCarts) {
      total += item.totalPrice();
    }

    return total;
  }

  void setCheckoutLoading(bool value) {
    isCheckoutLoading = value;
    update();
  }

  Future checkoutCart() async {
    setCheckoutLoading(true);

    CartResult<Order> result = await cartReposiroty.checkoutCart(
      token: authController.user.token!,
      total: cartTotalPrice(),
    );

    setCheckoutLoading(false);

    result.when(
      success: (order) {
        productCarts.clear();
        update();

        showDialog(
          context: Get.context!,
          builder: (_) {
            return PaymentDialog(order: order);
          },
        );
      },
      error: (message) {
        utils.showToast(message: message);
      },
    );
  }

  Future<bool> changeItemQuantity({
    required CartProduct cartProducts,
    required int quantity,
  }) async {
    final result = await cartReposiroty.changeItemQuantity(
      token: authController.user.token!,
      cartItemId: cartProducts.id,
      quantity: quantity,
    );

    if (result) {
      if (quantity == 0) {
        productCarts.removeWhere((element) => element.id == cartProducts.id);
      } else {
        productCarts
            .firstWhere((element) => element.id == cartProducts.id)
            .quantity = quantity;
      }

      update();
    } else {
      utils.showToast(
        message: 'Ocorreu um erro ao alterar a quantidade do produto',
        isError: true,
      );
    }

    return result;
  }

  Future<void> getCartItems() async {
    final CartResult<List<CartProduct>> result =
        await cartReposiroty.getCartItems(
      token: authController.user.token!,
      userId: authController.user.id!,
    );

    result.when(
      success: (data) {
        productCarts = data;
        update();
      },
      error: (message) {
        utils.showToast(message: message, isError: true);
      },
    );
  }

  int getItemIndex(Product product) {
    return productCarts
        .indexWhere((element) => element.product.id == product.id);
  }

  Future<void> addItemToCart({
    required Product product,
    int quantity = 1,
  }) async {
    int itemIndex = getItemIndex(product);

    if (itemIndex >= 0) {
      final product = productCarts[itemIndex];

      await changeItemQuantity(
        cartProducts: product,
        quantity: (product.quantity + quantity),
      );
    } else {
      final CartResult<String> result = await cartReposiroty.addItemToCart(
        userId: authController.user.id!,
        token: authController.user.token!,
        quantity: quantity,
        productId: product.id,
      );

      result.when(
        success: (cartItemId) {
          productCarts.add(
            CartProduct(
              id: cartItemId,
              product: product,
              quantity: quantity,
            ),
          );
        },
        error: (message) {
          utils.showToast(message: message, isError: true);
        },
      );
    }

    update();
  }
}
