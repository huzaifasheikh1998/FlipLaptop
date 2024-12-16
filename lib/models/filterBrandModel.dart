// To parse this JSON data, do
//
//     final filterBrandModel = filterBrandModelFromJson(jsonString);

import 'dart:convert';

import 'package:app_fliplaptop/models/dashBoardModel.dart';

FilterBrandModel filterBrandModelFromJson(String str) => FilterBrandModel.fromJson(json.decode(str));

String filterBrandModelToJson(FilterBrandModel data) => json.encode(data.toJson());

class FilterBrandModel {
  String? status;
  String? message;
  List<Datum>? data;

  FilterBrandModel({
    this.status,
    this.message,
    this.data,
  });

  factory FilterBrandModel.fromJson(Map<String, dynamic> json) => FilterBrandModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}


