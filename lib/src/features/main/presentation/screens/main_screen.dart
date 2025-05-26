// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:evievm_app/core/utils/constants.dart';
import 'package:evievm_app/core/utils/extensions/num_extensions.dart';
import 'package:evievm_app/core/utils/utils.dart';
import 'package:evievm_app/src/config/theme/app_theme.dart';
import 'package:evievm_app/src/features/main/presentation/blocs/main/main_bloc.dart';
import 'package:evievm_app/src/features/main/presentation/screens/main_shop_screen.dart';
import 'package:evievm_app/src/features/main/presentation/screens/main_user_screen.dart';
import 'package:evievm_app/src/shared/widgets/custom_bloc_consumer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class MainScreen extends StatefulWidget {
  static const router = '/';
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
    mainBloc.add(OnGetAppMode());
  }

  @override
  Widget build(BuildContext context) {
    return CustomBlocConsumer<MainBloc>(listener: (state) async {
      if (state is GetAppModeSuccess) {
        AppTheme.of(context).updateTheme();
        await delay(300.milliseconds);
        FlutterNativeSplash.remove();
      }
    }, builder: (state) {
      if (state is! GetAppModeSuccess) {
        return emptyWidget;
      }
      return state.data == AppMode.shop ? const MainShopScreen() : const MainUserScreen();
    });
  }
}
