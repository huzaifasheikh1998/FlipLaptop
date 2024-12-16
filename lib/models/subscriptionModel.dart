// To parse this JSON data, do
//
//     final subscriptionModel = subscriptionModelFromJson(jsonString);

import 'dart:convert';

SubscriptionModel subscriptionModelFromJson(String str) => SubscriptionModel.fromJson(json.decode(str));

String subscriptionModelToJson(SubscriptionModel data) => json.encode(data.toJson());

class SubscriptionModel {
  String? status;
  String? message;
  List<SubscriptionItem>? data;

  SubscriptionModel({
     this.status,
     this.message,
     this.data,
  });

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) => SubscriptionModel(
    status: json["status"],
    message: json["message"],
    data: List<SubscriptionItem>.from(json["data"].map((x) => SubscriptionItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x!.toJson())),
  };
}

class SubscriptionItem {
  String id;
  String name;
  String price;
  String duration;
  String stripePlanId;
  String stripePlanPriceId;
  String description;

  SubscriptionItem({
    required this.id,
    required this.name,
    required this.price,
    required this.duration,
    required this.stripePlanId,
    required this.stripePlanPriceId,
    required this.description,
  });

  factory SubscriptionItem.fromJson(Map<String, dynamic> json) => SubscriptionItem(
    id: json["id"],
    name: json["name"],
    price: json["price"],
    duration: json["duration"],
    stripePlanId: json["stripePlanID"],
    stripePlanPriceId: json["stripePlanPriceID"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
    "duration": duration,
    "stripePlanID": stripePlanId,
    "stripePlanPriceID": stripePlanPriceId,
    "description": description,
  };
}
