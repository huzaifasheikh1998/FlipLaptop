import 'package:collection/collection.dart';

import 'data.dart';

class ProductCategoryDataModel {
  String? status;
  String? message;
  Data? data;

  ProductCategoryDataModel({this.status, this.message, this.data});

  factory ProductCategoryDataModel.fromJson(Map<dynamic, dynamic> json) {
    return ProductCategoryDataModel(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'data': data?.toJson(),
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! ProductCategoryDataModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => status.hashCode ^ message.hashCode ^ data.hashCode;
}
