import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:maingames_flutter_test/app.dart';
import 'package:maingames_flutter_test/features/auth/presentation/screens/login_screen.dart';
import 'package:maingames_flutter_test/features/auth/presentation/widgets/login/login_buttons.dart';
import 'package:maingames_flutter_test/features/auth/presentation/widgets/login/login_email_input.dart';
import 'package:maingames_flutter_test/features/auth/presentation/widgets/login/login_password_input.dart';
import 'package:maingames_flutter_test/features/home/presentation/screens/home_screen.dart';

import '../test/common/base_setup.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await baseTestSetup();
    await setupApp(isTest: true);
  });

  group('Login', () {
    testWidgets('Test login successfully', (tester) async {
      await tester.pumpWidget(const App(initialRoute: LoginScreen.route));
      await tester.pumpAndSettle();

      await typeAccount(tester, email: 'test@maingames.com', password: 'aa123456');
      await tapLoginButton(tester);
      await tester.pumpAndSettle();

      // Login succeesfully, and navigate to payment screen
      final paymentScreen = find.byType(HomeScreen);
      expect(paymentScreen, findsOneWidget);
    });

    testWidgets('Test login failed', (tester) async {
      await tester.pumpWidget(const App(initialRoute: LoginScreen.route));
      await tester.pumpAndSettle();

      await typeAccount(tester, email: 'test@maingames.com', password: 'aa123456___'); // wrong password

      await tapLoginButton(tester);
      await tester.pumpAndSettle();

      // Check overlay message showing
      // final overlayMsg = find.text('login.loginFailed'.tr());
      // expect(overlayMsg, findsOneWidget);

      // Login failed, users stay in login screen
      final paymentScreen = find.byType(HomeScreen);
      expect(paymentScreen, findsNothing);
    });
  });

  testWidgets('Test input validations', (tester) async {
    await tester.pumpWidget(const App(initialRoute: LoginScreen.route));
    await tester.pumpAndSettle();

    // Miss email
    await typeAccount(tester, email: '', password: 'aa123456');
    await tapLoginButton(tester);
    await tester.pumpAndSettle();
    expect(find.text('messages.emailIsRequired'.tr()), findsOneWidget);

    // Miss password
    await typeAccount(tester, email: 'test@maingames.com', password: '');
    await tapLoginButton(tester);
    await tester.pumpAndSettle();
    expect(
      find.text('messages.enterRequiredFieldTemp'.tr(args: ['login.password'.tr()])),
      findsOneWidget,
    );

    // Invalid email
    await typeAccount(tester, email: 'test@maingames', password: 'aa123456');
    await tapLoginButton(tester);
    await tester.pumpAndSettle();
    expect(find.text('messages.plsEnterValidEmail'.tr()), findsOneWidget);

    // Invalid email emoji
    await typeAccount(tester, email: '🥶🥶🥶@maingames', password: 'aa123456');
    await tapLoginButton(tester);
    await tester.pumpAndSettle();
    expect(find.text('messages.plsEnterValidEmail'.tr()), findsOneWidget);

    // Login failed, users stay in login screen
    final paymentScreen = find.byType(HomeScreen);
    expect(paymentScreen, findsNothing);
  });

  // TODO: Test remember email
  // TODO: Test network error
}

Future<void> tapLoginButton(WidgetTester tester) async {
  final btn = find.byType(LoginButton);
  expect(btn, findsOneWidget);
  await tester.tap(btn);
}

Future<void> typeAccount(WidgetTester tester, {required String email, required String password}) async {
  final emailInput = find.byType(LoginEmailInput);
  expect(emailInput, findsOneWidget);
  await tester.enterText(emailInput, email);

  final pwdInput = find.byType(LoginPasswordInput);
  expect(pwdInput, findsOneWidget);
  await tester.enterText(pwdInput, password);
}
