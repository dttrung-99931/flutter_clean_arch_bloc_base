// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      (json['id'] as num).toInt(),
      json['name'] as String,
      json['phone'] as String,
      json['email'] as String,
      (json['cartId'] as num).toInt(),
    );
