// To parse this JSON data, do
//
//     final dealModel = dealModelFromJson(jsonString);

import 'dart:convert';

DealModel dealModelFromJson(String str) => DealModel.fromJson(json.decode(str));

String dealModelToJson(DealModel data) => json.encode(data.toJson());

class DealModel {
  String? status;
  String? message;
  List<DealIndex>? data;

  DealModel({
     this.status,
     this.message,
     this.data,
  });

  factory DealModel.fromJson(Map<String, dynamic> json) => DealModel(
    status: json["status"],
    message: json["message"],
    data: List<DealIndex>.from(json["data"].map((x) => DealIndex.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class DealIndex {
  String id;
  String image;

  DealIndex({
    required this.id,
    required this.image,
  });

  factory DealIndex.fromJson(Map<String, dynamic> json) => DealIndex(
    id: json["id"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
  };
}


// To parse this JSON data, do
//
//     final createDealModel = createDealModelFromJson(jsonString);

/// this is the model made when we are creating deal and this is skeleton
/// will be upodated when we get the deal successfully added

// To parse this JSON data, do
//
//     final createDealModel = createDealModelFromJson(jsonString);


CreateDealModel createDealModelFromJson(String str) => CreateDealModel.fromJson(json.decode(str));

String createDealModelToJson(CreateDealModel data) => json.encode(data.toJson());

class CreateDealModel {
  String status;
  String message;
  DealData? data;

  CreateDealModel({
    required this.status,
    required this.message,
     this.data,
  });

  factory CreateDealModel.fromJson(Map<String, dynamic> json) => CreateDealModel(
    status: json["status"],
    message: json["message"],
    data: DealData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data!.toJson(),
  };
}

class DealData {
  String? id;
  String? image;
  String? title;
  String? description;
  String? saleParcentage;
  DateTime? startDatetime;
  DateTime? endDatetime;
  List<DealItem>? dealItem;

  DealData({
     this.id,
     this.image,
     this.title,
     this.description,
     this.saleParcentage,
     this.startDatetime,
     this.endDatetime,
     this.dealItem,
  });

  factory DealData.fromJson(Map<String, dynamic> json) => DealData(
    id: json["id"],
    image: json["image"],
    title: json["title"],
    description: json["description"],
    saleParcentage: json["sale_parcentage"],
    startDatetime: DateTime.parse(json["start_datetime"]),
    endDatetime: DateTime.parse(json["end_datetime"]),
    dealItem: List<DealItem>.from(json["deal_item"].map((x) => DealItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "title": title,
    "description": description,
    "sale_parcentage": saleParcentage,
    "start_datetime": startDatetime!.toIso8601String(),
    "end_datetime": endDatetime!.toIso8601String(),
    "deal_item": List<dynamic>.from(dealItem!.map((x) => x.toJson())),
  };
}

class DealItem {
  String id;
  String name;
  int price;
  String dealDiscountPrice;
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
  Color memory;
  Color hardDrive;
  Color color;
  dynamic discount;
  List<ProductImage> productImage;
  List<Color> size;
  List<dynamic> review;

  DealItem({
    required this.id,
    required this.name,
    required this.price,
    required this.dealDiscountPrice,
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
    required this.productImage,
    required this.size,
    required this.review,
  });

  factory DealItem.fromJson(Map<String, dynamic> json) => DealItem(
    id: json["id"],
    name: json["name"],
    price: json["price"],
    dealDiscountPrice: json["deal_discount_price"],
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
    memory: Color.fromJson(json["memory"]),
    hardDrive: Color.fromJson(json["hard_drive"]),
    color: Color.fromJson(json["color"]),
    discount: json["discount"],
    productImage: List<ProductImage>.from(json["productImage"].map((x) => ProductImage.fromJson(x))),
    size: List<Color>.from(json["size"].map((x) => Color.fromJson(x))),
    review: List<dynamic>.from(json["review"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
    "deal_discount_price": dealDiscountPrice,
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
    "memory": memory.toJson(),
    "hard_drive": hardDrive.toJson(),
    "color": color.toJson(),
    "discount": discount,
    "productImage": List<dynamic>.from(productImage.map((x) => x.toJson())),
    "size": List<dynamic>.from(size.map((x) => x.toJson())),
    "review": List<dynamic>.from(review.map((x) => x)),
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


