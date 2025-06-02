// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable(explicitToJson: true, createToJson: false)
class UserModel {
  final int id;
  final String name;
  final String phone;
  final String email;
  final int cartId;

  UserModel(
    this.id,
    this.name,
    this.phone,
    this.email,
    this.cartId,
  );

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
}
