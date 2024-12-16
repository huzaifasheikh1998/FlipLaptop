// To parse this JSON data, do
//
//     final searchFilterProductListModel = searchFilterProductListModelFromJson(jsonString);

import 'dart:convert';

import 'package:app_fliplaptop/models/dashBoardModel.dart';

SearchFilterProductListModel searchFilterProductListModelFromJson(String str) => SearchFilterProductListModel.fromJson(json.decode(str));

String searchFilterProductListModelToJson(SearchFilterProductListModel data) => json.encode(data.toJson());

class SearchFilterProductListModel {
  final String? status;
  final String? message;
  final List<Datum>? data;

  SearchFilterProductListModel({
    this.status,
    this.message,
    this.data,
  });

  factory SearchFilterProductListModel.fromJson(Map<String, dynamic> json) => SearchFilterProductListModel(
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

