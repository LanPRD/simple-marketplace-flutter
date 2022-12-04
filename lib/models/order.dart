import 'package:json_annotation/json_annotation.dart';
import 'package:greengrocer/models/cart_product.dart';

part 'order.g.dart';

@JsonSerializable()
class Order {
  String id;
  DateTime? createdAt;
  @JsonKey(name: 'due')
  DateTime expiredAt;
  @JsonKey(defaultValue: [])
  List<CartProduct> items;
  String status;
  @JsonKey(name: 'copiaecola')
  String copyAndPaste;
  String qrCodeImage;
  double total;

  Order({
    required this.id,
    required this.createdAt,
    required this.expiredAt,
    required this.items,
    required this.status,
    required this.copyAndPaste,
    required this.total,
    required this.qrCodeImage,
  });

  bool get isOverDue => expiredAt.isBefore(DateTime.now());

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);

  @override
  String toString() {
    return 'Order(id: $id, createdAt: $createdAt, expiredAt: $expiredAt, items: $items, status: $status, copyAndPaste: $copyAndPaste, qrCodeImage: $qrCodeImage, total: $total)';
  }
}
