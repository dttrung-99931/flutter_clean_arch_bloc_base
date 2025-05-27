import 'package:maingames_flutter_test/core/model/base_response.dart';
import 'package:maingames_flutter_test/src/features/auth/data/data_sources/auth_data_source.dart';
import 'package:maingames_flutter_test/src/features/auth/data/dtos/request/login_request_dto.dart';
import 'package:maingames_flutter_test/src/features/auth/data/dtos/response/login_response_dto.dart';

class TestAuthDataSource implements AuthDatasource {
  final Map<String, String> testAccounts = {
    'test@maingames.com': 'aa123456',
    'test2@maingames.com': 'aa123456',
  };

  @override
  Future<BaseResponse<LoginResponseDto?>> login(LoginRequestDto param) async {
    await Future.delayed(const Duration(seconds: 1));
    if (testAccounts[param.email] == param.password) {
      return Future.value(BaseResponse<LoginResponseDto?>(
        LoginResponseDto(
          token: 'token',
          userID: 1,
          cartId: 1,
        ),
        true,
        200,
        null,
      ));
    } else {
      return Future.value(BaseResponse<LoginResponseDto?>(
        null,
        false,
        401,
        'Unauthorized',
      ));
    }
  }
}
