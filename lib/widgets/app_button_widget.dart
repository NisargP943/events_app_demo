import 'package:events_app/utils/colors.dart';
import 'package:events_app/utils/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppButtonWidget extends StatelessWidget {
  const AppButtonWidget({super.key, required this.text, this.onPressed});

  final String text;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        fixedSize: Size(1.sw, 38.h),
        backgroundColor: AppColor.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5).r),
      ),
      child: Text(
        text,
        style: AppTextStyles.mediumLightHeading.copyWith(
          color: AppColor.white,
          fontSize: 16.spMin,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
