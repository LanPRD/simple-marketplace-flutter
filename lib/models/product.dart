import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  String id;
  @JsonKey(name: 'title')
  String itemName;
  @JsonKey(name: 'picture')
  String imageUrl;
  String unit;
  double price;
  String description;

  Product({
    this.id = '',
    required this.itemName,
    required this.imageUrl,
    required this.unit,
    required this.price,
    required this.description,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);

  @override
  String toString() {
    return 'Product(id: $id, itemName: $itemName, imageUrl: $imageUrl, unit: $unit, price: $price, description: $description)';
  }
}
