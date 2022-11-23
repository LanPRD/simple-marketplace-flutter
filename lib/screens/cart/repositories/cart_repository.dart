import 'package:greengrocer/models/cart_product.dart';
import 'package:greengrocer/models/order.dart';
import 'package:greengrocer/services/http_manager.dart';
import 'package:greengrocer/screens/cart/result/cart_result.dart';
import 'package:greengrocer/constants/endpoints.dart';

class CartRepository {
  final _httpManager = HttpManager();

  Future<CartResult<List<CartProduct>>> getCartItems({
    required String token,
    required String userId,
  }) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.getCartItems,
      method: HttpMethods.post,
      headers: {
        'X-Parse-Session-Token': token,
      },
      body: {
        'user': userId,
      },
    );

    if (result['result'] != null) {
      List<CartProduct> data = List<Map<String, dynamic>>.from(result['result'])
          .map((e) => CartProduct.fromJson(e))
          .toList();

      return CartResult<List<CartProduct>>.success(data);
    } else {
      return CartResult.error(
        'Ocorreu um erro ao recuperar os itens do carrinho',
      );
    }
  }

  Future<CartResult<Order>> checkoutCart({
    required String token,
    required double total,
  }) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.checkout,
      method: HttpMethods.post,
      headers: {
        'X-Parse-Session-Token': token,
      },
      body: {
        'total': total,
      },
    );

    if (result['result'] != null) {
      final order = Order.fromJson(result['result']);

      return CartResult<Order>.success(order);
    } else {
      return CartResult.error(
        'Não foi possível realizar o pedido',
      );
    }
  }

  Future<bool> changeItemQuantity({
    required String token,
    required String cartItemId,
    required int quantity,
  }) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.modifyItemQuantity,
      method: HttpMethods.post,
      headers: {
        'X-Parse-Session-Token': token,
      },
      body: {
        'cartItemId': cartItemId,
        'quantity': quantity,
      },
    );

    return result.isEmpty;
  }

  Future<CartResult<String>> addItemToCart({
    required String userId,
    required String token,
    required int quantity,
    required String productId,
  }) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.addItemToCart,
      method: HttpMethods.post,
      headers: {
        'X-Parse-Session-Token': token,
      },
      body: {
        'user': userId,
        'quantity': quantity,
        'productId': productId,
      },
    );

    if (result['result'] != null) {
      return CartResult<String>.success(result['result']['id']);
    } else {
      return CartResult.error(
        'Não foi possível adicionar o item no carrinho',
      );
    }
  }
}
