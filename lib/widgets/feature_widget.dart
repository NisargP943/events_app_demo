import 'package:events_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FeatureWidget extends StatelessWidget {
  const FeatureWidget({super.key, required this.iconData, required this.text});
  final IconData iconData;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FaIcon(iconData, size: 16, color: AppColor.primary),
        SizedBox(width: 4),
        Expanded(child: Text(text)),
      ],
    );
  }
}
