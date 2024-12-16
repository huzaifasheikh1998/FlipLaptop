// To parse this JSON data, do
//
//     final shippingAddress = shippingAddressFromJson(jsonString);

import 'dart:convert';

ShippingAddress shippingAddressFromJson(String str) =>
    ShippingAddress.fromJson(json.decode(str));

String shippingAddressToJson(ShippingAddress data) =>
    json.encode(data.toJson());

class ShippingAddress {
  String? status;
  String? message;
  List<ShippingModel>? data;

  ShippingAddress({
    this.status,
    this.message,
    this.data,
  });

  factory ShippingAddress.fromJson(Map<String, dynamic> json) =>
      ShippingAddress(
        status: json["status"],
        message: json["message"],
        data: List<ShippingModel>.from(
            json["data"].map((x) => ShippingModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ShippingModel {
  String? id;
  String? addressLine1;
  String? addressLine2;
  String? city;
  String? postalCode;
  String? country;
  String? mobileNumber;
  String? setAsDefault;

  ShippingModel({
    this.id,
    this.addressLine1,
    this.addressLine2,
    this.city,
    this.postalCode,
    this.country,
    this.mobileNumber,
    this.setAsDefault,
  });

  factory ShippingModel.fromJson(Map<dynamic, dynamic> json) => ShippingModel(
        id: json["id"],
        addressLine1: json["address_line1"],
        addressLine2: json["address_line2"],
        city: json["city"],
        postalCode: json["postal_code"],
        country: json["country"],
        mobileNumber: json["mobile_number"],
        setAsDefault: json["set_as_default"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "address_line1": addressLine1,
        "address_line2": addressLine2,
        "city": city,
        "postal_code": postalCode,
        "country": country,
        "mobile_number": mobileNumber,
        "set_as_default": setAsDefault,
      };
}
