// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_base_app/features/auth/domain/entities/response/login_response.dart';

part 'login_model.g.dart';

@JsonSerializable(explicitToJson: true, createToJson: false)
class LoginModel {
  final String token;
  final int userID;
  final int cartId;

  LoginModel({
    required this.token,
    required this.userID,
    required this.cartId,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => _$LoginModelFromJson(json);

  LoginResponse toEntity() {
    return LoginResponse(
      token: token,
    );
  }
}
