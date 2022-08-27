import 'package:greengrocer/src/models/product.dart';

class CartProduct {
  Product product;
  int quantity;

  CartProduct({
    required this.product,
    required this.quantity,
  });

  double totalPrice() => product.price * quantity;
}
