import 'package:events_app/utils/colors.dart';
import 'package:events_app/utils/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListTileWidget extends StatelessWidget {
  const ListTileWidget({
    super.key,
    required this.text,
    required this.heading,
    required this.main,
    required this.icon,
    required this.mainIcon,
  });
  final String text;
  final String heading;
  final String main;
  final IconData icon;
  final IconData mainIcon;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Divider(thickness: 4, color: AppColor.lightGrey),
        10.verticalSpace,
        Text(
          heading,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        ListTile(
          dense: true,
          leading: Icon(mainIcon, color: AppColor.grey),
          title: Text(main, style: AppTextStyles.lightGreySmall),
        ),
        TextButton(
          onPressed: () {},
          child: Row(
            children: [
              Icon(icon, size: 18, color: AppColor.primary),
              Text(
                text,
                style: AppTextStyles.lightGreySmall.copyWith(
                  color: AppColor.primary,
                ),
              ),
            ],
          ),
        ),
        Divider(thickness: 4, color: AppColor.lightGrey),
        5.verticalSpace,
      ],
    );
  }
}
