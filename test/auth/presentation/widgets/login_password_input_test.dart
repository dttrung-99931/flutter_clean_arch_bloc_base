import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_base_app/app.dart';
import 'package:flutter_base_app/features/auth/presentation/widgets/login/login_password_input.dart';

import '../../../common/base_setup.dart';
import '../../../common/widget_test_app.dart';

void main() {
  setUpAll(() async {
    await baseTestSetup();
    await setupApp(isTest: true);
  });

  tearDownAll(() {});

  group('LoginPasswordInput', () {
    testWidgets('should contains TextField and input text corectly', (tester) async {
      final emailController = TextEditingController();
      await tester.pumpWidget(
        MaingamesWidgetTestApp(
          widget: LoginPasswordInput(
            controller: emailController,
            onSubmited: (value) {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      final pwdInput = find.byType(LoginPasswordInput);
      expect(pwdInput, findsOneWidget);

      final hintText = find.text('login.passwordHint'.tr());
      expect(hintText, findsOneWidget);

      await tester.enterText(pwdInput, 'aa123456');

      expect(emailController.text, 'aa123456');
      await tester.showKeyboard(pwdInput);
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();
    });
  });
}
