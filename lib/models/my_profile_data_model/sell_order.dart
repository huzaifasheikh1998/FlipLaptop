import 'package:collection/collection.dart';

class SellOrder {
  List<dynamic>? neww;

  SellOrder({this.neww});

  factory SellOrder.fromJson(Map<String, dynamic> json) => SellOrder(
        neww: json['New'] as List<dynamic>?,
      );

  Map<String, dynamic> toJson() => {
        'New': neww,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! SellOrder) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => neww.hashCode;
}
