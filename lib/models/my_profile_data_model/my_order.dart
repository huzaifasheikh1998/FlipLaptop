import 'package:collection/collection.dart';

import 'purchased_order.dart';
import 'sell_order.dart';

class MyOrder {
  PurchasedOrder? purchasedOrder;
  SellOrder? sellOrder;

  MyOrder({this.purchasedOrder, this.sellOrder});

  factory MyOrder.fromJson(Map<String, dynamic> json) => MyOrder(
        purchasedOrder: json['purchased_order'] == null
            ? null
            : PurchasedOrder.fromJson(
                json['purchased_order'] as Map<String, dynamic>),
        sellOrder: json['sell_order'] == null
            ? null
            : SellOrder.fromJson(json['sell_order'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'purchased_order': purchasedOrder?.toJson(),
        'sell_order': sellOrder?.toJson(),
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! MyOrder) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => purchasedOrder.hashCode ^ sellOrder.hashCode;
}
