import 'package:events_app/models/categories_response_model.dart';
import 'package:events_app/models/event_details_response_model.dart';
import 'package:events_app/provider/events_provider.dart';
import 'package:events_app/utils/colors.dart';
import 'package:events_app/utils/notification_controller.dart';
import 'package:events_app/utils/textstyles.dart';
import 'package:events_app/views/event_details/event_details_page.dart';
import 'package:events_app/widgets/event_list_item_widget.dart';
import 'package:events_app/widgets/filter_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

///start
class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  TextEditingController searchController = TextEditingController();
  List<EventCategoriesResponseModel> model = <EventCategoriesResponseModel>[];
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _fetchEvent("all");
    FLocalNotificationService.showNotification(
      id: 1,
      title: "Welcome Back!",
      body: "Glad to see you back",
    );
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filterEventsP = ref.watch(eventNotifierProvider);
    final eventCatFuture = ref.watch(eventFutureProvider);
    return Scaffold(
      appBar: appBarWidget(),
      body: ref.read(eventNotifierProvider.notifier).isLoading
          ? Center(child: SpinKitFadingCube(color: AppColor.primary, size: 20))
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20).r,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      filterByCategory(context, eventCatFuture),
                      filterByPrice(),
                      filterByDate(),
                    ],
                  ),
                ),
                15.verticalSpace,
                eventsListView(filterEventsP),
              ],
            ),
    );
  }

  Widget eventsListView(List<Item>? filterEventsP) {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) => 20.verticalSpace,
        padding: EdgeInsets.only(left: 5, right: 15, bottom: 15).r,
        shrinkWrap: true,
        itemCount: filterEventsP?.length ?? 0,
        itemBuilder: (context, index) {
          final eventItem = filterEventsP?[index];
          return EventWidget(
            shareUrl: eventItem?.shareUrl ?? "",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      EventDetailPage(event: filterEventsP![index]),
                ),
              );
            },
            title: eventItem?.eventname ?? "",
            area: eventItem?.venue?.city ?? "No Venue Founded",
            date: eventItem?.startTimeDisplay ?? "",
            bannerLink: eventItem?.bannerUrl ?? "",
          );
        },
      ),
    );
  }

  Widget filterByDate() => FilterButtonWidget(text: "Price", onTap: () {});

  Widget filterByPrice() => FilterButtonWidget(text: "Date", onTap: () {});

  Widget filterByCategory(
    BuildContext context,
    AsyncValue<List<EventCategoriesResponseModel>?> eventCatFuture,
  ) {
    return FilterButtonWidget(
      text: "Category",
      onTap: () {
        focusNode.unfocus();
        showModalBottomSheet(
          isDismissible: false,
          context: context,
          builder: (context) => Column(
            children: [
              10.verticalSpace,
              Text(
                "Choose your preferred category",
                style: AppTextStyles.largeHeading,
              ),
              15.verticalSpace,
              eventCatFuture.when(
                data: (cat) => ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 20).r,
                  separatorBuilder: (context, index) => Column(
                    children: [
                      10.verticalSpace,
                      Divider(
                        height: 2,
                        thickness: 2,
                        color: AppColor.lightGrey,
                      ),
                      10.verticalSpace,
                    ],
                  ),
                  shrinkWrap: true,
                  itemCount: cat?.length ?? 0,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      _fetchEvent(cat?[index].category ?? "");
                      //filterLists(cat);
                      Navigator.pop(context);
                    },
                    child: Text(
                      cat?[index].category ?? "",
                      style: AppTextStyles.btnMediumLightHeading,
                    ),
                  ),
                ),
                error: (error, stackTrace) => Center(child: Text("$error")),
                loading: () => CircularProgressIndicator(),
              ),
            ],
          ),
        );
      },
    );
  }

  PreferredSize appBarWidget() {
    return PreferredSize(
      preferredSize: Size.fromHeight(110.h),
      child: Stack(
        children: [
          Image.network(
            "https://cdn2.allevents.in/transup/90/b744a057ac42349b23a0e6534da9ae/Rectangle-293.webp",
            width: double.infinity,
            height: 170.h,
            fit: BoxFit.fill,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15).r,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                40.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.arrow_back_outlined,
                      color: AppColor.white,
                      size: 20,
                    ),
                    30.horizontalSpace,
                    Text(
                      "Events in Ahmedabad",
                      style: AppTextStyles.btnMediumLightHeading.copyWith(
                        fontWeight: FontWeight.w400,
                        color: AppColor.white,
                        fontSize: 18.spMin,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.logout, color: AppColor.white),
                      onPressed: () {
                        ref.read(authRepositoryProvider).signOutUser();
                      },
                    ),
                  ],
                ),
                5.verticalSpace,
                searchTextField(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget searchTextField() {
    return TextField(
      onChanged: (s) {
        ref.read(eventNotifierProvider.notifier).filterEvent(s);
      },
      focusNode: focusNode,
      controller: searchController,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 20).r,
        hintText: "What do you feel like doing ?",
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25).r,
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Future<void> _fetchEvent(String endpoint) async {
    try {
      await ref
          .read(eventNotifierProvider.notifier)
          .loadEvents("/$endpoint.json");
    } catch (e) {
      e.toString();
    }
  }

  /// filtering method for events
  void filterLists(String key) {
    ref.read(eventNotifierProvider.notifier).filterEvent(key);
  }
}

///end
