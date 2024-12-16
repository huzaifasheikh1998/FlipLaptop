import 'package:collection/collection.dart';

import 'brand.dart';
import 'color.dart';
import 'display_size.dart';
import 'hard_disk.dart';
import 'ram_memory.dart';

class Data {
  List<Brand>? brand;
  List<DisplaySize>? displaySize;
  List<Color>? color;
  List<HardDisk>? hardDisk;
  List<RamMemory>? ramMemory;

  Data({
    this.brand,
    this.displaySize,
    this.color,
    this.hardDisk,
    this.ramMemory,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        brand: (json['brand'] as List<dynamic>?)
            ?.map((e) => Brand.fromJson(e as Map<String, dynamic>))
            .toList(),
        displaySize: (json['display_size'] as List<dynamic>?)
            ?.map((e) => DisplaySize.fromJson(e as Map<String, dynamic>))
            .toList(),
        color: (json['color'] as List<dynamic>?)
            ?.map((e) => Color.fromJson(e as Map<String, dynamic>))
            .toList(),
        hardDisk: (json['hard_disk'] as List<dynamic>?)
            ?.map((e) => HardDisk.fromJson(e as Map<String, dynamic>))
            .toList(),
        ramMemory: (json['Ram_memory'] as List<dynamic>?)
            ?.map((e) => RamMemory.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'brand': brand?.map((e) => e.toJson()).toList(),
        'display_size': displaySize?.map((e) => e.toJson()).toList(),
        'color': color?.map((e) => e.toJson()).toList(),
        'hard_disk': hardDisk?.map((e) => e.toJson()).toList(),
        'Ram_memory': ramMemory?.map((e) => e.toJson()).toList(),
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
      brand.hashCode ^
      displaySize.hashCode ^
      color.hashCode ^
      hardDisk.hashCode ^
      ramMemory.hashCode;
}
