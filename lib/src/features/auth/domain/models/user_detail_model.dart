// ignore_for_file: public_member_api_docs, sort_constructors_first

class UserDetailModel {
  UserDetailModel({
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

  factory UserDetailModel.fromDto(UserDetailModel model) {
    return UserDetailModel(
      id: model.id,
      name: model.name,
      phone: model.phone,
      email: model.email,
      cartId: model.cartId,
    );
  }
}
