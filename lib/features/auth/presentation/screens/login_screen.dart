// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_base_app/core/base_bloc/base_state.dart';
import 'package:flutter_base_app/core/utils/app_colors.dart';
import 'package:flutter_base_app/core/utils/evm_colors.dart';
import 'package:flutter_base_app/core/utils/extensions/num_extensions.dart';
import 'package:flutter_base_app/core/utils/extensions/ui_extensions.dart';
import 'package:flutter_base_app/config/app_config.dart';
import 'package:flutter_base_app/config/app_router.dart';
import 'package:flutter_base_app/config/theme/app_theme.dart';
import 'package:flutter_base_app/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:flutter_base_app/features/auth/presentation/widgets/login/login_background.dart';
import 'package:flutter_base_app/features/auth/presentation/widgets/login/login_buttons.dart';
import 'package:flutter_base_app/features/auth/presentation/widgets/login/login_email_input.dart';
import 'package:flutter_base_app/features/auth/presentation/widgets/login/login_password_input.dart';
import 'package:flutter_base_app/features/auth/presentation/widgets/login/remember_email_check_box.dart';
import 'package:flutter_base_app/features/home/presentation/screens/home_screen.dart';
import 'package:flutter_base_app/shared/widgets/custom_bloc_builder.dart';
import 'package:flutter_base_app/shared/widgets/custom_bloc_consumer.dart';

class LoginScreen extends StatefulWidget {
  static const route = '/login';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late LoginBloc _loginBloc;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _loginBloc = context.read<LoginBloc>();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant LoginScreen oldWidget) {
    _loginBloc = context.read<LoginBloc>();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLoginPressed() {
    if (_formKey.currentState!.validate()) {
      _loginBloc.add(OnLogin(
        email: _emailController.text,
        password: _passwordController.text,
      ));
    }
  }

  void _onLoginSuccessfully() {
    AppRouter.popAllAndPushNamed(HomeScreen.route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EVMColors.white,
      floatingActionButton: AppConfig.config.isDevelopment
          ? FillTestAccountButton(
              emailController: _emailController,
              passwordController: _passwordController,
            )
          : null,
      body: Stack(
        children: [
          const LoginBackground(),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: .15.sw),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'login.appTitle'.tr(),
                          style: textTheme.titleLarge
                              .withColor(context.isKeyboardShowing ? AppColors.black : AppColors.primary)
                              .withSize(40.sp),
                        ),
                        52.shb,
                        LoginEmailInput(controller: _emailController),
                        16.shb,
                        LoginPasswordInput(
                          controller: _passwordController,
                          onSubmited: (text) {
                            _onLoginPressed();
                          },
                        ),
                        6.shb,
                        CustomBlocBuilder<LoginBloc>(
                          buildForStates: const [RememberEmailCheckChanged],
                          handleLoading: false,
                          builder: (state) {
                            return RememberEmailCheckBox(
                              onCheckChanged: (value) {
                                _loginBloc.add(OnRememberEmailChanged(isRemembered: value));
                              },
                              isChecked: state is RememberEmailCheckChanged ? state.isRemembered : false,
                            );
                          },
                        ),
                        4.shb,
                        CustomBlocConsumer<LoginBloc>(
                          handleLoading: false,
                          buildForStates: const [LoginSuccess, LoginFailed, ErrorState, LoadingState],
                          listenForStates: const [LoginSuccess],
                          listener: (state) {
                            if (state is LoginSuccess) {
                              _onLoginSuccessfully();
                            }
                          },
                          builder: (state) {
                            return LoginButton(
                              onPressed: _onLoginPressed,
                              isLoading: state is LoadingState,
                            );
                          },
                        ),
                        const ForgotPasswordButton(),
                        const SignUpButton(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FillTestAccountButton extends StatelessWidget {
  const FillTestAccountButton({
    super.key,
    required TextEditingController emailController,
    required TextEditingController passwordController,
  })  : _emailController = emailController,
        _passwordController = passwordController;

  final TextEditingController _emailController;
  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        _emailController.text = 'test@maingames.com';
        _passwordController.text = 'aa123456';
      },
      child: const Text(
        'Test account',
        style: TextStyle(color: Colors.white),
        textAlign: TextAlign.center,
      ),
    );
  }
}
