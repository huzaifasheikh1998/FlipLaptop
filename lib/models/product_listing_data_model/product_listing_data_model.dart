import 'package:app_fliplaptop/models/dashBoardModel.dart';
import 'package:collection/collection.dart';


class ProductListingDataModel {
  String? status;
  String? message;
  List<Datum>? data;

  ProductListingDataModel({this.status, this.message, this.data});

  factory ProductListingDataModel.fromJson(Map<dynamic, dynamic> json) {
    return ProductListingDataModel(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'data': data?.map((e) => e.toJson()).toList(),
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! ProductListingDataModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => status.hashCode ^ message.hashCode ^ data.hashCode;
}
