import 'package:collection/collection.dart';

import '../loginmodel.dart';

class MyStoreProfileDataModel {
  String? status;
  String? message;
  Store? data;

  MyStoreProfileDataModel({this.status, this.message, this.data});

  factory MyStoreProfileDataModel.fromJson(Map<dynamic, dynamic> json) {
    return MyStoreProfileDataModel(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Store.fromJson(json['data'] as Map<String, dynamic>),
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
    if (other is! MyStoreProfileDataModel) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => status.hashCode ^ message.hashCode ^ data.hashCode;
}
