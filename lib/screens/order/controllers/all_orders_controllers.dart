import 'package:get/get.dart';
import 'package:greengrocer/models/order.dart';
import 'package:greengrocer/screens/auth/controllers/auth_controller.dart';
import 'package:greengrocer/screens/order/repositories/order_repository.dart';
import 'package:greengrocer/screens/order/result/order_result.dart';
import 'package:greengrocer/utils/utils.dart';

class AllOrdersController extends GetxController {
  List<Order> allOrders = [];

  final ordersRepository = OrderRepository();
  final authController = Get.find<AuthController>();
  final utils = Utils();

  @override
  void onInit() {
    super.onInit();

    getAllOrders();
  }

  Future<void> getAllOrders() async {
    OrderResult<List<Order>> result = await ordersRepository.getAllOrder(
      userId: authController.user.id!,
      token: authController.user.token!,
    );

    result.when(
      success: (orders) {
        allOrders = orders
          ..sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
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
