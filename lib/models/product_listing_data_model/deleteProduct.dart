// To parse this JSON data, do
//
//     final deleteProduct = deleteProductFromJson(jsonString);

import 'dart:convert';

ProductSingle productSingleFromJson(String str) =>
    ProductSingle.fromJson(json.decode(str));

String productSingleToJson(ProductSingle data) => json.encode(data.toJson());

class ProductSingle {
  String? status;
  String? message;
  Data? data;

  ProductSingle({
    this.status,
    this.message,
    this.data,
  });

  factory ProductSingle.fromJson(Map<String, dynamic> json) => ProductSingle(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data!.toJson(),
      };
}

class Data {
  String id;
  String name;
  int price;
  int qty;
  String conditionType;
  String deliveryType;
  String model;
  String descriptions;
  String shippingCost;
  String createdAt;
  int storeId;
  String storeName;
  String storeImage;
  List<dynamic> size;
  dynamic memory;
  dynamic hardDrive;
  Brands brands;
  dynamic color;
  dynamic discount;
  List<ProductImage> productImage;

  Data({
    required this.id,
    required this.name,
    required this.price,
    required this.qty,
    required this.conditionType,
    required this.deliveryType,
    required this.model,
    required this.descriptions,
    required this.shippingCost,
    required this.createdAt,
    required this.storeId,
    required this.storeName,
    required this.storeImage,
    required this.size,
    required this.memory,
    required this.hardDrive,
    required this.brands,
    required this.color,
    required this.discount,
    required this.productImage,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        qty: json["qty"],
        conditionType: json["condition_type"],
        deliveryType: json["delivery_type"],
        model: json["model"],
        descriptions: json["descriptions"],
        shippingCost: json["shipping_cost"],
        createdAt: json["created_at"],
        storeId: json["store_id"],
        storeName: json["store_name"],
        storeImage: json["store_image"],
        size: List<dynamic>.from(json["size"].map((x) => x)),
        memory: json["memory"],
        hardDrive: json["hard_drive"],
        brands: Brands.fromJson(json["brands"]),
        color: json["color"],
        discount: json["discount"],
        productImage: List<ProductImage>.from(
            json["productImage"].map((x) => ProductImage.fromJson(x))),
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
        "shipping_cost": shippingCost,
        "created_at": createdAt,
        "store_id": storeId,
        "store_name": storeName,
        "store_image": storeImage,
        "size": List<dynamic>.from(size.map((x) => x)),
        "memory": memory,
        "hard_drive": hardDrive,
        "brands": brands.toJson(),
        "color": color,
        "discount": discount,
        "productImage": List<dynamic>.from(productImage.map((x) => x.toJson())),
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
