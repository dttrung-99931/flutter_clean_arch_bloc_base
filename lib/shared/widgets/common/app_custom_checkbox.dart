import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_base_app/core/utils/app_colors.dart';
import 'package:flutter_base_app/config/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AppCustomCheckBox extends StatelessWidget {
  final void Function(bool isChecked) onChanged;
  final bool isChecked;
  final String title;
  const AppCustomCheckBox({super.key, required this.onChanged, required this.isChecked, required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!isChecked),
      child: Transform.translate(
        offset: const Offset(-8, 0),
        child: Row(
          children: [
            SizedBox(
              width: 40,
              height: 40,
              child: Checkbox(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                side: BorderSide(color: AppColors.border, width: 1),
                fillColor: WidgetStateColor.resolveWith((states) => AppColors.primary),
                value: isChecked,
                onChanged: (isChecked) {
                  onChanged(isChecked ?? false);
                },
              ),
            ),
            Text(tr(title), style: textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
