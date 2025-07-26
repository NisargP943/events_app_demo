import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterButtonWidget extends StatelessWidget {
  const FilterButtonWidget({super.key, required this.text, this.onTap});
  final String text;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return ActionChip(
      label: Row(
        children: [
          Text(text),
          5.horizontalSpace,
          Icon(Icons.keyboard_arrow_down_sharp, size: 20),
        ],
      ),
      backgroundColor: Colors.transparent,
      visualDensity: VisualDensity.standard,
      onPressed: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20).r),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10).r,
    );
  }
}
