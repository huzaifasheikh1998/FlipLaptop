import 'package:app_fliplaptop/models/dashBoardModel.dart';
import 'package:collection/collection.dart';

class Data {
  int? id;
  String? name;
  String? location;
  String? image;
  String? description;
  dynamic websiteLink;
  String? following;
  String? follower;
  String? productCount;
  List<Datum>? product;

  Data({
    this.id,
    this.name,
    this.location,
    this.image,
    this.description,
    this.websiteLink,
    this.following,
    this.follower,
    this.productCount,
    this.product,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json['id'] as int?,
        name: json['name'] as String?,
        location: json['location'] as String?,
        image: json['image'] as String?,
        description: json['description'] as String?,
        websiteLink: json['website_link'] as dynamic,
        following: json['following'] as String?,
        follower: json['follower'] as String?,
        productCount: json['productCount'] as String?,
        product: (json['product'] as List<dynamic>?)
            ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'location': location,
        'image': image,
        'description': description,
        'website_link': websiteLink,
        'following': following,
        'follower': follower,
        'productCount': productCount,
        'product': product?.map((e) => e.toJson()).toList(),
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Data) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      location.hashCode ^
      image.hashCode ^
      description.hashCode ^
      websiteLink.hashCode ^
      following.hashCode ^
      follower.hashCode ^
      productCount.hashCode ^
      product.hashCode;
}
