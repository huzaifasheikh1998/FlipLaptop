// To parse this JSON data, do
//
//     final followerListModel = followerListModelFromJson(jsonString);

import 'dart:convert';

FollowerListModel followerListModelFromJson(String str) =>
    FollowerListModel.fromJson(json.decode(str));

String followerListModelToJson(FollowerListModel data) =>
    json.encode(data.toJson());

class FollowerListModel {
  String status;
  String message;
  List<StoreInstance> data;

  FollowerListModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FollowerListModel.fromJson(Map<String, dynamic> json) =>
      FollowerListModel(
        status: json["status"],
        message: json["message"],
        data: List<StoreInstance>.from(
            json["data"].map((x) => StoreInstance.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class StoreInstance {
  int? id;
  String? name;
  String? location;
  String? image;
  String? description;
  dynamic websiteLink;
  String? following;
  String? follower;
  String? productCount;
  List<Product>? product;

  StoreInstance({
    required this.id,
    required this.name,
    required this.location,
    required this.image,
    required this.description,
    required this.websiteLink,
    required this.following,
    required this.follower,
    required this.productCount,
    required this.product,
  });

  factory StoreInstance.fromJson(Map<String, dynamic> json) => StoreInstance(
        id: json["id"],
        name: json["name"],
        location: json["location"],
        image: json["image"],
        description: json["description"],
        websiteLink: json["website_link"],
        following: json["following"],
        follower: json["follower"],
        productCount: json["productCount"],
        product: json["product"] == null
            ? null
            : List<Product>.from(
                json["product"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "location": location,
        "image": image,
        "description": description,
        "website_link": websiteLink,
        "following": following,
        "follower": follower,
        "productCount": productCount,
        "product": List<dynamic>.from(product!.map((x) => x.toJson())),
      };
}

class Product {
  String? id;
  String? name;
  int? price;
  int? qty;
  String? conditionType;
  String? deliveryType;
  String? model;
  String? descriptions;
  String? createdAt;
  int? storeId;
  String? storeName;
  String? storeImage;
  String? shippingCost;
  String? avg;
  String? ratingCount;
  Brands? brands;
  Color? memory;
  Color? hardDrive;
  Color? color;
  Discount? discount;
  User? user;
  List<ProductImage>? productImage;
  List<Color>? size;
  List<dynamic>? review;

  Product({
    this.id,
    this.name,
    this.price,
    this.qty,
    this.conditionType,
    this.deliveryType,
    this.model,
    this.descriptions,
    this.createdAt,
    this.storeId,
    this.storeName,
    this.storeImage,
    this.shippingCost,
    this.avg,
    this.ratingCount,
    this.brands,
    this.memory,
    this.hardDrive,
    this.color,
    this.discount,
    this.user,
    this.productImage,
    this.size,
    this.review,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        qty: json["qty"],
        conditionType: json["condition_type"],
        deliveryType: json["delivery_type"],
        model: json["model"],
        descriptions: json["descriptions"],
        createdAt: json["created_at"],
        storeId: json["store_id"],
        storeName: json["store_name"],
        storeImage: json["store_image"],
        shippingCost: json["shipping_cost"],
        avg: json["avg"],
        ratingCount: json["ratingCount"],
        brands: Brands.fromJson(json["brands"]),
        memory: Color.fromJson(json["memory"]),
        hardDrive: Color.fromJson(json["hard_drive"]),
        color: Color.fromJson(json["color"]),
        discount: json["discount"] == null
            ? null
            : Discount.fromJson(json["discount"]),
        user: User.fromJson(json["user"]),
        productImage: List<ProductImage>.from(
            json["productImage"].map((x) => ProductImage.fromJson(x))),
        size: List<Color>.from(json["size"].map((x) => Color.fromJson(x))),
        review: List<dynamic>.from(json["review"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "qty": qty,
        "condition_type": conditionType,
        "delivery_type": deliveryType,
        "model": model,
        "descriptions": descriptions,
        "created_at": createdAt,
        "store_id": storeId,
        "store_name": storeName,
        "store_image": storeImage,
        "shipping_cost": shippingCost,
        "avg": avg,
        "ratingCount": ratingCount,
        "brands": brands?.toJson(),
        "memory": memory?.toJson(),
        "hard_drive": hardDrive?.toJson(),
        "color": color?.toJson(),
        "discount": discount?.toJson(),
        "user": user?.toJson(),
        "productImage":
            List<dynamic>.from(productImage!.map((x) => x.toJson())),
        "size": List<dynamic>.from(size!.map((x) => x.toJson())),
        "review": List<dynamic>.from(review!.map((x) => x)),
      };
}

class Brands {
  String id;
  String image;
  String name;

  Brands({
    required this.id,
    required this.image,
    required this.name,
  });

  factory Brands.fromJson(Map<String, dynamic> json) => Brands(
        id: json["id"],
        image: json["image"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "name": name,
      };
}

class Color {
  String id;
  String name;

  Color({
    required this.id,
    required this.name,
  });

  factory Color.fromJson(Map<String, dynamic> json) => Color(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class Discount {
  String id;
  String name;
  String type;
  String percentageTarget;
  String price;
  DateTime startDatetime;
  DateTime endDatetime;

  Discount({
    required this.id,
    required this.name,
    required this.type,
    required this.percentageTarget,
    required this.price,
    required this.startDatetime,
    required this.endDatetime,
  });

  factory Discount.fromJson(Map<String, dynamic> json) => Discount(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        percentageTarget: json["percentage_target"],
        price: json["price"],
        startDatetime: DateTime.parse(json["start_datetime"]),
        endDatetime: DateTime.parse(json["end_datetime"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
        "percentage_target": percentageTarget,
        "price": price,
        "start_datetime": startDatetime.toIso8601String(),
        "end_datetime": endDatetime.toIso8601String(),
      };
}

class ProductImage {
  int id;
  String name;

  ProductImage({
    required this.id,
    required this.name,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) => ProductImage(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class User {
  String id;
  String name;
  String email;
  String address;
  String phoneNumber;
  String image;
  String gender;
  bool notificationStatus;
  String otp;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.address,
    required this.phoneNumber,
    required this.image,
    required this.gender,
    required this.notificationStatus,
    required this.otp,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        address: json["address"],
        phoneNumber: json["phone_number"],
        image: json["image"],
        gender: json["gender"],
        notificationStatus: json["notification_status"],
        otp: json["otp"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "address": address,
        "phone_number": phoneNumber,
        "image": image,
        "gender": gender,
        "notification_status": notificationStatus,
        "otp": otp,
      };
}
