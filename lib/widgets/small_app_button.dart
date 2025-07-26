import 'package:events_app/utils/colors.dart';
import 'package:events_app/utils/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SmallAppButton extends StatelessWidget {
  const SmallAppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.iconData,
    this.btnColor,
    this.textColor,
  });
  final String text;
  final void Function()? onPressed;
  final Color? btnColor;
  final Color? textColor;
  final IconData? iconData;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        fixedSize: Size(1.sw, 35.h),
        backgroundColor: btnColor ?? Color(0xfff5f5f5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5).r,
          side: BorderSide(color: AppColor.lightGrey),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          iconData == null
              ? SizedBox()
              : Icon(iconData, color: AppColor.grey, size: 20),
          iconData == null ? 0.horizontalSpace : 2.horizontalSpace,
          Text(
            text,
            style: AppTextStyles.mediumLightHeading.copyWith(
              fontSize: 14.spMin,
              color: textColor ?? AppColor.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
