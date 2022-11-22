import 'package:get/get.dart';
import 'package:greengrocer/screens/home/controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
  }
}
