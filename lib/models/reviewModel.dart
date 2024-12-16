// To parse this JSON data, do
//
//     final reviewModel = reviewModelFromJson(jsonString);

import 'dart:convert';

ReviewModel reviewModelFromJson(String str) => ReviewModel.fromJson(json.decode(str));
PostReviewModel postReviewModelFromJson(String str) => PostReviewModel.fromJson(json.decode(str));

String reviewModelToJson(ReviewModel data) => json.encode(data.toJson());


class PostReviewModel {
  String? status;
  String? message;
  ReviewDatum? data;

  PostReviewModel({
    this.status,
    this.message,
    this.data,
  });

  factory PostReviewModel.fromJson(Map<String, dynamic> json) => PostReviewModel(
    status: json["status"],
    message: json["message"],
    data: ReviewDatum.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data!.toJson(),
  };
}

class ReviewModel {
  String? status;
  String? message;
  List<ReviewDatum>? data;

  ReviewModel({
     this.status,
     this.message,
     this.data,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) => ReviewModel(
    status: json["status"],
    message: json["message"],
    data: List<ReviewDatum>.from(json["data"].map((x) => ReviewDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class ReviewDatum {
  String? id;
  String? rating;
  String? description;
  String? approved;
  String? createdAt;
  List<ReviewImage>? reviewImage;
  List<ReviewReply>? reviewReply;
  User? user;
  Product? product;

  ReviewDatum({
    this.id,
    this.rating,
    this.description,
    this.approved,
    this.createdAt,
    this.reviewImage,
    this.reviewReply,
    this.user,
    this.product,
  });

  factory ReviewDatum.fromJson(Map<String, dynamic> json) => ReviewDatum(
    id: json["id"],
    rating: json["rating"],
    description: json["description"],
    approved: json["approved"],
    createdAt: json["created_at"],
    reviewImage: json["review_image"] == null ? [] : List<ReviewImage>.from(json["review_image"]!.map((x) => ReviewImage.fromJson(x))),
    reviewReply: json["review_reply"] == null ? [] : List<ReviewReply>.from(json["review_reply"]!.map((x) => ReviewReply.fromJson(x))),
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    product: json["product"] == null ? null : Product.fromJson(json["product"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "rating": rating,
    "description": description,
    "approved": approved,
    "created_at": createdAt,
    "review_image": reviewImage == null ? [] : List<dynamic>.from(reviewImage!.map((x) => x.toJson())),
    "review_reply": reviewReply == null ? [] : List<dynamic>.from(reviewReply!.map((x) => x.toJson())),
    "user": user?.toJson(),
    "product": product?.toJson(),
  };
}

class ReviewReply {
  String? id;
  String? description;
  String? createdAt;

  ReviewReply({
    this.id,
    this.description,
    this.createdAt,
  });

  factory ReviewReply.fromJson(Map<String, dynamic> json) => ReviewReply(
    id: json["id"],
    description: json["description"],
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "description": description,
    "created_at": createdAt,
  };
}


class Product {
  String id;
  String name;
  int price;
  int qty;
  String conditionType;
  String deliveryType;
  String model;
  String descriptions;
  String createdAt;
  int storeId;
  String storeName;
  String storeImage;
  String shippingCost;
  String avg;
  String ratingCount;
  Brands brands;
  dynamic memory;
  dynamic hardDrive;
  dynamic color;
  dynamic discount;
  User user;
  List<ProductImage> productImage;
  List<dynamic> size;
  List<Review> review;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.qty,
    required this.conditionType,
    required this.deliveryType,
    required this.model,
    required this.descriptions,
    required this.createdAt,
    required this.storeId,
    required this.storeName,
    required this.storeImage,
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
    memory: json["memory"],
    hardDrive: json["hard_drive"],
    color: json["color"],
    discount: json["discount"],
    user: User.fromJson(json["user"]),
    productImage: List<ProductImage>.from(json["productImage"].map((x) => ProductImage.fromJson(x))),
    size: List<dynamic>.from(json["size"].map((x) => x)),
    review: List<Review>.from(json["review"].map((x) => Review.fromJson(x))),
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
    "brands": brands.toJson(),
    "memory": memory,
    "hard_drive": hardDrive,
    "color": color,
    "discount": discount,
    "user": user.toJson(),
    "productImage": List<dynamic>.from(productImage.map((x) => x.toJson())),
    "size": List<dynamic>.from(size.map((x) => x)),
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
  List<ReviewImage> reviewImage;

  Review({
    required this.id,
    required this.rating,
    required this.description,
    required this.approved,
    required this.reviewImage,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
    id: json["id"],
    rating: json["rating"],
    description: json["description"],
    approved: json["approved"],
    reviewImage: List<ReviewImage>.from(json["review_image"].map((x) => ReviewImage.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "rating": rating,
    "description": description,
    "approved": approved,
    "review_image": List<dynamic>.from(reviewImage.map((x) => x.toJson())),
  };
}

class ReviewImage {
  String id;
  String image;

  ReviewImage({
    required this.id,
    required this.image,
  });

  factory ReviewImage.fromJson(Map<String, dynamic> json) => ReviewImage(
    id: json["id"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
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
