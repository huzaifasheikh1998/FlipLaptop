// To parse this JSON data, do
//
//     final getStoreRating = getStoreRatingFromJson(jsonString);

import 'dart:convert';

GetStoreRating getStoreRatingFromJson(String str) => GetStoreRating.fromJson(json.decode(str));

String getStoreRatingToJson(GetStoreRating data) => json.encode(data.toJson());

class GetStoreRating {
  String? status;
  String? message;
  List<StoreRating>? data;

  GetStoreRating({
    this.status,
    this.message,
    this.data,
  });

  factory GetStoreRating.fromJson(Map<String, dynamic> json) => GetStoreRating(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<StoreRating>.from(json["data"]!.map((x) => StoreRating.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class StoreRating {
  String? id;
  String? rating;
  User? user;

  StoreRating({
    this.id,
    this.rating,
    this.user,
  });

  factory StoreRating.fromJson(Map<String, dynamic> json) => StoreRating(
    id: json["id"],
    rating: json["rating"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "rating": rating,
    "user": user?.toJson(),
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
    emailVerifiedAt: json["email_verified_at"] == null ? null : DateTime.parse(json["email_verified_at"]),
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
