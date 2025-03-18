import 'package:NearMii/config/debouncer.dart';
import 'package:NearMii/feature/common_widgets/history_shimmer.dart';
import 'package:NearMii/feature/common_widgets/notification_tile.dart';
import 'package:NearMii/feature/history/presentation/provider/state_notifier/history_notifier.dart';
import 'package:NearMii/feature/notification/presentation/provider/notification_provider.dart';
import 'package:flutter/material.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/feature/common_widgets/app_text.dart';
import 'package:NearMii/feature/common_widgets/custom_appbar_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:skeletonizer/skeletonizer.dart';

class NotificationView extends ConsumerStatefulWidget {
  const NotificationView({super.key});

  @override
  ConsumerState<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends ConsumerState<NotificationView> {
  // late Future<List<TileModel>> tiles;

  final _debounce = Debouncer();

  void onSearchChanged(query) {
    final notifier = ref.read(notificationProvider.notifier);
    _debounce.run(() {
      notifier.notificationApi(isFromSear: true);
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        final notifier = ref.read(notificationProvider.notifier);

        // if (notifier.recentHistoryList.isEmpty) {
        notifier.notificationApi(isFromSear: false);
        // }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(notificationProvider);
    final notification = ref.watch(notificationProvider.notifier);

    return Scaffold(
      backgroundColor: AppColor.greyf9f9f9,
      body:
          (notification.isNotificationLoading &&
                  (notification.isFromSearch == false))
              ? const Column(
                  children: [
                    CustomAppbarWidget(
                      title: AppString.notification,
                    ),
                    // Padding(
                    //   padding:
                    //       EdgeInsets.symmetric(horizontal: context.width * .05),
                    //   child: CustomSearchBarWidget(
                    //     controller: notification.notificationSearchController,
                    //     onChanged: onSearchChanged,
                    //   ),
                    // ),
                    Expanded(child: HistoryShimmer()),
                  ],
                )
              : SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      const CustomAppbarWidget(
                        title: AppString.notification,
                      ),
                      13.verticalSpace,
                      ((notification.recentNotificationList.isEmpty) &&
                              (notification
                                  .notificationLastWeekTimeList.isEmpty) &&
                              (notification
                                  .notificationLastMonthTimeList.isEmpty))
                          ? SizedBox(
                              height: context.height * .8,
                              child: Center(
                                child: AppText(
                                  text: "No Notification yet",
                                  fontSize: 16.sp,
                                  color: AppColor.btnColor,
                                ),
                              ),
                            )
                          : SizedBox(
                              height: context.height * .9,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: context.width * .05),
                                child: SingleChildScrollView(
                                  physics: const NeverScrollableScrollPhysics(),
                                  child: Column(
                                    children: [
                                      // CustomSearchBarWidget(
                                      //   controller: notification
                                      //       .notificationSearchController,
                                      //   onChanged: onSearchChanged,
                                      // ),
                                      Skeletonizer(
                                        enabled:
                                            notification.isNotificationLoading,
                                        child: SizedBox(
                                          height: context.height * .81,
                                          child: SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                //RECENT HISTORY DATA
                                                notification
                                                        .recentNotificationList
                                                        .isNotEmpty
                                                    ? Container(
                                                        margin: const EdgeInsets
                                                            .symmetric(
                                                            vertical: 5),
                                                        decoration: BoxDecoration(
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: AppColor
                                                                    .grey999
                                                                    .withOpacity(
                                                                        .5),
                                                                spreadRadius: 0,
                                                                blurRadius: 2,
                                                                offset:
                                                                    const Offset(
                                                                        0, 1),
                                                              ),
                                                            ],
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15),
                                                            color: AppColor
                                                                .primary),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      15,
                                                                  vertical: 11),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        top: 5),
                                                                child: AppText(
                                                                  text: AppString
                                                                      .recent,
                                                                  fontSize:
                                                                      18.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),
                                                              notification
                                                                      .recentNotificationList
                                                                      .isNotEmpty
                                                                  ? SizedBox(
                                                                      child: ListView
                                                                          .builder(
                                                                        physics:
                                                                            const NeverScrollableScrollPhysics(),
                                                                        shrinkWrap:
                                                                            true,
                                                                        padding: const EdgeInsets
                                                                            .symmetric(
                                                                            vertical:
                                                                                3),
                                                                        itemCount: notification
                                                                            .recentNotificationList
                                                                            .length,
                                                                        itemBuilder:
                                                                            (context,
                                                                                index) {
                                                                          var data =
                                                                              notification.recentNotificationList[index];
                                                                          var timeAgo =
                                                                              getTimeAgo(data.createdAt);
                                                                          return Padding(
                                                                            padding:
                                                                                const EdgeInsets.symmetric(vertical: 5),
                                                                            child:
                                                                                AnimationConfiguration.staggeredList(
                                                                              position: index,
                                                                              child: SlideAnimation(
                                                                                curve: Curves.easeInOutCirc,
                                                                                horizontalOffset: -100,
                                                                                child: FadeInAnimation(
                                                                                  child: NotificationTile(
                                                                                    type: "${data.type}",
                                                                                    onTap: () {},
                                                                                    time: timeAgo,
                                                                                    title: data.message ?? '',
                                                                                    leadingIcon: "",
                                                                                    subtitle: 'Check out their profile.',
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          );

                                                                          //     NotificationTile(
                                                                          //   isHistory: true,
                                                                          //   time: timeAgo,
                                                                          //   title: data.profile?.name ?? "",
                                                                          //   leadingIcon: data.profile?.profilePhoto ?? '',
                                                                          //   subtitle: data.profile?.designation ?? "",
                                                                          //   onTap: () {
                                                                          //     toNamed(
                                                                          //       context,
                                                                          //       Routes.otherUserProfile,
                                                                          //       args: data.profile!.id.toString(),
                                                                          //     );
                                                                          //   },
                                                                          // ),
                                                                          // );
                                                                        },
                                                                      ),
                                                                    )
                                                                  : const SizedBox(
                                                                      height:
                                                                          100,
                                                                      child:
                                                                          Center(
                                                                        child: AppText(
                                                                            text:
                                                                                "No History on Recent time"),
                                                                      ),
                                                                    )
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    : const SizedBox(),
                                                notification
                                                        .notificationLastWeekTimeList
                                                        .isNotEmpty
                                                    ? Container(
                                                        margin: const EdgeInsets
                                                            .symmetric(
                                                            vertical: 15),
                                                        decoration: BoxDecoration(
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: AppColor
                                                                    .grey999
                                                                    .withOpacity(
                                                                        .5),
                                                                spreadRadius: 0,
                                                                blurRadius: 2,
                                                                offset:
                                                                    const Offset(
                                                                        0, 1),
                                                              ),
                                                            ],
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15),
                                                            color: AppColor
                                                                .primary),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      15,
                                                                  vertical: 11),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        top: 5),
                                                                child: AppText(
                                                                  text: AppString
                                                                      .lastWeek,
                                                                  fontSize:
                                                                      18.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),
                                                              notification
                                                                      .notificationLastWeekTimeList
                                                                      .isNotEmpty
                                                                  ? SizedBox(
                                                                      child: ListView
                                                                          .builder(
                                                                        physics:
                                                                            const NeverScrollableScrollPhysics(),
                                                                        shrinkWrap:
                                                                            true,
                                                                        padding: const EdgeInsets
                                                                            .symmetric(
                                                                            vertical:
                                                                                3),
                                                                        itemCount: notification
                                                                            .notificationLastWeekTimeList
                                                                            .length,
                                                                        itemBuilder:
                                                                            (context,
                                                                                index) {
                                                                          var data =
                                                                              notification.notificationLastWeekTimeList[index];
                                                                          var timeAgo =
                                                                              getTimeAgo(data.createdAt);
                                                                          return Padding(
                                                                            padding:
                                                                                const EdgeInsets.symmetric(vertical: 5),
                                                                            child:
                                                                                AnimationConfiguration.staggeredList(
                                                                              position: index,
                                                                              child: SlideAnimation(
                                                                                curve: Curves.easeInOutCirc,
                                                                                horizontalOffset: 100,
                                                                                child: FadeInAnimation(
                                                                                  child: NotificationTile(
                                                                                    type: "${data.type}",
                                                                                    onTap: () {},
                                                                                    time: timeAgo,
                                                                                    title: data.message ?? '',
                                                                                    leadingIcon: "",
                                                                                    subtitle: 'Check out their profile.',
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          );
                                                                        },
                                                                      ),
                                                                    )
                                                                  : const SizedBox(
                                                                      height:
                                                                          100,
                                                                      child:
                                                                          Center(
                                                                        child: AppText(
                                                                            text:
                                                                                "No History on Last week"),
                                                                      ),
                                                                    )
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    : const SizedBox(),

                                                notification
                                                        .notificationLastMonthTimeList
                                                        .isNotEmpty
                                                    ? Container(
                                                        margin: const EdgeInsets
                                                            .symmetric(
                                                            vertical: 8),
                                                        decoration: BoxDecoration(
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: AppColor
                                                                    .grey999
                                                                    .withOpacity(
                                                                        .5),
                                                                spreadRadius: 0,
                                                                blurRadius: 2,
                                                                offset:
                                                                    const Offset(
                                                                        0, 1),
                                                              ),
                                                            ],
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15),
                                                            color: AppColor
                                                                .primary),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      15,
                                                                  vertical: 11),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        top: 5),
                                                                child: AppText(
                                                                  text: AppString
                                                                      .lastMonth,
                                                                  fontSize:
                                                                      18.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),
                                                              notification
                                                                      .notificationLastMonthTimeList
                                                                      .isNotEmpty
                                                                  ? SizedBox(
                                                                      child: ListView
                                                                          .builder(
                                                                        physics:
                                                                            const NeverScrollableScrollPhysics(),
                                                                        shrinkWrap:
                                                                            true,
                                                                        padding: const EdgeInsets
                                                                            .symmetric(
                                                                            vertical:
                                                                                3),
                                                                        itemCount: notification
                                                                            .notificationLastMonthTimeList
                                                                            .length,
                                                                        itemBuilder:
                                                                            (context,
                                                                                index) {
                                                                          var data =
                                                                              notification.notificationLastMonthTimeList[index];
                                                                          var timeAgo =
                                                                              getTimeAgo(data.createdAt);
                                                                          return Padding(
                                                                            padding:
                                                                                const EdgeInsets.symmetric(vertical: 5),
                                                                            child:
                                                                                AnimationConfiguration.staggeredList(
                                                                              position: index,
                                                                              child: SlideAnimation(
                                                                                curve: Curves.easeInOutCirc,
                                                                                horizontalOffset: -100,
                                                                                child: FadeInAnimation(
                                                                                  child: NotificationTile(
                                                                                    type: "${data.type}",
                                                                                    onTap: () {},
                                                                                    time: timeAgo,
                                                                                    title: data.message ?? '',
                                                                                    leadingIcon: "",
                                                                                    subtitle: 'Check out their profile.',
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          );
                                                                        },
                                                                      ),
                                                                    )
                                                                  : const SizedBox(
                                                                      height:
                                                                          100,
                                                                      child:
                                                                          Center(
                                                                        child: AppText(
                                                                            text:
                                                                                "No History on Last month"),
                                                                      ),
                                                                    )
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    : const SizedBox(),

                                                SizedBox(
                                                  height: context.height * .2,
                                                  width: context.width,
                                                  // child: const Text(" "),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
    );
  }
}
