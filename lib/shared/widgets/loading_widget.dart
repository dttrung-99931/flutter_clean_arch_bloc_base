import 'package:flutter_base_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({this.size = 20, this.color = AppColors.primary, super.key});

  final double? size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.square(dimension: size, child: CircularProgressIndicator(color: color, strokeWidth: 1.8.w)),
    );
  }
}
