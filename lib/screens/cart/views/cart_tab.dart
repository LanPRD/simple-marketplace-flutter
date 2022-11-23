import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:greengrocer/screens/cart/components/cart_tile.dart';
import 'package:greengrocer/screens/cart/controllers/cart_controller.dart';

import 'package:greengrocer/widgets/common/custom_elevated_button.dart';

import 'package:greengrocer/theme/custom_colors.dart';

import 'package:greengrocer/utils/utils.dart';

class CartTab extends StatefulWidget {
  const CartTab({Key? key}) : super(key: key);

  @override
  State<CartTab> createState() => _CartTabState();
}

class _CartTabState extends State<CartTab> {
  final Utils utils = Utils();
  final CartController cartController = Get.find<CartController>();

  double cartTotalPrice() {
    // double total = 0;

    // for (var item in app_data.cartProducts) {
    //   total += item.totalPrice();
    // }

    // return total;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GetBuilder<CartController>(
              builder: (controller) {
                if (controller.productCarts.isEmpty) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.remove_shopping_cart,
                        size: 40,
                        color: CustomColors.customSwatchColor,
                      ),
                      const Text('Não há itens no carrinho'),
                    ],
                  );
                }

                return ListView.builder(
                  itemCount: controller.productCarts.length,
                  itemBuilder: (_, index) {
                    return CartTile(
                      cartProduct: controller.productCarts[index],
                    );
                  },
                );
              },
            ),
          ),

          // Total geral
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(28),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 3,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Total Geral',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                GetBuilder<CartController>(
                  builder: (controller) {
                    return Text(
                      utils.priceToCurrency(controller.cartTotalPrice()),
                      style: TextStyle(
                        fontSize: 24,
                        color: CustomColors.customSwatchColor,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
                GetBuilder<CartController>(
                  builder: (controller) {
                    return CustomElevatedButton(
                      text: 'Concluir Pedido',
                      isLoading: controller.isCheckoutLoading,
                      onPressed: () async {
                        bool? result = await showOrderConfirmation();

                        if (result ?? false) {
                          cartController.checkoutCart();
                        } else {
                          utils.showToast(message: 'Pedido não confirmado');
                        }
                      },
                      primaryColor: CustomColors.customSwatchColor,
                    );
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<bool?> showOrderConfirmation() {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Concluir pedido'),
          content: const Text('Deseja realmente concluir o pedido?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Não'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Sim'),
            ),
          ],
        );
      },
    );
  }
}
