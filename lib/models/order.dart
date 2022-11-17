import 'package:greengrocer/models/cart_product.dart';

class Order {
  String id;
  DateTime createdAt;
  DateTime expiredAt;
  List<CartProduct> items;
  String status;
  String copyAndPaste;
  double total;

  Order({
    required this.id,
    required this.createdAt,
    required this.expiredAt,
    required this.items,
    required this.status,
    required this.copyAndPaste,
    required this.total,
  });
}
