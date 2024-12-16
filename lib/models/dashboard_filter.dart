// To parse this JSON data, do
//
//     final dashBoardFilter = dashBoardFilterFromJson(jsonString);

import 'dart:convert';

import 'package:app_fliplaptop/models/dashBoardModel.dart';

DashBoardFilter dashBoardFilterFromJson(String str) => DashBoardFilter.fromJson(json.decode(str));

String dashBoardFilterToJson(DashBoardFilter data) => json.encode(data.toJson());

class DashBoardFilter {
  final String? status;
  final String? message;
  final Data? data;

  DashBoardFilter({
    this.status,
    this.message,
    this.data,
  });

  factory DashBoardFilter.fromJson(Map<String, dynamic> json) => DashBoardFilter(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  final Product? newArrivalProduct;
  final Product? moreProduct;

  Data({
    this.newArrivalProduct,
    this.moreProduct,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    newArrivalProduct: json["new_arrival_product"] == null ? null : Product.fromJson(json["new_arrival_product"]),
    moreProduct: json["more_product"] == null ? null : Product.fromJson(json["more_product"]),
  );

  Map<String, dynamic> toJson() => {
    "new_arrival_product": newArrivalProduct?.toJson(),
    "more_product": moreProduct?.toJson(),
  };
}



