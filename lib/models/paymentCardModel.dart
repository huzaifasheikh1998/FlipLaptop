// To parse this JSON data, do
//
//     final paymentCardModel = paymentCardModelFromJson(jsonString);

import 'dart:convert';

PaymentCardModel paymentCardModelFromJson(String str) => PaymentCardModel.fromJson(json.decode(str));

String paymentCardModelToJson(PaymentCardModel data) => json.encode(data.toJson());

class PaymentCardModel {
  String status;
  String message;
  List<CardModel> data;

  PaymentCardModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory PaymentCardModel.fromJson(Map<String, dynamic> json) => PaymentCardModel(
    status: json["status"],
    message: json["message"],
    data: List<CardModel>.from(json["data"].map((x) => CardModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class CardModel {
  String? id;
  String? name;
  String? cardNumber;
  String? expDate;
  String? cvcCvv;
  String? stripeCreateId;
  String? setAsDefault;
  String? brand;
  String? country;
  String? cvcCheck;
  String? fingerprint;
  String? last4;
  String? funding;

  CardModel({
    this.id,
     this.name,
     this.cardNumber,
     this.expDate,
     this.cvcCvv,
     this.stripeCreateId,
     this.setAsDefault,
     this.brand,
     this.country,
     this.cvcCheck,
     this.fingerprint,
     this.last4,
     this.funding,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) => CardModel(
    id: json["id"],
    name: json["name"],
    cardNumber: json["card_number"],
    expDate: json["exp_date"],
    cvcCvv: json["cvc_cvv"],
    stripeCreateId: json["stripe_create_id"],
    setAsDefault: json["set_as_default"],
    brand: json["brand"],
    country: json["country"],
    cvcCheck: json["cvc_check"],
    fingerprint: json["fingerprint"],
    last4: json["last4"],
    funding: json["funding"],
  );

  Map<String, dynamic> toJson() => {
    "id":id,
    "name": name,
    "card_number": cardNumber,
    "exp_date": expDate,
    "cvc_cvv": cvcCvv,
    "stripe_create_id": stripeCreateId,
    "set_as_default": setAsDefault,
    "brand": brand,
    "country": country,
    "cvc_check": cvcCheck,
    "fingerprint": fingerprint,
    "last4": last4,
    "funding": funding,
  };
}
