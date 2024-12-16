// To parse this JSON data, do
//
//     final sellOrderModel = sellOrderModelFromJson(jsonString);

import 'dart:convert';

import 'dashBoardModel.dart';

SellOrderModel sellOrderModelFromJson(String str) =>
    SellOrderModel.fromJson(json.decode(str));

String sellOrderModelToJson(SellOrderModel data) => json.encode(data.toJson());

class SellOrderModel {
  String status;
  String message;
  List<SellerData>? data;

  SellOrderModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SellOrderModel.fromJson(Map<String, dynamic> json) => SellOrderModel(
        status: json["status"].toString(),
        message: json["message"],
        data: json["data"] == null
            ? null
            : List<SellerData>.from(
                json["data"].map((x) => SellerData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class SellerData {
  String id;
  String totalAmount;
  String paymentStatus;
  String paymentType;
  String transactionId;
  String orderStatus;
  List<Product> product;
  User user;
  UserCard userCard;
  UserAddress userAddress;

  SellerData({
    required this.id,
    required this.totalAmount,
    required this.paymentStatus,
    required this.paymentType,
    required this.transactionId,
    required this.orderStatus,
    required this.product,
    required this.user,
    required this.userCard,
    required this.userAddress,
  });

  factory SellerData.fromJson(Map<String, dynamic> json) => SellerData(
        id: json["id"],
        totalAmount: json["total_amount"],
        paymentStatus: json["payment_status"],
        paymentType: json["payment_type"],
        transactionId: json["transaction_id"],
        orderStatus: json["order_status"],
        product:
            List<Product>.from(json["product"].map((x) => Product.fromJson(x))),
        user: User.fromJson(json["user"]),
        userCard: json["userCard"] == ""
            ? UserCard(
                id: "id",
                name: "name",
                cardNumber: "cardNumber",
                expDate: "expDate",
                cvcCvv: "cvcCvv",
                stripeCreateId: "stripeCreateId",
                stripeCustomerId: "stripeCustomerId",
                setAsDefault: "setAsDefault",
                brand: "brand",
                country: "country",
                cvcCheck: "cvcCheck",
                fingerprint: "fingerprint",
                last4: "last4",
                funding: "funding")
            : UserCard.fromJson(json["userCard"]),
        userAddress: UserAddress.fromJson(json["userAddress"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "total_amount": totalAmount,
        "payment_status": paymentStatus,
        "payment_type": paymentType,
        "transaction_id": transactionId,
        "order_status": orderStatus,
        "product": List<dynamic>.from(product.map((x) => x.toJson())),
        "user": user.toJson(),
        "userCard": userCard.toJson(),
        "userAddress": userAddress.toJson(),
      };
}

class Product {
  String? id;
  String? orderProductId;
  String? orderProductQty;
  String? orderProductStatus;
  String? name;
  String? price;
  String? qty;
  String? conditionType;
  String? deliveryType;
  String? model;
  String? descriptions;
  Brands? brands;
  Color? memory;
  Color? hardDrive;
  Color? color;
  Discount? discount;
  List<ProductImage>? productImage;
  List<Color>? size;
  List<dynamic>? review;

  Product({
    this.id,
    this.orderProductId,
    this.orderProductQty,
    this.orderProductStatus,
    this.name,
    this.price,
    this.qty,
    this.conditionType,
    this.deliveryType,
    this.model,
    this.descriptions,
    this.brands,
    this.memory,
    this.hardDrive,
    this.color,
    this.discount,
    this.productImage,
    this.size,
    this.review,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        orderProductId: json["order_product_id"],
        orderProductQty: json["order_product_qty"],
        orderProductStatus: json["order_product_status"],
        name: json["name"],
        price: json["price"],
        qty: json["qty"],
        conditionType: json["condition_type"],
        deliveryType: json["delivery_type"],
        model: json["model"],
        descriptions: json["descriptions"],
        brands: Brands.fromJson(json["brands"]),
        memory: Color.fromJson(json["memory"]),
        hardDrive: Color.fromJson(json["hard_drive"]),
        color: Color.fromJson(json["color"]),
        discount:
            json["discount"] == "" ? null : Discount.fromJson(json["discount"]),
        productImage: List<ProductImage>.from(
            json["productImage"].map((x) => ProductImage.fromJson(x))),
        size: List<Color>.from(json["size"].map((x) => Color.fromJson(x))),
        review: List<dynamic>.from(json["review"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_product_id": orderProductId,
        "order_product_qty": orderProductQty,
        "order_product_status": orderProductStatus,
        "name": name,
        "price": price,
        "qty": qty,
        "condition_type": conditionType,
        "delivery_type": deliveryType,
        "model": model,
        "descriptions": descriptions,
        "brands": brands?.toJson(),
        "memory": memory?.toJson(),
        "hard_drive": hardDrive?.toJson(),
        "color": color?.toJson(),
        "discount": discount?.toJson(),
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

// class User {
//   String id;
//   String image;
//   String name;
//   String email;
//   String phoneNumber;
//   String gender;
//   String otp;
//   DateTime emailVerifiedAt;
//   String address;
//   String deviceType;
//   String socialDevice;
//   bool notificationStatus;
//   String deviceToken;
//
//   User({
//     required this.id,
//     required this.image,
//     required this.name,
//     required this.email,
//     required this.phoneNumber,
//     required this.gender,
//     required this.otp,
//     required this.emailVerifiedAt,
//     required this.address,
//     required this.deviceType,
//     required this.socialDevice,
//     required this.notificationStatus,
//     required this.deviceToken,
//   });
//
//   factory User.fromJson(Map<String, dynamic> json) => User(
//     id: json["id"],
//     image: json["image"],
//     name: json["name"],
//     email: json["email"],
//     phoneNumber: json["phone_number"],
//     gender: json["gender"],
//     otp: json["otp"],
//     emailVerifiedAt: DateTime.parse(json["email_verified_at"]),
//     address: json["address"],
//     deviceType: json["device_type"],
//     socialDevice: json["social_device"],
//     notificationStatus: json["notification_status"],
//     deviceToken: json["device_token"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "image": image,
//     "name": name,
//     "email": email,
//     "phone_number": phoneNumber,
//     "gender": gender,
//     "otp": otp,
//     "email_verified_at": emailVerifiedAt.toIso8601String(),
//     "address": address,
//     "device_type": deviceType,
//     "social_device": socialDevice,
//     "notification_status": notificationStatus,
//     "device_token": deviceToken,
//   };
// }

class UserAddress {
  String id;
  String addressLine1;
  String addressLine2;
  String city;
  String postalCode;
  String country;
  String mobileNumber;
  String setAsDefault;

  UserAddress({
    required this.id,
    required this.addressLine1,
    required this.addressLine2,
    required this.city,
    required this.postalCode,
    required this.country,
    required this.mobileNumber,
    required this.setAsDefault,
  });

  factory UserAddress.fromJson(Map<String, dynamic> json) => UserAddress(
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

class UserCard {
  String id;
  String name;
  String cardNumber;
  String expDate;
  String cvcCvv;
  String stripeCreateId;
  String stripeCustomerId;
  String setAsDefault;
  String brand;
  String country;
  String cvcCheck;
  String fingerprint;
  String last4;
  String funding;

  UserCard({
    required this.id,
    required this.name,
    required this.cardNumber,
    required this.expDate,
    required this.cvcCvv,
    required this.stripeCreateId,
    required this.stripeCustomerId,
    required this.setAsDefault,
    required this.brand,
    required this.country,
    required this.cvcCheck,
    required this.fingerprint,
    required this.last4,
    required this.funding,
  });

  factory UserCard.fromJson(Map<String, dynamic> json) => UserCard(
        id: json["id"],
        name: json["name"],
        cardNumber: json["card_number"],
        expDate: json["exp_date"],
        cvcCvv: json["cvc_cvv"],
        stripeCreateId: json["stripe_create_id"],
        stripeCustomerId: json["stripe_customer_id"],
        setAsDefault: json["set_as_default"],
        brand: json["brand"],
        country: json["country"],
        cvcCheck: json["cvc_check"],
        fingerprint: json["fingerprint"],
        last4: json["last4"],
        funding: json["funding"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "card_number": cardNumber,
        "exp_date": expDate,
        "cvc_cvv": cvcCvv,
        "stripe_create_id": stripeCreateId,
        "stripe_customer_id": stripeCustomerId,
        "set_as_default": setAsDefault,
        "brand": brand,
        "country": country,
        "cvc_check": cvcCheck,
        "fingerprint": fingerprint,
        "last4": last4,
        "funding": funding,
      };
}
