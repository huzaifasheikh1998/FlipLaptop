// To parse this JSON data, do
//
//     final getYourFollowers = getYourFollowersFromJson(jsonString);

import 'dart:convert';

GetYourFollowers getYourFollowersFromJson(String str) => GetYourFollowers.fromJson(json.decode(str));

String getYourFollowersToJson(GetYourFollowers data) => json.encode(data.toJson());

class GetYourFollowers {
  String? status;
  String? message;
  List<Follower>? data;

  GetYourFollowers({
    this.status,
    this.message,
    this.data,
  });

  factory GetYourFollowers.fromJson(Map<String, dynamic> json) => GetYourFollowers(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<Follower>.from(json["data"]!.map((x) => Follower.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Follower {
  int? id;
  String? name;
  String? image;
  String? address;
  String? email;
  String? password;
  DateTime? emailVerifiedAt;
  int? roleId;
  int? isNewUser;
  int? status;
  dynamic rememberToken;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? deviceToken;
  String? phoneNumber;
  String? gender;
  String? otpCode;
  String? deviceType;
  String? notificationStatus;
  String? socialDevice;

  Follower({
    this.id,
    this.name,
    this.image,
    this.address,
    this.email,
    this.password,
    this.emailVerifiedAt,
    this.roleId,
    this.isNewUser,
    this.status,
    this.rememberToken,
    this.createdAt,
    this.updatedAt,
    this.deviceToken,
    this.phoneNumber,
    this.gender,
    this.otpCode,
    this.deviceType,
    this.notificationStatus,
    this.socialDevice,
  });

  factory Follower.fromJson(Map<String, dynamic> json) => Follower(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    address: json["address"],
    email: json["email"],
    password: json["password"],
    emailVerifiedAt: json["email_verified_at"] == null ? null : DateTime.parse(json["email_verified_at"]),
    roleId: json["role_id"],
    isNewUser: json["is_new_user"],
    status: json["status"],
    rememberToken: json["remember_token"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deviceToken: json["device_token"],
    phoneNumber: json["phone_number"],
    gender: json["gender"],
    otpCode: json["otp_code"],
    deviceType: json["device_type"],
    notificationStatus: json["notification_status"],
    socialDevice: json["social_device"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "address": address,
    "email": email,
    "password": password,
    "email_verified_at": emailVerifiedAt?.toIso8601String(),
    "role_id": roleId,
    "is_new_user": isNewUser,
    "status": status,
    "remember_token": rememberToken,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "device_token": deviceToken,
    "phone_number": phoneNumber,
    "gender": gender,
    "otp_code": otpCode,
    "device_type": deviceType,
    "notification_status": notificationStatus,
    "social_device": socialDevice,
  };
}
