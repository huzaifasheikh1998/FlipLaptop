// To parse this JSON data, do
//
//     final myProfileDataModel = myProfileDataModelFromJson(jsonString);

import 'dart:convert';

MyProfileDataModel myProfileDataModelFromJson(String str) => MyProfileDataModel.fromJson(json.decode(str));

String myProfileDataModelToJson(MyProfileDataModel data) => json.encode(data.toJson());

class MyProfileDataModel {
  String status;
  String message;
  List<Data?> data;

  MyProfileDataModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory MyProfileDataModel.fromJson(Map<dynamic, dynamic> json) => MyProfileDataModel(
    status: json["status"],
    message: json["message"],
    data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x!.toJson())),
  };
}

class Data {
  String id;
  String image;
  String name;
  String email;
  String phoneNumber;
  String gender;
  String otp;
  String emailVerifiedAt;
  String address;
  String deviceType;
  String socialDevice;
  bool notificationStatus;
  String deviceToken;

  Data({
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

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    image: json["image"],
    name: json["name"],
    email: json["email"],
    phoneNumber: json["phone_number"],
    gender: json["gender"],
    otp: json["otp"],
    emailVerifiedAt: json["email_verified_at"],
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
    "email_verified_at": emailVerifiedAt,
    "address": address,
    "device_type": deviceType,
    "social_device": socialDevice,
    "notification_status": notificationStatus,
    "device_token": deviceToken,
  };
}
