import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_base_app/core/models/base_response.dart';
import 'package:flutter_base_app/features/auth/data/data_sources/auth_data_source.dart';
import 'package:flutter_base_app/features/auth/data/models/request/login_request_model.dart';
import 'package:flutter_base_app/features/auth/data/models/response/login_model.dart';

class TestAuthDataSource implements AuthDatasource {
  final Map<String, String> testAccounts = {
    'test@maingames.com': 'aa123456',
    'test2@maingames.com': 'aa123456',
  };

  @override
  Future<BaseResponse<LoginModel?>> login(LoginRequestModel param) async {
    await Future.delayed(const Duration(seconds: 1));
    if (testAccounts[param.email] == param.password) {
      return Future.value(BaseResponse<LoginModel?>(
        LoginModel(
          token: 'token',
          userID: 1,
          cartId: 1,
        ),
        true,
        200,
        null,
      ));
    } else {
      return Future.value(BaseResponse<LoginModel?>(
        null,
        false,
        401,
        'loginFailed'.tr(),
      ));
    }
  }
}
