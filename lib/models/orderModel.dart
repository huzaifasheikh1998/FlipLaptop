// To parse this JSON data, do
//
//     final orderModel = orderModelFromJson(jsonString);

import 'dart:convert';

OrderModel orderModelFromJson(String str) => OrderModel.fromJson(json.decode(str));

// for the seller model which we made to get sellerList
// SellerModel sellerModelFromJson(String str) => SellerModel.fromJson(json.decode(str));

String orderModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel {
  String? status;
  String? message;
  OrderData? data;

  OrderModel({
     this.status,
     this.message,
     this.data,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    status: json["status"],
    message: json["message"],
    data: OrderData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data!.toJson(),
  };
}

// class SellerModel {
//   String? status;
//   String? message;
//   List<OrderData>? data;
//
//   SellerModel({
//      this.status,
//      this.message,
//      this.data,
//   });
//
//   factory SellerModel.fromJson(Map<String, dynamic> json) => SellerModel(
//     status: json["status"],
//     message: json["message"],
//     data: List<OrderData>.from(
//         json["data"].map((x) => OrderData.fromJson(x)))
//     // OrderData.fromJson(json["data"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "status": status,
//     "message": message,
//     "data": List<dynamic>.from(data!.map((x) => x.toJson())),
//   };
// }

class OrderData {
  String? id;
  String? totalAmount;
  String? paymentStatus;
  String? paymentType;
  String? transactionId;
  String? orderSatus;
  List<OrderItem>? orderItem;
  // List<OrderItem>? product;
  User? user;
  UserCard? userCard;
  UserAddress? userAddress;

  OrderData({
     this.id,
     this.totalAmount,
     this.paymentStatus,
     this.paymentType,
     this.transactionId,
     this.orderSatus,
     this.orderItem,
    // this.product,
     this.user,
     this.userCard,
     this.userAddress,
  });

  factory OrderData.fromJson(Map<String, dynamic> json) => OrderData(
    id: json["id"],
    totalAmount: json["total_amount"],
    paymentStatus: json["payment_status"],
    paymentType: json["payment_type"],
    transactionId: json["transaction_id"],
    orderSatus: json["order_satus"],
    orderItem: List<OrderItem>.from(json["order_item"].map((x) => OrderItem.fromJson(x))),
    // product: List<OrderItem>.from(json["product"].map((x) => OrderItem.fromJson(x))),
    user: User.fromJson(json["user"]),
    userCard: UserCard.fromJson(json["userCard"]),
    userAddress: UserAddress.fromJson(json["userAddress"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "total_amount": totalAmount,
    "payment_status": paymentStatus,
    "payment_type": paymentType,
    "transaction_id": transactionId,
    "order_satus": orderSatus,
    "order_item": List<dynamic>.from(orderItem!.map((x) => x.toJson())),
    // "product": List<dynamic>.from(product!.map((x) => x.toJson())),
    "user": user!.toJson(),
    "userCard": userCard!.toJson(),
    "userAddress": userAddress!.toJson(),
  };
}

class OrderItem {
  String id;
  String quantity;
  String price;
  String orderItemStatus;
  Product product;
  Store store;

  OrderItem({
    required this.id,
    required this.quantity,
    required this.price,
    required this.orderItemStatus,
    required this.product,
    required this.store,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
    id: json["id"],
    quantity: json["quantity"],
    price: json["price"],
    orderItemStatus: json["order_item_status"],
    product: Product.fromJson(json["product"]),
    store: Store.fromJson(json["store"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "quantity": quantity,
    "price": price,
    "order_item_status": orderItemStatus,
    "product": product.toJson(),
    "store": store.toJson(),
  };
}

class Product {
  String id;
  String name;
  int price;
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

  Product({
    required this.id,
    required this.name,
    required this.price,
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

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    price: json["price"],
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

class Store {
  int id;
  String name;
  String location;
  String image;
  String description;
  dynamic websiteLink;
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

class User {
  String id;
  String name;
  String email;
  String address;
  String phoneNumber;
  String image;
  String gender;
  bool notificationStatus;
  String otp;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.address,
    required this.phoneNumber,
    required this.image,
    required this.gender,
    required this.notificationStatus,
    required this.otp,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    address: json["address"],
    phoneNumber: json["phone_number"],
    image: json["image"],
    gender: json["gender"],
    notificationStatus: json["notification_status"],
    otp: json["otp"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "address": address,
    "phone_number": phoneNumber,
    "image": image,
    "gender": gender,
    "notification_status": notificationStatus,
    "otp": otp,
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
