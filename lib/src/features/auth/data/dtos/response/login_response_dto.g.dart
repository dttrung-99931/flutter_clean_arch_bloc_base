// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponseDto _$LoginResponseDtoFromJson(Map<String, dynamic> json) =>
    LoginResponseDto(
      token: json['token'] as String,
      userID: (json['userID'] as num).toInt(),
      cartId: (json['cartId'] as num).toInt(),
    );
