// To parse this JSON data, do
//
//     final wishListModel = wishListModelFromJson(jsonString);

import 'dart:convert';

WishListModel wishListModelFromJson(String str) =>
    WishListModel.fromJson(json.decode(str));

String wishListModelToJson(WishListModel data) => json.encode(data.toJson());

class WishListModel {
  String? status;
  String? message;
  List<WishListItem>? data;

  WishListModel({
    this.status,
    this.message,
    this.data,
  });

  factory WishListModel.fromJson(Map<String, dynamic> json) => WishListModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<WishListItem>.from(
                json["data"]!.map((x) => WishListItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class WishListItem {
  String? id;
  String? name;
  int? price;
  String? dealItemPrice;
  String? dealItemStartDatetime;
  String? dealItemEndDatetime;
  String? dealItemPercentage;
  int? qty;
  String? stock;
  String? conditionType;
  String? deliveryType;
  String? model;
  String? descriptions;
  String? createdAt;
  int? storeId;
  String? storeName;
  String? storeImage;
  String? taxStatus;
  String? tax;
  String? shippingCost;
  String? avg;
  String? ratingCount;
  Brands? brands;
  Color? memory;
  Color? hardDrive;
  Color? color;
  dynamic discount;
  User? user;
  List<ProductImage>? productImage;
  List<Color>? size;
  List<dynamic>? review;

  WishListItem({
    this.id,
    this.name,
    this.price,
    this.dealItemPrice,
    this.dealItemStartDatetime,
    this.dealItemEndDatetime,
    this.dealItemPercentage,
    this.qty,
    this.stock,
    this.conditionType,
    this.deliveryType,
    this.model,
    this.descriptions,
    this.createdAt,
    this.storeId,
    this.storeName,
    this.storeImage,
    this.taxStatus,
    this.tax,
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

  factory WishListItem.fromJson(Map<String, dynamic> json) => WishListItem(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        dealItemPrice: json["dealItemPrice"],
        dealItemStartDatetime: json["dealItemStartDatetime"] == null
            ? null
            : json["dealItemStartDatetime"],
        dealItemEndDatetime: json["dealItemEndDatetime"] == null
            ? null
            : json["dealItemEndDatetime"],
        dealItemPercentage: json["dealItemPercentage"],
        qty: json["qty"],
        stock: json["stock"],
        conditionType: json["condition_type"],
        deliveryType: json["delivery_type"],
        model: json["model"],
        descriptions: json["descriptions"],
        createdAt: json["created_at"],
        storeId: json["store_id"],
        storeName: json["store_name"],
        storeImage: json["store_image"],
        taxStatus: json["tax_status"],
        tax: json["tax"],
        shippingCost: json["shipping_cost"],
        avg: json["avg"],
        ratingCount: json["ratingCount"],
        brands: json["brands"] == null ? null : Brands.fromJson(json["brands"]),
        memory: json["memory"] == null ? null : Color.fromJson(json["memory"]),
        hardDrive: json["hard_drive"] == null
            ? null
            : Color.fromJson(json["hard_drive"]),
        color: json["color"] == null ? null : Color.fromJson(json["color"]),
        discount: json["discount"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        productImage: json["productImage"] == null
            ? []
            : List<ProductImage>.from(
                json["productImage"]!.map((x) => ProductImage.fromJson(x))),
        size: json["size"] == null
            ? []
            : List<Color>.from(json["size"]!.map((x) => Color.fromJson(x))),
        review: json["review"] == null
            ? []
            : List<dynamic>.from(json["review"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "dealItemPrice": dealItemPrice,
        "dealItemStartDatetime": dealItemStartDatetime,
        "dealItemEndDatetime": dealItemEndDatetime,
        "dealItemPercentage": dealItemPercentage,
        "qty": qty,
        "stock": stock,
        "condition_type": conditionType,
        "delivery_type": deliveryType,
        "model": model,
        "descriptions": descriptions,
        "created_at": createdAt,
        "store_id": storeId,
        "store_name": storeName,
        "store_image": storeImage,
        "tax_status": taxStatus,
        "tax": tax,
        "shipping_cost": shippingCost,
        "avg": avg,
        "ratingCount": ratingCount,
        "brands": brands?.toJson(),
        "memory": memory?.toJson(),
        "hard_drive": hardDrive?.toJson(),
        "color": color?.toJson(),
        "discount": discount,
        "user": user?.toJson(),
        "productImage": productImage == null
            ? []
            : List<dynamic>.from(productImage!.map((x) => x.toJson())),
        "size": size == null
            ? []
            : List<dynamic>.from(size!.map((x) => x.toJson())),
        "review":
            review == null ? [] : List<dynamic>.from(review!.map((x) => x)),
      };
}

class Brands {
  String? id;
  String? image;
  String? name;

  Brands({
    this.id,
    this.image,
    this.name,
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
  String? id;
  String? name;

  Color({
    this.id,
    this.name,
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

class ProductImage {
  int? id;
  String? name;

  ProductImage({
    this.id,
    this.name,
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
  String? id;
  String? image;
  String? name;
  String? email;
  String? phoneNumber;
  String? gender;
  String? otp;
  DateTime? emailVerifiedAt;
  String? address;
  String? deviceType;
  String? socialDevice;
  bool? notificationStatus;
  String? deviceToken;

  User({
    this.id,
    this.image,
    this.name,
    this.email,
    this.phoneNumber,
    this.gender,
    this.otp,
    this.emailVerifiedAt,
    this.address,
    this.deviceType,
    this.socialDevice,
    this.notificationStatus,
    this.deviceToken,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        image: json["image"],
        name: json["name"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        gender: json["gender"],
        otp: json["otp"],
        emailVerifiedAt: json["email_verified_at"] == null
            ? null
            : DateTime.parse(json["email_verified_at"]),
        address: json["address"],
        deviceType: json["device_type"],
        socialDevice: json["social_device"],
        notificationStatus: json["notification_status"],
        deviceToken: json["device_token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "name": name,
        "email": email,
        "phone_number": phoneNumber,
        "gender": gender,
        "otp": otp,
        "email_verified_at": emailVerifiedAt?.toIso8601String(),
        "address": address,
        "device_type": deviceType,
        "social_device": socialDevice,
        "notification_status": notificationStatus,
        "device_token": deviceToken,
      };
}
