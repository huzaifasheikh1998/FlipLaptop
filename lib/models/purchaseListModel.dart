// To parse this JSON data, do
//
//     final purchaseListModel = purchaseListModelFromJson(jsonString);

import 'dart:convert';

import 'package:app_fliplaptop/models/dashBoardModel.dart';

PurchaseListModel purchaseListModelFromJson(String str) => PurchaseListModel.fromJson(json.decode(str));

String purchaseListModelToJson(PurchaseListModel data) => json.encode(data.toJson());

class PurchaseListModel {
  String status;
  String message;
  List<PurchaseData> data;

  PurchaseListModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory PurchaseListModel.fromJson(Map<String, dynamic> json) => PurchaseListModel(
    status: json["status"],
    message: json["message"],
    data: List<PurchaseData>.from(json["data"].map((x) => PurchaseData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class PurchaseData {
  String id;
  String totalAmount;
  String paymentStatus;
  String paymentType;
  String transactionId;
  String orderSatus;
  List<OrderItem> orderItem;
  User user;
  UserCard userCard;
  UserAddress? userAddress;

  PurchaseData({
    required this.id,
    required this.totalAmount,
    required this.paymentStatus,
    required this.paymentType,
    required this.transactionId,
    required this.orderSatus,
    required this.orderItem,
    required this.user,
    required this.userCard,
    required this.userAddress,
  });

  factory PurchaseData.fromJson(Map<String, dynamic> json) => PurchaseData(
    id: json["id"],
    totalAmount: json["total_amount"],
    paymentStatus: json["payment_status"],
    paymentType: json["payment_type"],
    transactionId: json["transaction_id"],
    orderSatus: json["order_satus"],
    orderItem: List<OrderItem>.from(json["order_item"].map((x) => OrderItem.fromJson(x))),
    user: User.fromJson(json["user"]),
    userCard: json["userCard"].toString() == "null"
        ? UserCard(
        id: "id",
        name: "name",
        cardNumber: "cardNumber",
        expDate: "expDate",
        cvcCvv: "cvcCvv",
        stripeCreateId: "stripeCreateId",
        stripeCustomerId: "stripeCustomerId",
        setAsDefault: "setAsDefault",
        brand: "brand",
        country: "country",
        cvcCheck: "cvcCheck",
        fingerprint: "fingerprint",
        last4: "last4",
        funding: "funding")
        : UserCard.fromJson(json["userCard"]),
    userAddress: json["userAddress"] == null ? null : UserAddress.fromJson(json["userAddress"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "total_amount": totalAmount,
    "payment_status": paymentStatus,
    "payment_type": paymentType,
    "transaction_id": transactionId,
    "order_satus": orderSatus,
    "order_item": List<dynamic>.from(orderItem.map((x) => x.toJson())),
    "user": user.toJson(),
    "userCard": userCard.toJson(),
    "userAddress": userAddress?.toJson(),
  };
}

class OrderItem {
  String id;
  String quantity;
  String price;
  String orderItemStatus;
  bool? reviewStatus;
  Datum product;
  Store store;

  OrderItem({
    required this.id,
    required this.quantity,
    required this.price,
    required this.orderItemStatus,
    this.reviewStatus,
    required this.product,
    required this.store,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
    id: json["id"],
    quantity: json["quantity"],
    price: json["price"],
    orderItemStatus: json["order_item_status"],
    reviewStatus: json["review_status"],
    product: Datum.fromJson(json["product"]),
    store: Store.fromJson(json["store"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "quantity": quantity,
    "price": price,
    "order_item_status": orderItemStatus,
    "review_status": reviewStatus,
    "product": product.toJson(),
    "store": store.toJson(),
  };
}

class Product {
  String? id;
  String? name;
  int? price;
  String? dealItemPrice;
  String? dealItemStartDatetime;
  String? dealItemEndDatetime;
  String? dealItemPercentage;
  int? qty;
  String? stock;
  String? conditionType;
  String? deliveryType;
  String? model;
  String? descriptions;
  String? createdAt;
  int? storeId;
  String? storeName;
  String? storeImage;
  String? taxStatus;
  String? tax;
  String? shippingCost;
  String? avg;
  String? ratingCount;
  Brands? brands;
  Color? memory;
  Color? hardDrive;
  Color? color;
  Discount? discount;
  User? user;
  List<ProductImage>? productImage;
  List<Color>? size;
  List<dynamic>? review;

  Product({
    this.id,
    this.name,
    this.price,
    this.dealItemPrice,
    this.dealItemStartDatetime,
    this.dealItemEndDatetime,
    this.dealItemPercentage,
    this.qty,
    this.stock,
    this.conditionType,
    this.deliveryType,
    this.model,
    this.descriptions,
    this.createdAt,
    this.storeId,
    this.storeName,
    this.storeImage,
    this.taxStatus,
    this.tax,
    this.shippingCost,
    this.avg,
    this.ratingCount,
    this.brands,
    this.memory,
    this.hardDrive,
    this.color,
    this.discount,
    this.user,
    this.productImage,
    this.size,
    this.review,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    price: json["price"],
    dealItemPrice: json["dealItemPrice"],
    dealItemStartDatetime: json["dealItemStartDatetime"],
    dealItemEndDatetime: json["dealItemEndDatetime"],
    dealItemPercentage: json["dealItemPercentage"],
    qty: json["qty"],
    stock: json["stock"],
    conditionType: json["condition_type"],
    deliveryType: json["delivery_type"],
    model: json["model"],
    descriptions: json["descriptions"],
    createdAt: json["created_at"],
    storeId: json["store_id"],
    storeName: json["store_name"],
    storeImage: json["store_image"],
    taxStatus: json["tax_status"],
    tax: json["tax"],
    shippingCost: json["shipping_cost"],
    avg: json["avg"],
    ratingCount: json["ratingCount"],
    brands: json["brands"] == null ? null : Brands.fromJson(json["brands"]),
    memory: json["memory"] == null ? null : Color.fromJson(json["memory"]),
    hardDrive: json["hard_drive"] == null ? null : Color.fromJson(json["hard_drive"]),
    color: json["color"] == null ? null : Color.fromJson(json["color"]),
    discount: json["discount"] == null ? null : Discount.fromJson(json["discount"]),
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    productImage: json["productImage"] == null ? [] : List<ProductImage>.from(json["productImage"]!.map((x) => ProductImage.fromJson(x))),
    size: json["size"] == null ? [] : List<Color>.from(json["size"]!.map((x) => Color.fromJson(x))),
    review: json["review"] == null ? [] : List<dynamic>.from(json["review"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
    "dealItemPrice": dealItemPrice,
    "dealItemStartDatetime": dealItemStartDatetime,
    "dealItemEndDatetime": dealItemEndDatetime,
    "dealItemPercentage": dealItemPercentage,
    "qty": qty,
    "stock": stock,
    "condition_type": conditionType,
    "delivery_type": deliveryType,
    "model": model,
    "descriptions": descriptions,
    "created_at": createdAt,
    "store_id": storeId,
    "store_name": storeName,
    "store_image": storeImage,
    "tax_status": taxStatus,
    "tax": tax,
    "shipping_cost": shippingCost,
    "avg": avg,
    "ratingCount": ratingCount,
    "brands": brands?.toJson(),
    "memory": memory?.toJson(),
    "hard_drive": hardDrive?.toJson(),
    "color": color?.toJson(),
    "discount": discount?.toJson(),
    "user": user?.toJson(),
    "productImage": productImage == null ? [] : List<dynamic>.from(productImage!.map((x) => x.toJson())),
    "size": size == null ? [] : List<dynamic>.from(size!.map((x) => x.toJson())),
    "review": review == null ? [] : List<dynamic>.from(review!.map((x) => x)),
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

class Discount {
  String id;
  String name;
  String type;
  String percentageTarget;
  String price;
  DateTime startDatetime;
  String endDatetime;

  Discount({
    required this.id,
    required this.name,
    required this.type,
    required this.percentageTarget,
    required this.price,
    required this.startDatetime,
    required this.endDatetime,
  });

  factory Discount.fromJson(Map<String, dynamic> json) => Discount(
    id: json["id"],
    name: json["name"],
    type: json["type"],
    percentageTarget: json["percentage_target"],
    price: json["price"],
    startDatetime: DateTime.parse(json["start_datetime"]),
    endDatetime: json["end_datetime"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "type": type,
    "percentage_target": percentageTarget,
    "price": price,
    "start_datetime": startDatetime.toIso8601String(),
    "end_datetime": endDatetime,
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
  List<dynamic> reviewImage;

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
    reviewImage: List<dynamic>.from(json["review_image"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "rating": rating,
    "description": description,
    "approved": approved,
    "review_image": List<dynamic>.from(reviewImage.map((x) => x)),
  };
}


class Store {
  int id;
  String name;
  String location;
  String image;
  String description;
  String? websiteLink;
  String following;
  String follower;
  String productCount;
  List<Product> product;

  Store({
    required this.id,
    required this.name,
    required this.location,
    required this.image,
    required this.description,
    required this.websiteLink,
    required this.following,
    required this.follower,
    required this.productCount,
    required this.product,
  });

  factory Store.fromJson(Map<String, dynamic> json) => Store(
    id: json["id"],
    name: json["name"],
    location: json["location"],
    image: json["image"],
    description: json["description"],
    websiteLink: json["website_link"],
    following: json["following"],
    follower: json["follower"],
    productCount: json["productCount"],
    product: List<Product>.from(json["product"].map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "location": location,
    "image": image,
    "description": description,
    "website_link": websiteLink,
    "following": following,
    "follower": follower,
    "productCount": productCount,
    "product": List<dynamic>.from(product.map((x) => x.toJson())),
  };
}

class UserAddress {
  String id;
  String addressLine1;
  String addressLine2;
  String city;
  String postalCode;
  String country;
  String mobileNumber;
  String setAsDefault;

  UserAddress({
    required this.id,
    required this.addressLine1,
    required this.addressLine2,
    required this.city,
    required this.postalCode,
    required this.country,
    required this.mobileNumber,
    required this.setAsDefault,
  });

  factory UserAddress.fromJson(Map<String, dynamic> json) => UserAddress(
    id: json["id"],
    addressLine1: json["address_line1"],
    addressLine2: json["address_line2"],
    city: json["city"],
    postalCode: json["postal_code"],
    country: json["country"],
    mobileNumber: json["mobile_number"],
    setAsDefault: json["set_as_default"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "address_line1": addressLine1,
    "address_line2": addressLine2,
    "city": city,
    "postal_code": postalCode,
    "country": country,
    "mobile_number": mobileNumber,
    "set_as_default": setAsDefault,
  };
}

class UserCard {
  String id;
  String name;
  String cardNumber;
  String expDate;
  String cvcCvv;
  String stripeCreateId;
  String stripeCustomerId;
  String setAsDefault;
  String brand;
  String country;
  String cvcCheck;
  String fingerprint;
  String last4;
  String funding;

  UserCard({
    required this.id,
    required this.name,
    required this.cardNumber,
    required this.expDate,
    required this.cvcCvv,
    required this.stripeCreateId,
    required this.stripeCustomerId,
    required this.setAsDefault,
    required this.brand,
    required this.country,
    required this.cvcCheck,
    required this.fingerprint,
    required this.last4,
    required this.funding,
  });

  factory UserCard.fromJson(Map<String, dynamic> json) => UserCard(
    id: json["id"],
    name: json["name"],
    cardNumber: json["card_number"],
    expDate: json["exp_date"],
    cvcCvv: json["cvc_cvv"],
    stripeCreateId: json["stripe_create_id"],
    stripeCustomerId: json["stripe_customer_id"],
    setAsDefault: json["set_as_default"],
    brand: json["brand"],
    country: json["country"],
    cvcCheck: json["cvc_check"],
    fingerprint: json["fingerprint"],
    last4: json["last4"],
    funding: json["funding"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "card_number": cardNumber,
    "exp_date": expDate,
    "cvc_cvv": cvcCvv,
    "stripe_create_id": stripeCreateId,
    "stripe_customer_id": stripeCustomerId,
    "set_as_default": setAsDefault,
    "brand": brand,
    "country": country,
    "cvc_check": cvcCheck,
    "fingerprint": fingerprint,
    "last4": last4,
    "funding": funding,
  };
}
