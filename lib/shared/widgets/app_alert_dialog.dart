import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_base_app/core/utils/app_colors.dart';
import 'package:flutter_base_app/core/utils/extensions/num_extensions.dart';
import 'package:flutter_base_app/core/utils/extensions/ui_extensions.dart';
import 'package:flutter_base_app/config/app_router.dart';
import 'package:flutter_base_app/shared/widgets/neutral_button.dart';

import '../../config/theme/app_theme.dart';
import 'spacing_row.dart';

class AppAlertDialog extends StatelessWidget {
  const AppAlertDialog({
    this.title = '',
    this.message,
    this.content,
    this.width = 300,
    this.confirmLabel = 'Xác nhận',
    this.negativeLabel,
    this.cancelLabel = 'Hủy bỏ',
    this.onConfirm,
    this.onNegativePressed,
    this.onCancelPressed,
    this.primaryColor,
    this.isDoneIcon = false,
    super.key,
  });

  final String title;
  final String? message;
  final Widget? content;
  final double width;
  final String confirmLabel;
  final String? negativeLabel;
  final String cancelLabel;
  final void Function()? onConfirm;
  final void Function()? onNegativePressed;
  final void Function()? onCancelPressed;
  final Color? primaryColor;
  final bool isDoneIcon;

  static Future<T?> show<T extends Object>({
    required BuildContext context,
    required String title,
    required void Function() onConfirm,
    void Function()? onCancel,
    bool isPositive = false,
  }) async {
    return showDialog(
      context: context,
      builder: (context) => AppAlertDialog(
        primaryColor: isPositive ? AppColors.primary : AppColors.red,
        title: title,
        onConfirm: onConfirm,
        onCancelPressed: onCancel,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final color = primaryColor ?? (isDoneIcon ? AppColors.green2 : AppColors.red);
    return Dialog(
      backgroundColor: AppColors.transparent,
      alignment: Alignment.center,
      child: Stack(
        children: [
          Container(
            width: width,
            margin: EdgeInsets.only(top: 32.h),
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: AppColors.white),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (title.isNotEmpty) ...[
                  8.shb,
                  Text(tr(title), style: textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold)),
                  20.shb,
                ],
                if (message != null) ...[
                  Row(
                    children: [Expanded(child: Text(tr(message!), style: textTheme.bodyLarge!.spacing(-24).light()))],
                  ),
                  10.shb,
                ],
                if (content != null) ...[content!, 24.shb],
                SpacingRow(
                  spacing: 12.w,
                  children: [
                    Expanded(
                      child: NeutralButton(
                        label: cancelLabel,
                        onPressed: onCancelPressed ?? () => AppRouter.hideDialog(context),
                      ),
                    ),
                    if (negativeLabel != null)
                      Expanded(child: NeutralButton(label: negativeLabel!, onPressed: onNegativePressed, color: color)),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          onConfirm?.call();
                          AppRouter.pop();
                        },
                        child: Text(confirmLabel),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // TODO:
          // Positioned(
          //   left: 0,
          //   right: 0,
          //   top: 0,
          //   child: SvgPicture.asset(
          //     isDoneIcon ? Assets.ic.doneCircle : Assets.ic.warningCircle,
          //     width: 64.h,
          //     height: 64.h,
          //   ),
          // ),
        ],
      ),
    );
  }
}
