// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

import 'package:greengrocer/models/product.dart';

part 'category.g.dart';

@JsonSerializable()
class Category {
  String id;
  String title;

  @JsonKey(defaultValue: [])
  List<Product> items;

  @JsonKey(defaultValue: 0)
  int pagination;

  Category({
    required this.id,
    required this.title,
    required this.items,
    required this.pagination,
  });

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);

  @override
  String toString() {
    return 'Category(id: $id, title: $title, items: $items, pagination: $pagination)';
  }
}
