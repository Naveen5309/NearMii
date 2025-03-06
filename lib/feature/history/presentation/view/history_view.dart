import 'package:NearMii/config/app_utils.dart';
import 'package:NearMii/config/debouncer.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/core/network/http_service.dart';
import 'package:NearMii/core/utils/routing/routes.dart';
import 'package:NearMii/feature/common_widgets/app_text.dart';
import 'package:NearMii/feature/common_widgets/custom_appbar_widget.dart';
import 'package:NearMii/feature/common_widgets/custom_history_tile.dart';
import 'package:NearMii/feature/common_widgets/custom_search_bar_widget.dart';
import 'package:NearMii/feature/common_widgets/history_shimmer.dart';
import 'package:NearMii/feature/history/presentation/provider/history_provider.dart';
import 'package:NearMii/feature/history/presentation/provider/state_notifier/history_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HistoryView extends ConsumerStatefulWidget {
  const HistoryView({super.key});

  @override
  ConsumerState<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends ConsumerState<HistoryView> {
  // late Future<List<TileModel>> tiles;

  final _debounce = Debouncer();

  void onSearchChanged(query) {
    final notifier = ref.read(historyProvider.notifier);
    _debounce.run(() {
      notifier.historyApi(isFromSear: true);
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        final notifier = ref.read(historyProvider.notifier);

        // if (notifier.recentHistoryList.isEmpty) {
        notifier.historyApi(isFromSear: false);
        // }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(historyProvider);
    final history = ref.watch(historyProvider.notifier);

    return Scaffold(
      backgroundColor: AppColor.greyf9f9f9,
      body: (history.isHistoryLoading && (history.isFromSearch == false))
          ? Column(
              children: [
                const CustomAppbarWidget(
                  title: AppString.history,
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: context.width * .05),
                  child: CustomSearchBarWidget(
                    controller: history.historySearchController,
                    onChanged: onSearchChanged,
                  ),
                ),
                const Expanded(child: HistoryShimmer()),
              ],
            )
          : SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  const CustomAppbarWidget(
                    title: AppString.history,
                  ),
                  SizedBox(
                    height: context.height * .9,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: context.width * .05),
                      child: SingleChildScrollView(
                        physics: const NeverScrollableScrollPhysics(),
                        child: Column(
                          children: [
                            CustomSearchBarWidget(
                              controller: history.historySearchController,
                              onChanged: onSearchChanged,
                            ),
                            Skeletonizer(
                              enabled: history.isHistoryLoading,
                              child: SizedBox(
                                height: context.height * .81,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      //RECENT HISTORY DATA
                                      history.recentHistoryList.isNotEmpty
                                          ? Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5),
                                              decoration: BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: AppColor.grey999
                                                          .withOpacity(.5),
                                                      spreadRadius: 0,
                                                      blurRadius: 2,
                                                      offset:
                                                          const Offset(0, 1),
                                                    ),
                                                  ],
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  color: AppColor.primary),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 15,
                                                        vertical: 11),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 5),
                                                      child: AppText(
                                                        text: AppString.recent,
                                                        fontSize: 18.sp,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    history.recentHistoryList
                                                            .isNotEmpty
                                                        ? SizedBox(
                                                            child: ListView
                                                                .builder(
                                                              physics:
                                                                  const NeverScrollableScrollPhysics(),
                                                              shrinkWrap: true,
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          3),
                                                              itemCount: history
                                                                  .recentHistoryList
                                                                  .length,
                                                              itemBuilder:
                                                                  (context,
                                                                      index) {
                                                                var data = history
                                                                        .recentHistoryList[
                                                                    index];
                                                                var timeAgo =
                                                                    getTimeAgo(data
                                                                        .createdAt);
                                                                return Padding(
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          5),
                                                                  child:
                                                                      CustomTile(
                                                                    isHistory:
                                                                        true,
                                                                    time:
                                                                        timeAgo,
                                                                    title: data
                                                                            .profile
                                                                            ?.name ??
                                                                        "",
                                                                    leadingIcon:
                                                                        data.profile?.profilePhoto ??
                                                                            '',
                                                                    subtitle: data
                                                                            .profile
                                                                            ?.designation ??
                                                                        "",
                                                                    onTap: () {
                                                                      toNamed(
                                                                        context,
                                                                        Routes
                                                                            .otherUserProfile,
                                                                        args: data
                                                                            .profile!
                                                                            .id
                                                                            .toString(),
                                                                      );
                                                                    },
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          )
                                                        : const SizedBox(
                                                            height: 100,
                                                            child: Center(
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
                                      history.historyLastWeekTimeList.isNotEmpty
                                          ? Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 15),
                                              decoration: BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: AppColor.grey999
                                                          .withOpacity(.5),
                                                      spreadRadius: 0,
                                                      blurRadius: 2,
                                                      offset:
                                                          const Offset(0, 1),
                                                    ),
                                                  ],
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  color: AppColor.primary),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 15,
                                                        vertical: 11),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 5),
                                                      child: AppText(
                                                        text:
                                                            AppString.lastWeek,
                                                        fontSize: 18.sp,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    history.historyLastWeekTimeList
                                                            .isNotEmpty
                                                        ? SizedBox(
                                                            child: ListView
                                                                .builder(
                                                              physics:
                                                                  const NeverScrollableScrollPhysics(),
                                                              shrinkWrap: true,
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          3),
                                                              itemCount: history
                                                                  .historyLastWeekTimeList
                                                                  .length,
                                                              itemBuilder:
                                                                  (context,
                                                                      index) {
                                                                var data = history
                                                                        .historyLastWeekTimeList[
                                                                    index];
                                                                var timeAgo =
                                                                    getTimeAgo(data
                                                                        .createdAt);
                                                                return Padding(
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          5),
                                                                  child:
                                                                      CustomTile(
                                                                    isHistory:
                                                                        true,
                                                                    time:
                                                                        timeAgo,
                                                                    title: data
                                                                            .profile
                                                                            ?.name ??
                                                                        "",
                                                                    leadingIcon: data.profile?.profilePhoto !=
                                                                            null
                                                                        ? (ApiConstants.profileBaseUrl +
                                                                            data.profile!.profilePhoto!)
                                                                        : '',
                                                                    subtitle: data
                                                                            .profile
                                                                            ?.designation ??
                                                                        "",
                                                                    onTap: () {
                                                                      toNamed(
                                                                        context,
                                                                        Routes
                                                                            .otherUserProfile,
                                                                        args: data
                                                                            .profile!
                                                                            .id
                                                                            .toString(),
                                                                      );
                                                                    },
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          )
                                                        : const SizedBox(
                                                            height: 100,
                                                            child: Center(
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

                                      history.historyLastMonthTimeList
                                              .isNotEmpty
                                          ? Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8),
                                              decoration: BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: AppColor.grey999
                                                          .withOpacity(.5),
                                                      spreadRadius: 0,
                                                      blurRadius: 2,
                                                      offset:
                                                          const Offset(0, 1),
                                                    ),
                                                  ],
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  color: AppColor.primary),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 15,
                                                        vertical: 11),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 5),
                                                      child: AppText(
                                                        text:
                                                            AppString.lastMonth,
                                                        fontSize: 18.sp,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    history.historyLastMonthTimeList
                                                            .isNotEmpty
                                                        ? SizedBox(
                                                            child: ListView
                                                                .builder(
                                                              physics:
                                                                  const NeverScrollableScrollPhysics(),
                                                              shrinkWrap: true,
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          3),
                                                              itemCount: history
                                                                  .historyLastMonthTimeList
                                                                  .length,
                                                              itemBuilder:
                                                                  (context,
                                                                      index) {
                                                                var data = history
                                                                        .historyLastMonthTimeList[
                                                                    index];
                                                                var timeAgo =
                                                                    getTimeAgo(data
                                                                        .createdAt);
                                                                return Padding(
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          5),
                                                                  child:
                                                                      CustomTile(
                                                                    isHistory:
                                                                        true,
                                                                    time:
                                                                        timeAgo,
                                                                    title: data
                                                                            .profile
                                                                            ?.name ??
                                                                        "",
                                                                    leadingIcon:
                                                                        '',
                                                                    subtitle: data
                                                                            .profile
                                                                            ?.designation ??
                                                                        "",
                                                                    onTap: () {
                                                                      toNamed(
                                                                        context,
                                                                        Routes
                                                                            .otherUserProfile,
                                                                        args: data
                                                                            .profile!
                                                                            .id
                                                                            .toString(),
                                                                      );
                                                                    },
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          )
                                                        : const SizedBox(
                                                            height: 100,
                                                            child: Center(
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

// // Simulated Backend Data Fetching
// Future<List<TileModel>> fetchTilesFromBackend() async {
//   await Future.delayed(const Duration(seconds: 2));

//   return [
//     TileModel(
//       title: 'Ramesh',
//       subtitle: 'dehli',
//       time: '1h ago',
//       imageUrl: 'https://picsum.photos/250?image=9',
//       type: 'image',
//     ),
//     TileModel(
//       title: 'Watch',
//       subtitle: 'punjab',
//       time: '1h ago',
//       icon: 'search',
//       type: 'icon',
//     ),
//     TileModel(
//       title: 'amit',
//       subtitle: 'Manager',
//       time: '2h ago',
//       icon: 'location',
//       type: 'icon',
//     ),
//   ];
// }
