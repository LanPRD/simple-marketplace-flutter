import 'package:json_annotation/json_annotation.dart';

import 'package:greengrocer/models/product.dart';

part 'cart_product.g.dart';

@JsonSerializable()
class CartProduct {
  Product product;
  String id;
  int quantity;

  CartProduct({
    required this.id,
    required this.product,
    required this.quantity,
  });

  factory CartProduct.fromJson(Map<String, dynamic> json) =>
      _$CartProductFromJson(json);

  Map<String, dynamic> toJson() => _$CartProductToJson(this);

  double totalPrice() => product.price * quantity;

  @override
  String toString() =>
      'CartProduct(product: $product, id: $id, quantity: $quantity)';
}
