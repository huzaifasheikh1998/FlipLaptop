import 'package:collection/collection.dart';

class RamMemory {
  String? id;
  String? name;

  RamMemory({this.id, this.name});

  factory RamMemory.fromJson(Map<String, dynamic> json) => RamMemory(
        id: json['id'] as String?,
        name: json['name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! RamMemory) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
