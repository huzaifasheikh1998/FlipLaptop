// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  bool status;
  List<UserModel> data;
  Authorisation authorisation;

  LoginModel({
    required this.status,
    required this.data,
    required this.authorisation,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        status: json["status"],
        data: List<UserModel>.from(
            json["data"].map((x) => UserModel.fromJson(x))),
        authorisation: Authorisation.fromJson(json["authorisation"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "authorisation": authorisation.toJson(),
      };
}

class Authorisation {
  String token;
  String type;

  Authorisation({
    required this.token,
    required this.type,
  });

  factory Authorisation.fromJson(Map<String, dynamic> json) => Authorisation(
        token: json["token"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "type": type,
      };
}

class Product {
  String id;
  String name;
  int price;
  String dealItemPrice;
  int qty;
  String stock;
  String conditionType;
  String deliveryType;
  String model;
  String descriptions;
  String createdAt;
  int storeId;
  String storeName;
  String storeImage;
  String taxStatus;
  String tax;
  String shippingCost;
  String avg;
  String ratingCount;
  Brands brands;
  ProductColor memory;
  ProductColor hardDrive;
  ProductColor color;
  Discount? discount;
  UserModel user;
  List<ProductImage> productImage;
  List<ProductColor> size;
  List<dynamic> review;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.dealItemPrice,
    required this.qty,
    required this.stock,
    required this.conditionType,
    required this.deliveryType,
    required this.model,
    required this.descriptions,
    required this.createdAt,
    required this.storeId,
    required this.storeName,
    required this.storeImage,
    required this.taxStatus,
    required this.tax,
    required this.shippingCost,
    required this.avg,
    required this.ratingCount,
    required this.brands,
    required this.memory,
    required this.hardDrive,
    required this.color,
    required this.discount,
    required this.user,
    required this.productImage,
    required this.size,
    required this.review,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        dealItemPrice: json["dealItemPrice"],
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
        brands: Brands.fromJson(json["brands"]),
        memory: ProductColor.fromJson(json["memory"]),
        hardDrive: ProductColor.fromJson(json["hard_drive"]),
        color: ProductColor.fromJson(json["color"]),
        discount: json["discount"] == null
            ? null
            : Discount.fromJson(json["discount"]),
        user: UserModel.fromJson(json["user"]),
        productImage: List<ProductImage>.from(
            json["productImage"].map((x) => ProductImage.fromJson(x))),
        size: List<ProductColor>.from(
            json["size"].map((x) => ProductColor.fromJson(x))),
        review: List<dynamic>.from(json["review"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "dealItemPrice": dealItemPrice,
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
        "brands": brands.toJson(),
        "memory": memory.toJson(),
        "hard_drive": hardDrive.toJson(),
        "color": color.toJson(),
        "discount": discount?.toJson(),
        "user": user.toJson(),
        "productImage": List<dynamic>.from(productImage.map((x) => x.toJson())),
        "size": List<dynamic>.from(size.map((x) => x.toJson())),
        "review": List<dynamic>.from(review.map((x) => x)),
      };
}

class Store {
  int? id;
  String? name;
  String? location;
  String? image;
  String? description;
  String? websiteLink;
  String? taxStatus;
  String? tax;
  String? stripeAccountId;
  String? following;
  String? follower;
  String? productCount;
  List<Product>? product;

  Store({
    this.id,
    this.name,
    this.location,
    this.image,
    this.description,
    this.websiteLink,
    this.taxStatus,
    this.tax,
    this.stripeAccountId,
    this.following,
    this.follower,
    this.productCount,
    this.product,
  });

  factory Store.fromJson(Map<String, dynamic> json) => Store(
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
        product:
            List<Product>.from(json["product"].map((x) => Product.fromJson(x))),
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
        "product": List<dynamic>.from(product!.map((x) => x.toJson())),
      };
}

class UserModel {
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
  ShipperAddress? shipperAddress;
  Payment? payment;
  Store? store;

  UserModel({
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
    this.shipperAddress,
    this.payment,
    this.store,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        image: json["image"],
        name: json["name"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        gender: json["gender"],
        otp: json["otp"],
        emailVerifiedAt: json["email_verified_at"] == ""
            ? null
            : DateTime.parse(json["email_verified_at"]),
        address: json["address"],
        deviceType: json["device_type"],
        socialDevice: json["social_device"],
        notificationStatus: json["notification_status"],
        deviceToken: json["device_token"],
        shipperAddress: json["shipper_address"] == null
            ? null
            : ShipperAddress.fromJson(json["shipper_address"]),
        payment:
            json["payment"] == null ? null : Payment.fromJson(json["payment"]),
        store: json["store"] == null ? null : Store.fromJson(json["store"]),
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
        "shipper_address": shipperAddress?.toJson(),
        "payment": payment?.toJson(),
        "store": store?.toJson(),
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

class ProductColor {
  String id;
  String name;

  ProductColor({
    required this.id,
    required this.name,
  });

  factory ProductColor.fromJson(Map<String, dynamic> json) => ProductColor(
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

class Payment {
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

  Payment({
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

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
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

class ShipperAddress {
  String id;
  String addressLine1;
  String addressLine2;
  String city;
  String postalCode;
  String country;
  String mobileNumber;
  String setAsDefault;

  ShipperAddress({
    required this.id,
    required this.addressLine1,
    required this.addressLine2,
    required this.city,
    required this.postalCode,
    required this.country,
    required this.mobileNumber,
    required this.setAsDefault,
  });

  factory ShipperAddress.fromJson(Map<String, dynamic> json) => ShipperAddress(
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
