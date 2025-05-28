// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:maingames_flutter_test/src/shared/widgets/common/app_custom_checkbox.dart';

class RememberEmailCheckBox extends StatelessWidget {
  const RememberEmailCheckBox({
    super.key,
    required this.onCheckChanged,
    required this.isChecked,
  });
  final ValueChanged<bool> onCheckChanged;
  final bool isChecked;

  @override
  Widget build(BuildContext context) {
    return AppCustomCheckBox(
      onChanged: onCheckChanged,
      isChecked: isChecked,
      title: 'login.rememberEmail'.tr(),
    );
  }
}
