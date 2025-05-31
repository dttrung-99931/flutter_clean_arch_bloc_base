import 'package:easy_localization/easy_localization.dart';
import 'package:maingames_flutter_test/core/model/base_response.dart';
import 'package:maingames_flutter_test/src/features/auth/data/data_sources/auth_data_source.dart';
import 'package:maingames_flutter_test/src/features/auth/data/models/request/login_request_model.dart';
import 'package:maingames_flutter_test/src/features/auth/data/models/response/login_response_model.dart';

class TestAuthDataSource implements AuthDatasource {
  final Map<String, String> testAccounts = {
    'test@maingames.com': 'aa123456',
    'test2@maingames.com': 'aa123456',
  };

  @override
  Future<BaseResponse<LoginResponseModel?>> login(LoginRequestModel param) async {
    await Future.delayed(const Duration(seconds: 1));
    if (testAccounts[param.email] == param.password) {
      return Future.value(BaseResponse<LoginResponseModel?>(
        LoginResponseModel(
          token: 'token',
          userID: 1,
          cartId: 1,
        ),
        true,
        200,
        null,
      ));
    } else {
      return Future.value(BaseResponse<LoginResponseModel?>(
        null,
        false,
        401,
        'loginFailed'.tr(),
      ));
    }
  }
}
