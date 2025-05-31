// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDetailModel _$UserDetailModelFromJson(Map<String, dynamic> json) =>
    UserDetailModel(
      (json['id'] as num).toInt(),
      json['name'] as String,
      json['phone'] as String,
      json['email'] as String,
      (json['cartId'] as num).toInt(),
    );
