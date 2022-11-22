import 'package:get/get.dart';
import 'package:greengrocer/models/category.dart';
import 'package:greengrocer/screens/home/repositories/home_repository.dart';
import 'package:greengrocer/screens/home/result/home_result.dart';
import 'package:greengrocer/utils/utils.dart';

class HomeController extends GetxController {
  final homeRepository = HomeRepository();
  final utils = Utils();

  bool isLoading = false;
  List<Category> allCategories = [];
  Category? currentCategory;

  @override
  void onInit() {
    super.onInit();

    getAllCategories();
  }

  void selectCategory(Category category) {
    currentCategory = category;
    update();
  }

  void setLoading(bool value) {
    isLoading = value;
    update();
  }

  Future<void> getAllCategories() async {
    setLoading(true);

    HomeResult<Category> homeResult = await homeRepository.getAllCategories();

    setLoading(false);

    homeResult.when(success: (data) {
      allCategories.assignAll(data);

      if (allCategories.isEmpty) return;

      selectCategory(allCategories.first);
    }, error: (message) {
      utils.showToast(message: message, isError: true);
    });
  }
}
