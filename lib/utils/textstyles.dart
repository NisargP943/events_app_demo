import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'colors.dart';

class AppTextStyles {
  static final largeHeading = TextStyle(
    fontSize: 22.spMin,
    fontWeight: FontWeight.w600,
  );
  static final mediumLightHeading = TextStyle(
    fontSize: 20.spMin,
    fontWeight: FontWeight.w200,
  );

  static final btnMediumLightHeading = TextStyle(
    fontSize: 16.spMin,
    fontWeight: FontWeight.w500,
    color: AppColor.black,
  );

  static final lightGreySmall = TextStyle(
    color: AppColor.greyShadow,
    fontSize: 13.spMin,
    fontWeight: FontWeight.w400,
  );

  static final large50Heading = TextStyle(
    fontSize: 50.spMin,
    height: 1,
    fontWeight: FontWeight.w600,
  );
}
