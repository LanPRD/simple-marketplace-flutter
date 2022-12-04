import 'package:get/get.dart';
import 'package:greengrocer/models/cart_product.dart';
import 'package:greengrocer/models/order.dart';
import 'package:greengrocer/screens/auth/controllers/auth_controller.dart';
import 'package:greengrocer/screens/order/repositories/order_repository.dart';
import 'package:greengrocer/screens/order/result/order_result.dart';
import 'package:greengrocer/utils/utils.dart';

class OrderController extends GetxController {
  Order order;

  OrderController(this.order);

  final ordersRepository = OrderRepository();
  final authController = Get.find<AuthController>();
  final utils = Utils();

  bool isLoading = false;

  void setLoading(bool value) {
    isLoading = value;
    update();
  }

  Future<void> getOrderItems() async {
    setLoading(true);
    final OrderResult<List<CartProduct>> result =
        await ordersRepository.getOrderItems(
      orderId: order.id,
      token: authController.user.token!,
    );
    setLoading(false);

    result.when(
      success: (items) {
        order.items = items;
        update();
      },
      error: (message) {
        utils.showToast(
          message: message,
          isError: true,
        );
      },
    );
  }
}
