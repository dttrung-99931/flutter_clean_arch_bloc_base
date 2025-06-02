import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_base_app/app.dart';
import 'package:flutter_base_app/features/auth/presentation/widgets/login/login_buttons.dart';

import '../../../common/base_setup.dart';
import '../../../common/widget_test_app.dart';

void main() {
  setUpAll(() async {
    await baseTestSetup();
    await setupApp(isTest: true);
  });

  tearDownAll(() {});

  group('LoginButton', () {
    testWidgets('should have correct title and clickable', (tester) async {
      bool isPressed = false;
      await tester.pumpWidget(
        MaingamesWidgetTestApp(
          widget: LoginButton(
            isLoading: false,
            onPressed: () {
              isPressed = true;
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      final btn = find.byType(LoginButton);
      expect(btn, findsOneWidget);

      final hintText = find.text('login.loginButton'.tr());
      expect(hintText, findsOneWidget);

      await tester.tap(btn);
      await tester.pumpAndSettle();
      expect(isPressed, true);
    });
  });
}
