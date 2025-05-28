import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maingames_flutter_test/app.dart';
import 'package:maingames_flutter_test/core/base_bloc/base_event.dart';
import 'package:maingames_flutter_test/core/base_bloc/base_state.dart';
import 'package:maingames_flutter_test/core/utils/storage.dart';
import 'package:maingames_flutter_test/src/config/di/injection.dart';
import 'package:maingames_flutter_test/src/features/auth/domain/repositories/auth_repo.dart';
import 'package:maingames_flutter_test/src/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:maingames_flutter_test/src/features/auth/presentation/screens/login_screen.dart';
import 'package:maingames_flutter_test/src/features/auth/presentation/widgets/login/login_email_input.dart';
import 'package:maingames_flutter_test/src/features/auth/presentation/widgets/login/login_password_input.dart';
import 'package:maingames_flutter_test/src/features/auth/presentation/widgets/login/remember_email_check_box.dart';
import 'package:mockito/annotations.dart';

import '../../../common/base_setup.dart';
import '../../../common/screen_test_app.dart';

class MockLoginBloc extends MockBloc<BaseEvent, BaseState> implements LoginBloc {}

@GenerateMocks([AuthRepo])
void main() {
  late MockLoginBloc loginBloc;

  setUpAll(() async {
    await baseTestSetup();
    getIt.registerTestDependecy<LoginBloc>(MockLoginBloc());
    await setupApp(isTest: true);
    loginBloc = getIt<LoginBloc>() as MockLoginBloc;
  });

  tearDown(() {
    getIt<Storage>().deleteAll();
  });

  tearDownAll(() {
    getIt.reset();
  });

  group('Test login widgets', () {
    testWidgets('Test login widgets', (WidgetTester tester) async {
      whenListen(
        loginBloc,
        Stream<BaseState>.fromIterable([
          RememberEmailCheckChanged(false),
        ]),
        initialState: InitialState(),
      );
      await tester.pumpWidget(const MaingamesScreenTestApp(screen: LoginScreen()));
      await tester.pumpAndSettle();
      expect(find.byType(LoginScreen), findsOneWidget);
      expect(find.byType(LoginEmailInput), findsOneWidget);
      expect(find.byType(LoginPasswordInput), findsOneWidget);
      expect(find.byType(RememberEmailCheckBox), findsOneWidget);
    });
  });
}
