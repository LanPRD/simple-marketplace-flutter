// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      id: json['id'] as String,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      expiredAt: DateTime.parse(json['due'] as String),
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => CartProduct.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      status: json['status'] as String,
      copyAndPaste: json['copiaecola'] as String,
      total: (json['total'] as num).toDouble(),
      qrCodeImage: json['qrCodeImage'] as String,
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt?.toIso8601String(),
      'due': instance.expiredAt.toIso8601String(),
      'items': instance.items,
      'status': instance.status,
      'copiaecola': instance.copyAndPaste,
      'qrCodeImage': instance.qrCodeImage,
      'total': instance.total,
    };
