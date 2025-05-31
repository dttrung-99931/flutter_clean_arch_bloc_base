// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';
import 'package:maingames_flutter_test/src/features/auth/domain/entities/response/login_response.dart';

part 'login_response_model.g.dart';

@JsonSerializable(explicitToJson: true, createToJson: false)
class LoginResponseModel {
  final String token;
  final int userID;
  final int cartId;

  LoginResponseModel({
    required this.token,
    required this.userID,
    required this.cartId,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => _$LoginResponseModelFromJson(json);

  LoginResponse toEntity() {
    return LoginResponse(
      token: token,
    );
  }
}
