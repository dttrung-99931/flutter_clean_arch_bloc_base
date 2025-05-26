// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:base_project/core/utils/extensions/num_extensions.dart';
import 'package:base_project/src/config/theme/app_theme.dart';
import 'package:base_project/src/shared/widgets/cutstom_button.dart';
import 'package:flutter/material.dart';

class UnregisterWidget extends StatelessWidget {
  const UnregisterWidget({
    super.key,
    required this.title,
    required this.buttonTitle,
    required this.onPressed,
  });
  final String title;
  final String buttonTitle;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        16.shb,
        Text(title, style: textTheme.bodyLarge),
        16.shb,
        CustomButton(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 32),
          title: buttonTitle,
          onPressed: onPressed,
        ),
      ],
    );
  }
}
