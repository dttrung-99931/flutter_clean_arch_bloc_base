// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:base_project/src/features/auth/data/models/response/user_detail_model.dart';

class UserDetailDto {
  UserDetailDto({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.cartId,
  });
  final int id;
  final String name;
  final String phone;
  final String email;
  final int cartId;

  factory UserDetailDto.fromModel(UserDetailModel model) {
    return UserDetailDto(
      id: model.id,
      name: model.name,
      phone: model.phone,
      email: model.email,
      cartId: model.cartId,
    );
  }
}
