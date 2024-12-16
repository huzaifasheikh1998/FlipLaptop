import 'package:collection/collection.dart';

class Discount {
  String? id;
  String? name;
  String? type;
  String? percentageTarget;
  String? price;
  String? startDatetime;
  String? endDatetime;

  Discount({
    this.id,
    this.name,
    this.type,
    this.percentageTarget,
    this.price,
    this.startDatetime,
    this.endDatetime,
  });

  factory Discount.fromJson(Map<String, dynamic> json) => Discount(
        id: json['id'] as String?,
        name: json['name'] as String?,
        type: json['type'] as String?,
        percentageTarget: json['percentage_target'] as String?,
        price: json['price'] as String?,
        startDatetime: json['start_datetime'] as String?,
        endDatetime: json['end_datetime'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'type': type,
        'percentage_target': percentageTarget,
        'price': price,
        'start_datetime': startDatetime,
        'end_datetime': endDatetime,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Discount) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      type.hashCode ^
      percentageTarget.hashCode ^
      price.hashCode ^
      startDatetime.hashCode ^
      endDatetime.hashCode;
}
