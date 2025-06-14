// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter_base_app/core/utils/app_colors.dart';
import 'package:flutter_base_app/core/utils/evm_colors.dart';
import 'package:flutter_base_app/shared/widgets/sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PageIndicator extends StatelessWidget {
  final int totalPages;
  final int currentPage;

  const PageIndicator({super.key, required this.totalPages, required this.currentPage});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 16.h,
      decoration: BoxDecoration(
        color: EVMColors.indicatorBackground.withOpacity(.3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListView.separated(
        padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 12.w),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: totalPages,
        itemBuilder: (context, index) => Container(
          decoration: BoxDecoration(
            color: index == currentPage ? AppColors.white.withOpacity(.7) : AppColors.indicatorInactive,
            shape: BoxShape.circle,
          ),
          width: 8.r,
          height: 8.r,
        ),
        separatorBuilder: (context, index) {
          return sw(10.w);
        },
      ),
    );
  }
}
