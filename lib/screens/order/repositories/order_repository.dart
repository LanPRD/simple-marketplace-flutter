import 'package:greengrocer/constants/endpoints.dart';
import 'package:greengrocer/models/cart_product.dart';
import 'package:greengrocer/models/order.dart';
import 'package:greengrocer/screens/order/result/order_result.dart';
import 'package:greengrocer/services/http_manager.dart';

class OrderRepository {
  final _httpManager = HttpManager();

  Future<OrderResult<List<CartProduct>>> getOrderItems({
    required String orderId,
    required String token,
  }) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.getOrderItems,
      method: HttpMethods.post,
      body: {
        'orderId': orderId,
      },
      headers: {
        'X-Parse-Session-Token': token,
      },
    );

    if (result['result'] != null) {
      List<CartProduct> items =
          List<Map<String, dynamic>>.from(result['result'])
              .map((e) => CartProduct.fromJson(e))
              .toList();

      return OrderResult<List<CartProduct>>.success(items);
    } else {
      return OrderResult.error('Não foi possível recuperar os pedidos');
    }
  }

  Future<OrderResult<List<Order>>> getAllOrder({
    required String userId,
    required String token,
  }) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.getAllOrders,
      method: HttpMethods.post,
      body: {
        'user': userId,
      },
      headers: {
        'X-Parse-Session-Token': token,
      },
    );

    if (result['result'] != null) {
      List<Order> orders = List<Map<String, dynamic>>.from(result['result'])
          .map((e) => Order.fromJson(e))
          .toList();

      return OrderResult<List<Order>>.success(orders);
    } else {
      return OrderResult.error('Não foi possível recuperar os pedidos');
    }
  }
}
