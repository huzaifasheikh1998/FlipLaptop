// // To parse this JSON data, do
// //
// //     final dashBoardModel = dashBoardModelFromJson(jsonString);
//
// import 'dart:convert';
//
// DashBoardModel dashBoardModelFromJson(String str) =>
//     DashBoardModel.fromJson(json.decode(str));
//
// String dashBoardModelToJson(DashBoardModel data) => json.encode(data.toJson());
//
// class DashBoardModel {
//   String? status;
//   String? message;
//   Data? data;
//
//   DashBoardModel({
//     this.status,
//     this.message,
//     this.data,
//   });
//
//   factory DashBoardModel.fromJson(Map<String, dynamic> json) => DashBoardModel(
//         status: json["status"],
//         message: json["message"],
//         data: Data.fromJson(json["data"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "message": message,
//         "data": data!.toJson(),
//       };
// }
//
// class Data {
//   List<Brand> brand;
//   List<Store> store;
//   List<Datum> wishlist;
//   Product newArrivalProduct;
//   Product moreProduct;
//   Product topRankingProduct;
//
//   Data({
//     required this.brand,
//     required this.store,
//     required this.wishlist,
//     required this.newArrivalProduct,
//     required this.moreProduct,
//     required this.topRankingProduct,
//   });
//
//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//         brand: List<Brand>.from(json["brand"].map((x) => Brand.fromJson(x))),
//         store: List<Store>.from(json["store"].map((x) => Store.fromJson(x))),
//         wishlist:
//             List<Datum>.from(json["wishlist"].map((x) => Datum.fromJson(x))),
//         newArrivalProduct: Product.fromJson(json["new_arrival_product"]),
//         moreProduct: Product.fromJson(json["more_product"]),
//         topRankingProduct: Product.fromJson(json["top_ranking_product"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "brand": List<dynamic>.from(brand.map((x) => x.toJson())),
//         "store": List<dynamic>.from(store.map((x) => x.toJson())),
//         "wishlist": List<dynamic>.from(wishlist.map((x) => x.toJson())),
//         "new_arrival_product": newArrivalProduct.toJson(),
//         "more_product": moreProduct.toJson(),
//         "top_ranking_product": topRankingProduct.toJson(),
//       };
// }
//
// class Brand {
//   String id;
//   String image;
//   String name;
//
//   Brand({
//     required this.id,
//     required this.image,
//     required this.name,
//   });
//
//   factory Brand.fromJson(Map<String, dynamic> json) => Brand(
//         id: json["id"],
//         image: json["image"],
//         name: json["name"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "image": image,
//         "name": name,
//       };
// }
//
// class Product {
//   List<Datum>? data;
//   Links? links;
//
//   Product({
//     this.data,
//     this.links,
//   });
//
//   factory Product.fromJson(Map<String, dynamic> json) => Product(
//         data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
//         links: Links.fromJson(json["links"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "data": List<dynamic>.from(data!.map((x) => x.toJson())),
//         "links": links?.toJson(),
//       };
// }
//
// class Datum {
//   String? id;
//   String? name;
//   int? price;
//   String? dealItemPrice;
//   String? dealItemStartDatetime;
//   String? dealItemEndDatetime;
//   String? dealItemPercentage;
//   int? qty;
//   String? conditionType;
//   String? deliveryType;
//   String? model;
//   String? descriptions;
//   String? createdAt;
//   int? storeId;
//   String? storeName;
//   String? storeImage;
//   String? taxStatus;
//   String? tax;
//   String? shippingCost;
//   String? avg;
//   String? ratingCount;
//   Brand? brands;
//   ModelColor? memory;
//   ModelColor? hardDrive;
//   ModelColor? color;
//   Discount? discount;
//   User? user;
//   List<ProductImage>? productImage;
//   List<ModelColor>? size;
//   List<Review>? review;
//
//   Datum({
//     this.id,
//     this.name,
//     this.price,
//     this.dealItemPrice,
//     this.dealItemStartDatetime,
//     this.dealItemEndDatetime,
//     this.dealItemPercentage,
//     this.qty,
//     this.conditionType,
//     this.deliveryType,
//     this.model,
//     this.descriptions,
//     this.createdAt,
//     this.storeId,
//     this.storeName,
//     this.storeImage,
//     this.taxStatus,
//     this.tax,
//     this.shippingCost,
//     this.avg,
//     this.ratingCount,
//     this.brands,
//     this.memory,
//     this.hardDrive,
//     this.color,
//     this.discount,
//     this.user,
//     this.productImage,
//     this.size,
//     this.review,
//   });
//
//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//         id: json["id"],
//         name: json["name"],
//         price: json["price"],
//         dealItemPrice: json["dealItemPrice"],
//         dealItemStartDatetime: json["dealItemStartDatetime"],
//         dealItemEndDatetime: json["dealItemEndDatetime"],
//         dealItemPercentage: json["dealItemPercentage"],
//         qty: json["qty"],
//         conditionType: json["condition_type"],
//         deliveryType: json["delivery_type"],
//         model: json["model"],
//         descriptions: json["descriptions"],
//         createdAt: json["created_at"],
//         storeId: json["store_id"],
//         storeName: json["store_name"],
//         storeImage: json["store_image"],
//         taxStatus: json["tax_status"],
//         tax: json["tax"],
//         shippingCost: json["shipping_cost"],
//         avg: json["avg"],
//         ratingCount: json["ratingCount"],
//         brands: Brand.fromJson(json["brands"]),
//         memory:
//             json["memory"] == null ? null : ModelColor.fromJson(json["memory"]),
//         hardDrive: json["hard_drive"] == null
//             ? null
//             : ModelColor.fromJson(json["hard_drive"]),
//         color:
//             json["color"] == null ? null : ModelColor.fromJson(json["color"]),
//         discount: json["discount"] == null
//             ? null
//             : Discount.fromJson(json["discount"]),
//         user: User.fromJson(json["user"]),
//         productImage: List<ProductImage>.from(
//             json["productImage"].map((x) => ProductImage.fromJson(x))),
//         size: List<ModelColor>.from(
//             json["size"].map((x) => ModelColor.fromJson(x))),
//         review:
//             List<Review>.from(json["review"].map((x) => Review.fromJson(x))),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "price": price,
//         "dealItemPrice": dealItemPrice,
//         "dealItemStartDatetime": dealItemStartDatetime,
//         "dealItemEndDatetime": dealItemEndDatetime,
//     "dealItemPercentage": dealItemPercentage,
//         "qty": qty,
//         "condition_type": conditionType,
//         "delivery_type": deliveryType,
//         "model": model,
//         "descriptions": descriptions,
//         "created_at": createdAt,
//         "store_id": storeId,
//         "store_name": storeName,
//         "store_image": storeImage,
//         "tax_status": taxStatus,
//         "tax": tax,
//         "shipping_cost": shippingCost,
//         "avg": avg,
//         "ratingCount": ratingCount,
//         "brands": brands?.toJson(),
//         "memory": memory?.toJson(),
//         "hard_drive": hardDrive?.toJson(),
//         "color": color?.toJson(),
//         "discount": discount?.toJson(),
//         "user": user?.toJson(),
//         "productImage":
//             List<dynamic>.from(productImage!.map((x) => x.toJson())),
//         "size": List<dynamic>.from(size!.map((x) => x.toJson())),
//         "review": List<dynamic>.from(review!.map((x) => x.toJson())),
//       };
// }
//
// class ModelColor {
//   String id;
//   String name;
//
//   ModelColor({
//     required this.id,
//     required this.name,
//   });
//
//   factory ModelColor.fromJson(Map<String, dynamic> json) => ModelColor(
//         id: json["id"],
//         name: json["name"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//       };
// }
//
// class Discount {
//   String id;
//   String name;
//   String type;
//   String percentageTarget;
//   String price;
//   String startDatetime;
//   String endDatetime;
//
//   Discount({
//     required this.id,
//     required this.name,
//     required this.type,
//     required this.percentageTarget,
//     required this.price,
//     required this.startDatetime,
//     required this.endDatetime,
//   });
//
//   factory Discount.fromJson(Map<String, dynamic> json) => Discount(
//         id: json["id"],
//         name: json["name"],
//         type: json["type"],
//         percentageTarget: json["percentage_target"],
//         price: json["price"],
//         startDatetime: json["start_datetime"],
//         endDatetime: json["end_datetime"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "type": type,
//         "percentage_target": percentageTarget,
//         "price": price,
//         "start_datetime": startDatetime,
//         "end_datetime": endDatetime,
//       };
// }
//
// class ProductImage {
//   int id;
//   String name;
//
//   ProductImage({
//     required this.id,
//     required this.name,
//   });
//
//   factory ProductImage.fromJson(Map<String, dynamic> json) => ProductImage(
//         id: json["id"],
//         name: json["name"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//       };
// }
//
// class Review {
//   String id;
//   String rating;
//   String description;
//   String approved;
//   List<ReviewImage> reviewImage;
//
//   Review({
//     required this.id,
//     required this.rating,
//     required this.description,
//     required this.approved,
//     required this.reviewImage,
//   });
//
//   factory Review.fromJson(Map<String, dynamic> json) => Review(
//         id: json["id"],
//         rating: json["rating"],
//         description: json["description"],
//         approved: json["approved"],
//         reviewImage: List<ReviewImage>.from(
//             json["review_image"].map((x) => ReviewImage.fromJson(x))),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "rating": rating,
//         "description": description,
//         "approved": approved,
//         "review_image": List<dynamic>.from(reviewImage.map((x) => x.toJson())),
//       };
// }
//
// class ReviewImage {
//   String id;
//   String image;
//
//   ReviewImage({
//     required this.id,
//     required this.image,
//   });
//
//   factory ReviewImage.fromJson(Map<String, dynamic> json) => ReviewImage(
//         id: json["id"],
//         image: json["image"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "image": image,
//       };
// }
//
// class User {
//   String? id;
//   String? name;
//   String? email;
//   String? address;
//   String? phoneNumber;
//   String? image;
//   String? gender;
//   bool? notificationStatus;
//   String? otp;
//
//   User({
//     this.id,
//     this.name,
//     this.email,
//     this.address,
//     this.phoneNumber,
//     this.image,
//     this.gender,
//     this.notificationStatus,
//     this.otp,
//   });
//
//   factory User.fromJson(Map<String, dynamic> json) => User(
//         id: json["id"],
//         name: json["name"],
//         email: json["email"],
//         address: json["address"],
//         phoneNumber: json["phone_number"],
//         image: json["image"],
//         gender: json["gender"],
//         notificationStatus: json["notification_status"],
//         otp: json["otp"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "email": email,
//         "address": address,
//         "phone_number": phoneNumber,
//         "image": image,
//         "gender": gender,
//         "notification_status": notificationStatus,
//         "otp": otp,
//       };
// }
//
// class Links {
//   String first;
//   String last;
//   dynamic prev;
//   String? next;
//
//   Links({
//     required this.first,
//     required this.last,
//     required this.prev,
//     required this.next,
//   });
//
//   factory Links.fromJson(Map<String, dynamic> json) => Links(
//         first: json["first"],
//         last: json["last"],
//         prev: json["prev"],
//         next: json["next"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "first": first,
//         "last": last,
//         "prev": prev,
//         "next": next,
//       };
// }
//
// class Store {
//   int? id;
//   String? name;
//   String? location;
//   String? image;
//   String? description;
//   String? websiteLink;
//   dynamic taxStatus;
//   dynamic tax;
//   dynamic stripeAccountID;
//   String? following;
//   String? follower;
//   String? productCount;
//   List<Datum>? product;
//
//   Store({
//     this.id,
//     this.name,
//     this.location,
//     this.image,
//     this.description,
//     this.websiteLink,
//     this.taxStatus,
//     this.tax,
//     this.stripeAccountID,
//     this.following,
//     this.follower,
//     this.productCount,
//     this.product,
//   });
//
//   factory Store.fromJson(Map<String, dynamic> json) => Store(
//         id: json["id"],
//         name: json["name"],
//         location: json["location"],
//         image: json["image"],
//         description: json["description"],
//         websiteLink: json["website_link"],
//         taxStatus: json["tax_status"],
//         tax: json["tax"],
//         stripeAccountID: json["stripe_account_id"],
//         following: json["following"],
//         follower: json["follower"],
//         productCount: json["productCount"],
//         product:
//             List<Datum>.from(json["product"].map((x) => Datum.fromJson(x))),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "location": location,
//         "image": image,
//         "description": description,
//         "website_link": websiteLink,
//         "tax_status": taxStatus,
//         "tax": tax,
//         "stripe_account_id": stripeAccountID,
//         "following": following,
//         "follower": follower,
//         "productCount": productCount,
//         "product": List<dynamic>.from(product!.map((x) => x.toJson())),
//       };
// }
// To parse this JSON data, do
//
//     final dashBoardModel = dashBoardModelFromJson(jsonString);

import 'dart:convert';

DashBoardModel dashBoardModelFromJson(String str) =>
    DashBoardModel.fromJson(json.decode(str));

String dashBoardModelToJson(DashBoardModel data) => json.encode(data.toJson());

class DashBoardModel {
  String? status;
  String? message;
  Data? data;

  DashBoardModel({
    this.status,
    this.message,
    this.data,
  });

  factory DashBoardModel.fromJson(Map<String, dynamic> json) => DashBoardModel(
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
  List<Brand>? brand;
  List<Store>? store;
  List<dynamic>? wishlist;
  Product? newArrivalProduct;
  Product? moreProduct;
  Product? topRankingProduct;

  Data({
    this.brand,
    this.store,
    this.wishlist,
    this.newArrivalProduct,
    this.moreProduct,
    this.topRankingProduct,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        brand: json["brand"] == null
            ? []
            : List<Brand>.from(json["brand"]!.map((x) => Brand.fromJson(x))),
        store: json["store"] == null
            ? []
            : List<Store>.from(json["store"]!.map((x) => Store.fromJson(x))),
        wishlist: json["wishlist"] == null
            ? []
            : List<dynamic>.from(json["wishlist"]!.map((x) => x)),
        newArrivalProduct: json["new_arrival_product"] == null
            ? null
            : Product.fromJson(json["new_arrival_product"]),
        moreProduct: json["more_product"] == null
            ? null
            : Product.fromJson(json["more_product"]),
        topRankingProduct: json["top_ranking_product"] == null
            ? null
            : Product.fromJson(json["top_ranking_product"]),
      );

  Map<String, dynamic> toJson() => {
        "brand": brand == null
            ? []
            : List<dynamic>.from(brand!.map((x) => x.toJson())),
        "store": store == null
            ? []
            : List<dynamic>.from(store!.map((x) => x.toJson())),
        "wishlist":
            wishlist == null ? [] : List<dynamic>.from(wishlist!.map((x) => x)),
        "new_arrival_product": newArrivalProduct?.toJson(),
        "more_product": moreProduct?.toJson(),
        "top_ranking_product": topRankingProduct?.toJson(),
      };
}

class Brand {
  String? id;
  String? image;
  String? name;

  Brand({
    this.id,
    this.image,
    this.name,
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

class Product {
  List<Datum>? data;
  Links? links;

  Product({
    this.data,
    this.links,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        links: json["links"] == null ? null : Links.fromJson(json["links"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "links": links?.toJson(),
      };
}

class Datum {
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
  Brand? brands;
  ModelColor? memory;
  ModelColor? hardDrive;
  ModelColor? color;
  Discount? discount;
  User? user;
  List<ProductImage>? productImage;
  List<ModelColor>? size;
  List<Review>? review;

  Datum({
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

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
        brands: json["brands"] == null ? null : Brand.fromJson(json["brands"]),
        memory:
            json["memory"] == null ? null : ModelColor.fromJson(json["memory"]),
        hardDrive: json["hard_drive"] == null
            ? null
            : ModelColor.fromJson(json["hard_drive"]),
        color:
            json["color"] == null ? null : ModelColor.fromJson(json["color"]),
        discount: json["discount"] == null
            ? null
            : Discount.fromJson(json["discount"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        productImage: json["productImage"] == null
            ? []
            : List<ProductImage>.from(
                json["productImage"]!.map((x) => ProductImage.fromJson(x))),
        size: json["size"] == null
            ? []
            : List<ModelColor>.from(
                json["size"]!.map((x) => ModelColor.fromJson(x))),
        review: json["review"] == null
            ? []
            : List<Review>.from(json["review"]!.map((x) => Review.fromJson(x))),
      );

  List<String>? get deleteImageIds => null;

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
        "productImage": productImage == null
            ? []
            : List<dynamic>.from(productImage!.map((x) => x.toJson())),
        "size": size == null
            ? []
            : List<dynamic>.from(size!.map((x) => x.toJson())),
        "review": review == null
            ? []
            : List<dynamic>.from(review!.map((x) => x.toJson())),
      };
}

class ModelColor {
  String? id;
  String? name;

  ModelColor({
    this.id,
    this.name,
  });

  factory ModelColor.fromJson(Map<String, dynamic> json) => ModelColor(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class Discount {
  String? id;
  String? name;
  String? type;
  String? percentageTarget;
  String? price;
  DateTime? startDatetime;
  DateTime? endDatetime;

  Discount({
    this.id,
    this.name,
    this.type,
    this.percentageTarget,
    this.price,
    this.startDatetime,
    this.endDatetime,
  });

  factory Discount.fromJson(Map<String, dynamic> json) => Discount(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        percentageTarget: json["percentage_target"],
        price: json["price"],
        startDatetime: json["start_datetime"] == null
            ? null
            : DateTime.parse(json["start_datetime"]),
        endDatetime: json["end_datetime"] == null
            ? null
            : DateTime.parse(json["end_datetime"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
        "percentage_target": percentageTarget,
        "price": price,
        "start_datetime": startDatetime?.toIso8601String(),
        "end_datetime": endDatetime?.toIso8601String(),
      };
}

class ProductImage {
  int? id;
  String? name;

  ProductImage({
    this.id,
    this.name,
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
  String? id;
  String? rating;
  String? description;
  String? approved;
  User? user;
  List<ReviewImage>? reviewImage;

  Review({
    this.id,
    this.rating,
    this.description,
    this.approved,
    this.user,
    this.reviewImage,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        id: json["id"],
        rating: json["rating"],
        description: json["description"],
        approved: json["approved"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        reviewImage: json["review_image"] == null
            ? []
            : List<ReviewImage>.from(
                json["review_image"]!.map((x) => ReviewImage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "rating": rating,
        "description": description,
        "approved": approved,
        "user": user?.toJson(),
        "review_image": reviewImage == null
            ? []
            : List<dynamic>.from(reviewImage!.map((x) => x.toJson())),
      };
}

class ReviewImage {
  String? id;
  String? image;

  ReviewImage({
    this.id,
    this.image,
  });

  factory ReviewImage.fromJson(Map<String, dynamic> json) => ReviewImage(
        id: json["id"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
      };
}

class User {
  String? id;
  String? image;
  String? name;
  String? email;
  String? phoneNumber;
  String? gender;
  String? otp;
  DateTime? emailVerifiedAt;
  String? address;
  String? deviceType;
  String? socialDevice;
  bool? notificationStatus;
  String? deviceToken;

  User({
    this.id,
    this.image,
    this.name,
    this.email,
    this.phoneNumber,
    this.gender,
    this.otp,
    this.emailVerifiedAt,
    this.address,
    this.deviceType,
    this.socialDevice,
    this.notificationStatus,
    this.deviceToken,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        image: json["image"],
        name: json["name"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        gender: json["gender"],
        otp: json["otp"],
        emailVerifiedAt: json["email_verified_at"] == null
            ? null
            : DateTime.parse(json["email_verified_at"].toString()),
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
        "email_verified_at": emailVerifiedAt?.toIso8601String(),
        "address": address,
        "device_type": deviceType,
        "social_device": socialDevice,
        "notification_status": notificationStatus,
        "device_token": deviceToken,
      };
}

class Links {
  String? first;
  String? last;
  dynamic prev;
  String? next;

  Links({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        first: json["first"],
        last: json["last"],
        prev: json["prev"],
        next: json["next"],
      );

  Map<String, dynamic> toJson() => {
        "first": first,
        "last": last,
        "prev": prev,
        "next": next,
      };
}

class Store {
  int? id;
  String? name;
  String? location;
  String? image;
  String? description;
  String? websiteLink;
  String? taxStatus;
  String? tax;
  String? stripeAccountId;
  String? avg;
  String? ratingCount;
  String? following;
  String? follower;
  String? productCount;
  List<Datum>? product;

  Store({
    this.id,
    this.name,
    this.location,
    this.image,
    this.description,
    this.websiteLink,
    this.taxStatus,
    this.tax,
    this.stripeAccountId,
    this.avg,
    this.ratingCount,
    this.following,
    this.follower,
    this.productCount,
    this.product,
  });

  factory Store.fromJson(Map<String, dynamic> json) => Store(
        id: json["id"],
        name: json["name"],
        location: json["location"],
        image: json["image"],
        description: json["description"],
        websiteLink: json["website_link"],
        taxStatus: json["tax_status"],
        tax: json["tax"],
        stripeAccountId: json["stripe_account_id"],
        avg: json["avg"],
        ratingCount: json["ratingCount"],
        following: json["following"],
        follower: json["follower"],
        productCount: json["productCount"],
        product: json["product"] == null
            ? []
            : List<Datum>.from(json["product"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "location": location,
        "image": image,
        "description": description,
        "website_link": websiteLink,
        "tax_status": taxStatus,
        "tax": tax,
        "stripe_account_id": stripeAccountId,
        "avg": avg,
        "ratingCount": ratingCount,
        "following": following,
        "follower": follower,
        "productCount": productCount,
        "product": product == null
            ? []
            : List<dynamic>.from(product!.map((x) => x.toJson())),
      };
}
