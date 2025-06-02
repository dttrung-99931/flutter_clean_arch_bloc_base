// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:maingames_flutter_test/core/utils/app_colors.dart';
import 'package:maingames_flutter_test/shared/widgets/common/triangle_clip_path.dart';

class LoginBackground extends StatelessWidget {
  const LoginBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            ClipPath(clipper: TriangleClipPath(), child: Container(height: 128, color: AppColors.primary)),
            // 16.shb,
            // Text(
            //   'PanShop',
            //   style: textTheme.titleLarge.withColor(AppColors.primary).withSize(40.sp),
            // ),
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: RotatedBox(
            quarterTurns: 2,
            child: ClipPath(clipper: TriangleClipPath(), child: Container(height: 128, color: AppColors.primary)),
          ),
        ),
      ],
    );
  }
}
