import 'package:greengrocer/models/category.dart';
import 'package:greengrocer/models/product.dart';
import 'package:greengrocer/screens/home/result/home_result.dart';
import 'package:greengrocer/services/http_manager.dart';
import 'package:greengrocer/constants/endpoints.dart';

class HomeRepository {
  final HttpManager _httpManager = HttpManager();

  Future<HomeResult<Category>> getAllCategories() async {
    final result = await _httpManager.restRequest(
      url: Endpoints.getAllCategories,
      method: HttpMethods.post,
    );

    if (result['result'] != null) {
      List<Category> data = (List<Map<String, dynamic>>.from(result['result']))
          .map((e) => Category.fromJson(e))
          .toList();

      return HomeResult<Category>.success(data);
    } else {
      return HomeResult.error(
          'Ocorreu um erro inesperado ao recuperar as categorias');
    }
  }

  Future<HomeResult<Product>> getAllProducts(Map<String, dynamic> body) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.getAllProducts,
      method: HttpMethods.post,
      body: body,
    );

    if (result['result'] != null) {
      List<Product> data = List<Map<String, dynamic>>.from(result['result'])
          .map((e) => Product.fromJson(e))
          .toList();

      return HomeResult<Product>.success(data);
    } else {
      return HomeResult.error(
        'Ocorreu um erro inesperado ao recuperar os itens',
      );
    }
  }
}
