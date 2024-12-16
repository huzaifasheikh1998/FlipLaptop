import 'package:collection/collection.dart';

import 'color.dart';
import 'discount.dart';
import 'hard_drive.dart';
import 'memory.dart';
import 'product_image.dart';
import 'size.dart';

class Datum {
  String? id;
  String? name;
  int? price;
  int? qty;
  List<Size>? size;
  Memory? memory;
  String? conditionType;
  String? deliveryType;
  String? model;
  HardDrive? hardDrive;
  Color? color;
  String? descriptions;
  String? shippingCost;
  String? createdAt;
  Discount? discount;
  List<ProductImage>? productImage;

  Datum({
    this.id,
    this.name,
    this.price,
    this.qty,
    this.size,
    this.memory,
    this.conditionType,
    this.deliveryType,
    this.model,
    this.hardDrive,
    this.color,
    this.descriptions,
    this.shippingCost,
    this.createdAt,
    this.discount,
    this.productImage,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['id'] as String?,
        name: json['name'] as String?,
        price: json['price'] as int?,
        qty: json['qty'] as int?,
        size: (json['size'] as List<dynamic>?)
            ?.map((e) => Size.fromJson(e as Map<String, dynamic>))
            .toList(),
        memory: json['memory'] == null
            ? null
            : Memory.fromJson(json['memory'] as Map<String, dynamic>),
        conditionType: json['condition_type'] as String?,
        deliveryType: json['delivery_type'] as String?,
        model: json['model'] as String?,
        hardDrive: json['hard_drive'] == null
            ? null
            : HardDrive.fromJson(json['hard_drive'] as Map<String, dynamic>),
        color: json['color'] == null
            ? null
            : Color.fromJson(json['color'] as Map<String, dynamic>),
        descriptions: json['descriptions'] as String?,
        shippingCost: json['shipping_cost'] as String?,
        createdAt: json['created_at'] as String?,
        discount: json['discount'] == null
            ? null
            : Discount.fromJson(json['discount'] as Map<String, dynamic>),
        productImage: (json['productImage'] as List<dynamic>?)
            ?.map((e) => ProductImage.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'price': price,
        'qty': qty,
        'size': size?.map((e) => e.toJson()).toList(),
        'memory': memory?.toJson(),
        'condition_type': conditionType,
        'delivery_type': deliveryType,
        'model': model,
        'hard_drive': hardDrive?.toJson(),
        'color': color?.toJson(),
        'descriptions': descriptions,
        'shipping_cost': shippingCost,
        'created_at': createdAt,
        'discount': discount?.toJson(),
        'productImage': productImage?.map((e) => e.toJson()).toList(),
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Datum) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      price.hashCode ^
      qty.hashCode ^
      size.hashCode ^
      memory.hashCode ^
      conditionType.hashCode ^
      deliveryType.hashCode ^
      model.hashCode ^
      hardDrive.hashCode ^
      color.hashCode ^
      descriptions.hashCode ^
      shippingCost.hashCode ^
      createdAt.hashCode ^
      discount.hashCode ^
      productImage.hashCode;
}
