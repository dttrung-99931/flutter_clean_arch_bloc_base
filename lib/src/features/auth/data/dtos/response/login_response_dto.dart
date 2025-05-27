// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'login_response_dto.g.dart';

@JsonSerializable(explicitToJson: true, createToJson: false)
class LoginResponseDto {
  final String token;
  final int userID;
  final int cartId;

  LoginResponseDto({
    required this.token,
    required this.userID,
    required this.cartId,
  });

  factory LoginResponseDto.fromJson(Map<String, dynamic> json) => _$LoginResponseDtoFromJson(json);
}
