/// this is the model which we make to add the item to the cart and we take list of
/// datum and a quantity with is 1 by default and this was done mainly for the
/// price calculation
///
///
import 'dart:convert';

import 'package:app_fliplaptop/models/dashBoardModel.dart';

CartItem cartItemFromJson(String str) => CartItem.fromJson(json.decode(str));
String cartItemToJson(CartItem data) => json.encode(data.toJson());

class CartItem {
  Datum datum;

  /// tells about the quantity of specific
  /// product added in cart
  int quantity;

  CartItem( {
    required this.datum,
    required this.quantity,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
    quantity: json["quantity"],
    datum: Datum.fromJson(json["datum"]),
  );

  Map<String, dynamic> toJson() => {
    "quantity": quantity,
    "datum": datum.toJson(),
  };
}