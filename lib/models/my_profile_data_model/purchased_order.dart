import 'package:collection/collection.dart';

class PurchasedOrder {
  List<dynamic>? all;

  PurchasedOrder({this.all});

  factory PurchasedOrder.fromJson(Map<String, dynamic> json) {
    return PurchasedOrder(
      all: json['all'] as List<dynamic>?,
    );
  }

  Map<String, dynamic> toJson() => {
        'all': all,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! PurchasedOrder) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => all.hashCode;
}
