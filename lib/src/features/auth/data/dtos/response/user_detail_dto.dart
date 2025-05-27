// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'user_detail_dto.g.dart';

@JsonSerializable(explicitToJson: true, createToJson: false)
class UserDetailDto {
  final int id;
  final String name;
  final String phone;
  final String email;
  final int cartId;

  UserDetailDto(
    this.id,
    this.name,
    this.phone,
    this.email,
    this.cartId,
  );

  factory UserDetailDto.fromJson(Map<String, dynamic> json) => _$UserDetailDtoFromJson(json);
}
