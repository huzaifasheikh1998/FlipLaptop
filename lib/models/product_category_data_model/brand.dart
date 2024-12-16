import 'package:collection/collection.dart';

class Brand {
  String? id;
  String? image;
  String? name;

  Brand({this.id, this.image, this.name});

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
        id: json['id'] as String?,
        image: json['image'] as String?,
        name: json['name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'image': image,
        'name': name,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Brand) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => id.hashCode ^ image.hashCode ^ name.hashCode;
}
