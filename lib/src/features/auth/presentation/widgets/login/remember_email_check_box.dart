// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maingames_flutter_test/src/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:maingames_flutter_test/src/shared/widgets/common/app_custom_checkbox.dart';

class RememberEmailCheckBox extends StatelessWidget {
  const RememberEmailCheckBox({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LoginBloc>();
    return AnimatedBuilder(
      animation: bloc.rememberPhoneController,
      builder: (context, widget) {
        return AppCustomCheckBox(
          onChanged: (bool isChecked) {
            bloc.rememberPhoneController.value = isChecked;
          },
          isChecked: bloc.rememberPhoneController.value,
          title: 'login.rememberPhone'.tr(),
        );
      },
    );
  }
}
