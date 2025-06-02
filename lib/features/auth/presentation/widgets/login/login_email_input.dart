// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_app/core/utils/validate.dart';
import 'package:flutter_base_app/shared/widgets/text_input.dart';

class LoginEmailInput extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;

  const LoginEmailInput({
    super.key,
    required this.controller,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return TextInput(
      hintText: 'login.emailHint'.tr(),
      controller: controller,
      textInputType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      focusNode: focusNode,
      validator: Validate.email,
    );
  }
}
