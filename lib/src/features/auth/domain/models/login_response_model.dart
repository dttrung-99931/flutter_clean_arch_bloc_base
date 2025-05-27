import 'package:maingames_flutter_test/src/features/auth/data/dtos/response/login_response_dto.dart';

class LoginResponseModel {
  final String accessToken;

  LoginResponseModel({required this.accessToken});

  factory LoginResponseModel.fromDto(LoginResponseDto model) {
    return LoginResponseModel(accessToken: model.token);
  }
}
