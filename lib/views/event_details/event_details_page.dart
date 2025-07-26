import 'package:avatar_stack/animated_avatar_stack.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:events_app/generated/assets.dart';
import 'package:events_app/models/event_details_response_model.dart';
import 'package:events_app/utils/colors.dart';
import 'package:events_app/utils/notification_controller.dart';
import 'package:events_app/utils/textstyles.dart';
import 'package:events_app/widgets/app_button_widget.dart';
import 'package:events_app/widgets/feature_widget.dart';
import 'package:events_app/widgets/list_tile_widget.dart';
import 'package:events_app/widgets/small_app_button.dart';
import 'package:events_app/widgets/webivew_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share_plus/share_plus.dart';

class EventDetailPage extends StatefulWidget {
  const EventDetailPage({super.key, required this.event});

  final Item event;

  @override
  State<EventDetailPage> createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  bool isInterested = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              CachedNetworkImage(
                errorWidget: (context, url, error) =>
                    Image.asset(Assets.imagesAeLogoPortraitVector),
                imageUrl: widget.event.bannerUrl ?? "",
                fit: BoxFit.cover,
                height: 0.3.sh,
                width: 1.sw,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15).r,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    10.verticalSpace,
                    Text(
                      "${widget.event.eventname}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    10.verticalSpace,
                    Row(
                      children: [
                        Image.asset(
                          Assets.imagesAeLogoPortraitVector,
                          height: 30.h,
                        ),
                        Expanded(child: Text("Organized by allEvents")),
                      ],
                    ),
                    20.verticalSpace,
                    Text(
                      "Highlights",
                      style: AppTextStyles.largeHeading.copyWith(
                        fontSize: 20.spMin,
                      ),
                    ),
                    10.verticalSpace,

                    FeatureWidget(
                      iconData: Icons.auto_graph_outlined,
                      text: widget.event.venue?.fullAddress ?? "",
                    ),
                    10.verticalSpace,
                    FeatureWidget(
                      iconData: FontAwesomeIcons.locationDot,
                      text: widget.event.venue?.city ?? "",
                    ),
                    10.verticalSpace,
                    FeatureWidget(
                      iconData: FontAwesomeIcons.calendarCheck,
                      text: widget.event.startTimeDisplay ?? "",
                    ),
                    widget.event.tickets?.hasTickets == true
                        ? 10.verticalSpace
                        : 0.verticalSpace,
                    widget.event.tickets?.hasTickets == true
                        ? FeatureWidget(
                            iconData: FontAwesomeIcons.locationDot,
                            text:
                                "${widget.event.tickets?.ticketCurrency} ${widget.event.tickets?.minTicketPrice} To ${widget.event.tickets?.maxTicketPrice}",
                          )
                        : SizedBox(),

                    10.verticalSpace,
                    FeatureWidget(
                      iconData: Icons.people_alt_outlined,
                      text: "58 People are interested",
                    ),
                    5.verticalSpace,
                    Row(
                      children: [
                        AnimatedAvatarStack(
                          height: 30.h,
                          width: 120.w,
                          avatars: [
                            for (var n = 0; n < 10; n++)
                              NetworkImage('https://i.pravatar.cc/150?img=$n'),
                          ],
                        ),
                        2.horizontalSpace,
                        Text(
                          "View All",
                          style: AppTextStyles.lightGreySmall.copyWith(
                            color: AppColor.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    20.verticalSpace,
                    // Button Row
                    shareButtonRow(context),
                    ticketButtonWidget(context),
                    Divider(),
                    25.verticalSpace,
                    Text(
                      'About',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    10.verticalSpace,
                    categoryChipWidget(),
                    5.verticalSpace,
                    Text("${widget.event.eventnameRaw}"),
                    Text(widget.event.startTimeDisplay ?? ""),
                    10.verticalSpace,
                    Text(
                      "1st 2nd 3rd\nGet-medal-prize money-gift hamper-certificate-also every one get medal-certificate-Tshirt In all Categories",
                    ),
                    10.verticalSpace,
                    Text(
                      "Registration fees ${widget.event.tickets?.maxTicketPrice} rupees",
                    ),
                    10.verticalSpace,
                    Text("Including-\n${widget.event.tags!.join(" / ")}"),
                    20.verticalSpace,
                    ListTileWidget(
                      text: "Add to Calender",
                      heading: "Date & Time",
                      main: "${widget.event.startTimeDisplay}",
                      icon: Icons.add,
                      mainIcon: Icons.watch_later_outlined,
                    ),
                    ListTileWidget(
                      text: "View on map",
                      heading: "Location",
                      main: "${widget.event.venue?.fullAddress}",
                      icon: Icons.keyboard_arrow_down,
                      mainIcon: Icons.add_location_outlined,
                    ),
                    Text(
                      'Organized by',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ListTile(
                      leading: Image.asset(
                        Assets.imagesAeLogoPortraitVector,
                        height: 35.h,
                      ),
                      title: Text('All Events'),
                      subtitle: Text('371 Followers · ⭐3.67'),
                    ),
                    Center(child: Text("1 upcoming event")),
                    15.verticalSpace,
                    followAndMessageRow(),
                    20.verticalSpace,
                    Divider(thickness: 4, color: AppColor.lightGrey),
                    reportRowWidget(),
                    Divider(thickness: 4, color: AppColor.lightGrey),
                    10.verticalSpace,
                    Text(
                      'Events You May Like',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    moreEventsListWidget(),

                    20.verticalSpace,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row shareButtonRow(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SmallAppButton(
            onPressed: () {},
            text: "Interested",
            iconData: Icons.star_border,
          ),
        ),
        10.horizontalSpace,
        Expanded(
          child: SmallAppButton(
            onPressed: () async {
              // _onShare method:
              final box = context.findRenderObject() as RenderBox?;

              await SharePlus.instance.share(
                ShareParams(
                  text: widget.event.shareUrl,
                  sharePositionOrigin:
                      box!.localToGlobal(Offset.zero) & box.size,
                ),
              );
            },
            text: "Share",
            iconData: FontAwesomeIcons.share,
          ),
        ),
      ],
    );
  }

  Widget ticketButtonWidget(BuildContext context) {
    return AppButtonWidget(
      text: "Book Tickets",
      onPressed: () {
        widget.event.tickets?.hasTickets == true
            ? Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WebViewMyWidget(
                    url: widget.event.tickets?.ticketUrl ?? "",
                  ),
                ),
              )
            : FLocalNotificationService.showNotification(
                id: 2,
                title: "No Tickets Available",
                body:
                    "Tickets are not available for this event, we are sorry for the inconvenience",
              );
      },
    );
  }

  Widget categoryChipWidget() {
    return Wrap(
      children: widget.event.categories!
          .map(
            (e) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5).r,
              child: Chip(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5).r,
                label: Text(e),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20).r,
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget followAndMessageRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15).r,
      child: Row(
        children: [
          Expanded(
            child: SmallAppButton(
              text: "Follow",
              btnColor: AppColor.primary,
              textColor: AppColor.white,
              onPressed: () {},
            ),
          ),
          20.horizontalSpace,
          Expanded(
            child: SmallAppButton(
              textColor: AppColor.primary,
              text: "Message",
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget reportRowWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () {},
          child: Row(
            children: [
              Icon(Icons.add_circle_outline, size: 18, color: AppColor.primary),
              Text(
                "Add to Curated",
                style: AppTextStyles.lightGreySmall.copyWith(
                  color: AppColor.primary,
                ),
              ),
            ],
          ),
        ),
        TextButton(
          onPressed: () {},
          child: Row(
            children: [
              Icon(Icons.flag_outlined, size: 18, color: AppColor.red),
              Text(
                "Report Event",
                style: AppTextStyles.lightGreySmall.copyWith(
                  color: AppColor.red,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget moreEventsListWidget() {
    return SizedBox(
      height: 0.29.sh,
      child: PageView.builder(
        itemCount: 3,
        itemBuilder: (context, index) => buildEventCard(),
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  Widget buildEventCard() {
    return Card(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(12)).r,
            child: CachedNetworkImage(
              imageUrl: widget.event.bannerUrl ?? "",
              height: 0.29.sh,
              width: 1.sw,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12).r,
            alignment: Alignment.bottomCenter,
            height: 60.h,
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ).r,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                2.verticalSpace,
                Text(
                  widget.event.label ?? "",
                  style: AppTextStyles.lightGreySmall.copyWith(
                    color: AppColor.primary,
                  ),
                ),
                Text(
                  widget.event.eventname ?? "",
                  style: AppTextStyles.btnMediumLightHeading.copyWith(
                    fontSize: 14.spMin,
                  ),
                  maxLines: 1,
                ),
                Text(widget.event.venue?.fullAddress ?? "", maxLines: 1),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
