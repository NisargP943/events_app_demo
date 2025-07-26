import 'package:cached_network_image/cached_network_image.dart';
import 'package:events_app/generated/assets.dart';
import 'package:events_app/utils/colors.dart';
import 'package:events_app/utils/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:share_plus/share_plus.dart';

class EventWidget extends StatelessWidget {
  const EventWidget({
    super.key,
    required this.title,
    required this.area,
    required this.date,
    required this.bannerLink,
    this.onTap,
    required this.shareUrl,
  });

  final String title;
  final String area;
  final String date;
  final String bannerLink;
  final String shareUrl;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          SizedBox(
            height: 100.h,
            width: 150.h,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12).r,
              child: CachedNetworkImage(
                fit: BoxFit.fill,
                placeholder: (context, url) =>
                    SpinKitWave(color: AppColor.primary, size: 20),
                imageUrl: bannerLink,
                errorWidget: (context, url, error) => Image.asset(
                  Assets.imagesAeLogoPortraitVector,
                  height: 70.h,
                ),
              ),
            ),
          ),
          10.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.btnMediumLightHeading),
                2.verticalSpace,
                Text(area, style: AppTextStyles.lightGreySmall),
                8.verticalSpace,
                Divider(height: 2, thickness: 3, color: AppColor.lightGrey),
                10.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(date, style: AppTextStyles.lightGreySmall),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star_border,
                          color: AppColor.greyShadow,
                          size: 22,
                        ),
                        5.horizontalSpace,
                        IconButton(
                          icon: Icon(
                            Icons.share,
                            color: AppColor.greyShadow,
                            size: 19,
                          ),
                          onPressed: () async {
                            final box =
                                context.findRenderObject() as RenderBox?;
                            await SharePlus.instance.share(
                              ShareParams(
                                text: shareUrl,
                                sharePositionOrigin:
                                    box!.localToGlobal(Offset.zero) & box.size,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
