import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maingames_flutter_test/app.dart';
import 'package:maingames_flutter_test/src/features/auth/presentation/widgets/login/remember_email_check_box.dart';

import '../../../common/base_setup.dart';
import '../../../common/widget_test_app.dart';

void main() {
  setUpAll(() async {
    await baseTestSetup();
    await setupApp(isTest: true);
  });

  tearDownAll(() {});

  group('RememberEmailCheckBox', () {
    testWidgets('Test RememberEmailCheckBox widget', (tester) async {
      bool isChecked = false;
      await tester.pumpWidget(
        MaingamesWidgetTestApp(
          widget: RememberEmailCheckBox(
            onCheckChanged: (value) {
              isChecked = value;
            },
            isChecked: isChecked,
          ),
        ),
      );
      await tester.pumpAndSettle();

      final cb = find.byType(RememberEmailCheckBox);
      expect(cb, findsOneWidget);

      final hintText = find.text('login.rememberEmail'.tr());
      expect(hintText, findsOneWidget);

      await tester.tap(cb);
      await tester.pumpAndSettle();
      expect(isChecked, true);
    });
  });
}
