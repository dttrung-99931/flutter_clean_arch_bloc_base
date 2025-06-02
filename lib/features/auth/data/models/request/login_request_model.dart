import 'package:json_annotation/json_annotation.dart';
import 'package:maingames_flutter_test/features/auth/domain/entities/request/login_request.dart';
part 'login_request_model.g.dart';

@JsonSerializable(createFactory: false)
class LoginRequestModel {
  final String email;
  final String password;

  LoginRequestModel({
    required this.email,
    required this.password,
  });

  factory LoginRequestModel.fromEntity(LoginRequest entity) {
    return LoginRequestModel(
      email: entity.email,
      password: entity.password,
    );
  }

  Map<String, dynamic> toJson() => _$LoginRequestModelToJson(this);
}
