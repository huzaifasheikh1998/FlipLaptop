// To parse this JSON data, do
//
//     final filterModel = filterModelFromJson(jsonString);

import 'dart:convert';

FilterModel filterModelFromJson(String str) => FilterModel.fromJson(json.decode(str));

String filterModelToJson(FilterModel data) => json.encode(data.toJson());

class FilterModel {
  String? status;
  String? message;
  AllFiltersData? data;

  FilterModel({
     this.status,
     this.message,
     this.data,
  });

  factory FilterModel.fromJson(Map<String, dynamic> json) => FilterModel(
    status: json["status"],
    message: json["message"],
    data: AllFiltersData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data!.toJson(),
  };
}

class AllFiltersData {
  List<Brand>? brand;
  List<RamMemory>? displaySize;
  List<RamMemory>? color;
  List<RamMemory>? hardDisk;
  List<RamMemory>? ramMemory;

  AllFiltersData({
     this.brand,
     this.displaySize,
     this.color,
     this.hardDisk,
     this.ramMemory,
  });

  factory AllFiltersData.fromJson(Map<String, dynamic> json) => AllFiltersData(
    brand: List<Brand>.from(json["brand"].map((x) => Brand.fromJson(x))),
    displaySize: List<RamMemory>.from(json["display_size"].map((x) => RamMemory.fromJson(x))),
    color: List<RamMemory>.from(json["color"].map((x) => RamMemory.fromJson(x))),
    hardDisk: List<RamMemory>.from(json["hard_disk"].map((x) => RamMemory.fromJson(x))),
    ramMemory: List<RamMemory>.from(json["Ram_memory"].map((x) => RamMemory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "brand": List<dynamic>.from(brand!.map((x) => x.toJson())),
    "display_size": List<dynamic>.from(displaySize!.map((x) => x.toJson())),
    "color": List<dynamic>.from(color!.map((x) => x.toJson())),
    "hard_disk": List<dynamic>.from(hardDisk!.map((x) => x.toJson())),
    "Ram_memory": List<dynamic>.from(ramMemory!.map((x) => x.toJson())),
  };
}

class Brand {
  String id;
  String image;
  String name;

  Brand({
    required this.id,
    required this.image,
    required this.name,
  });

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
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

class RamMemory {
  String id;
  String name;

  RamMemory({
    required this.id,
    required this.name,
  });

  factory RamMemory.fromJson(Map<String, dynamic> json) => RamMemory(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
