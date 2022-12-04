import 'package:get/get.dart';
import 'package:greengrocer/screens/order/controllers/all_orders_controllers.dart';

class OrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AllOrdersController());
  }
}
