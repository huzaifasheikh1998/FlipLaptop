// To parse this JSON data, do
//
//     final dataWithDatumInstance = dataWithDatumInstanceFromJson(jsonString);

import 'dart:convert';

import 'dashBoardModel.dart';

DataWithStoreInstance dataWithStoreInstanceFromJson(String str) => DataWithStoreInstance.fromJson(json.decode(str));

String dataWithStoreInstanceToJson(DataWithStoreInstance data) => json.encode(data.toJson());

class DataWithStoreInstance {
  String? status;
  String? message;
  Data? data;

  DataWithStoreInstance({
     this.status,
     this.message,
     this.data,
  });

  factory DataWithStoreInstance.fromJson(Map<String, dynamic> json) => DataWithStoreInstance(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  int id;
  String name;
  String location;
  String image;
  String description;
  dynamic websiteLink;
  String taxStatus;
  String tax;
  dynamic stripeAccountId;
  String following;
  String follower;
  String productCount;
  List<Product> product;

  Data({
    required this.id,
    required this.name,
    required this.location,
    required this.image,
    required this.description,
    required this.websiteLink,
    required this.taxStatus,
    required this.tax,
    required this.stripeAccountId,
    required this.following,
    required this.follower,
    required this.productCount,
    required this.product,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    location: json["location"],
    image: json["image"],
    description: json["description"],
    websiteLink: json["website_link"],
    taxStatus: json["tax_status"],
    tax: json["tax"],
    stripeAccountId: json["stripe_account_id"],
    following: json["following"],
    follower: json["follower"],
    productCount: json["productCount"],
    product: List<Product>.from(json["product"].map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "location": location,
    "image": image,
    "description": description,
    "website_link": websiteLink,
    "tax_status": taxStatus,
    "tax": tax,
    "stripe_account_id": stripeAccountId,
    "following": following,
    "follower": follower,
    "productCount": productCount,
    "product": List<dynamic>.from(product.map((x) => x.toJson())),
  };
}



