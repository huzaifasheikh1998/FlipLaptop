// To parse this JSON data, do
//
//     final storeReviewModel = storeReviewModelFromJson(jsonString);

import 'dart:convert';

StoreReviewModel storeReviewModelFromJson(String str) => StoreReviewModel.fromJson(json.decode(str));

String storeReviewModelToJson(StoreReviewModel data) => json.encode(data.toJson());

class StoreReviewModel {
  String status;
  String message;
  List<StoreReview> data;

  StoreReviewModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory StoreReviewModel.fromJson(Map<String, dynamic> json) => StoreReviewModel(
    status: json["status"],
    message: json["message"],
    data: List<StoreReview>.from(json["data"].map((x) => StoreReview.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class StoreReview {
  String id;
  String rating;
  String description;
  String approved;
  String createdAt;
  List<dynamic> reviewImage;
  List<dynamic> reviewReply;
  User user;
  Product product;

  StoreReview({
    required this.id,
    required this.rating,
    required this.description,
    required this.approved,
    required this.createdAt,
    required this.reviewImage,
    required this.reviewReply,
    required this.user,
    required this.product,
  });

  factory StoreReview.fromJson(Map<String, dynamic> json) => StoreReview(
    id: json["id"],
    rating: json["rating"],
    description: json["description"],
    approved: json["approved"],
    createdAt: json["created_at"],
    reviewImage: List<dynamic>.from(json["review_image"].map((x) => x)),
    reviewReply: List<dynamic>.from(json["review_reply"].map((x) => x)),
    user: User.fromJson(json["user"]),
    product: Product.fromJson(json["product"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "rating": rating,
    "description": description,
    "approved": approved,
    "created_at": createdAt,
    "review_image": List<dynamic>.from(reviewImage.map((x) => x)),
    "review_reply": List<dynamic>.from(reviewReply.map((x) => x)),
    "user": user.toJson(),
    "product": product.toJson(),
  };
}

class Product {
  String id;
  String name;
  int price;
  String dealItemPrice;
  String dealItemStartDatetime;
  String dealItemEndDatetime;
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
  Color memory;
  Color hardDrive;
  Color color;
  dynamic discount;
  User user;
  List<ProductImage> productImage;
  List<Color> size;
  List<Review> review;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.dealItemPrice,
    required this.dealItemStartDatetime,
    required this.dealItemEndDatetime,
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
    dealItemStartDatetime: json["dealItemStartDatetime"],
    dealItemEndDatetime: json["dealItemEndDatetime"],
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
    memory: Color.fromJson(json["memory"]),
    hardDrive: Color.fromJson(json["hard_drive"]),
    color: Color.fromJson(json["color"]),
    discount: json["discount"],
    user: User.fromJson(json["user"]),
    productImage: List<ProductImage>.from(json["productImage"].map((x) => ProductImage.fromJson(x))),
    size: List<Color>.from(json["size"].map((x) => Color.fromJson(x))),
    review: List<Review>.from(json["review"].map((x) => Review.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
    "dealItemPrice": dealItemPrice,
    "dealItemStartDatetime": dealItemStartDatetime,
    "dealItemEndDatetime": dealItemEndDatetime,
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
    "discount": discount,
    "user": user.toJson(),
    "productImage": List<dynamic>.from(productImage.map((x) => x.toJson())),
    "size": List<dynamic>.from(size.map((x) => x.toJson())),
    "review": List<dynamic>.from(review.map((x) => x.toJson())),
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

class Review {
  String id;
  String rating;
  String description;
  String approved;
  User user;
  List<dynamic> reviewImage;

  Review({
    required this.id,
    required this.rating,
    required this.description,
    required this.approved,
    required this.user,
    required this.reviewImage,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
    id: json["id"],
    rating: json["rating"],
    description: json["description"],
    approved: json["approved"],
    user: User.fromJson(json["user"]),
    reviewImage: List<dynamic>.from(json["review_image"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "rating": rating,
    "description": description,
    "approved": approved,
    "user": user.toJson(),
    "review_image": List<dynamic>.from(reviewImage.map((x) => x)),
  };
}

class User {
  String id;
  String image;
  String name;
  String email;
  String phoneNumber;
  String gender;
  String otp;
  DateTime emailVerifiedAt;
  String address;
  String deviceType;
  String socialDevice;
  bool notificationStatus;
  String deviceToken;

  User({
    required this.id,
    required this.image,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.gender,
    required this.otp,
    required this.emailVerifiedAt,
    required this.address,
    required this.deviceType,
    required this.socialDevice,
    required this.notificationStatus,
    required this.deviceToken,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    image: json["image"],
    name: json["name"],
    email: json["email"],
    phoneNumber: json["phone_number"],
    gender: json["gender"],
    otp: json["otp"],
    emailVerifiedAt: DateTime.parse(json["email_verified_at"]),
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
    "email_verified_at": emailVerifiedAt.toIso8601String(),
    "address": address,
    "device_type": deviceType,
    "social_device": socialDevice,
    "notification_status": notificationStatus,
    "device_token": deviceToken,
  };
}
