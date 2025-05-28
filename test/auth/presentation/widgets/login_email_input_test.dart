import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maingames_flutter_test/app.dart';
import 'package:maingames_flutter_test/src/features/auth/presentation/widgets/login/login_email_input.dart';

import '../../../common/base_setup.dart';
import '../../../common/widget_test_app.dart';

void main() {
  setUpAll(() async {
    await baseTestSetup();
    await setupApp(isTest: true);
  });

  tearDownAll(() {});

  group('LoginEmailInput', () {
    testWidgets('Test LoginEmailInput widget', (tester) async {
      final emailController = TextEditingController();
      final focusNode = FocusNode();
      await tester.pumpWidget(
        MaingamesWidgetTestApp(
          widget: LoginEmailInput(
            controller: emailController,
            focusNode: focusNode,
          ),
        ),
      );
      await tester.pumpAndSettle();

      final emailInput = find.byType(LoginEmailInput);
      expect(emailInput, findsOneWidget);

      final hintText = find.text('login.emailHint'.tr());
      expect(hintText, findsOneWidget);

      await tester.enterText(emailInput, 'test@example.com');

      expect(emailController.text, 'test@example.com');
      await tester.showKeyboard(emailInput);
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();
    });
  });
}
