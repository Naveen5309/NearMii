import 'package:NearMii/config/helper.dart';
import 'package:NearMii/core/utils/routing/routes.dart';
import 'package:NearMii/feature/common_widgets/app_text.dart';
import 'package:NearMii/feature/common_widgets/custom_appbar_widget.dart';
import 'package:NearMii/feature/common_widgets/custom_history_tile.dart';
import 'package:NearMii/feature/common_widgets/custom_search_bar_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  // late Future<List<TileModel>> tiles;

  @override
  void initState() {
    super.initState();
    // tiles = fetchTilesFromBackend();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.greyf9f9f9,
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            const CustomAppbarWidget(
              title: AppString.history,
            ),
            SizedBox(
              height: context.height * .9,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: context.width * .05),
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      const CustomSearchBarWidget(),
                      SizedBox(
                        height: context.height * .81,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColor.grey999.withOpacity(.5),
                                        spreadRadius: 0,
                                        blurRadius: 2,
                                        offset: const Offset(0, 1),
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(15),
                                    color: AppColor.primary),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 11),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: AppText(
                                          text: AppString.recent,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(
                                        child: ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 3),
                                          itemCount: 4,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5),
                                              child: CustomTile(
                                                isHistory: true,
                                                time: "1h ago",
                                                title: "Robert Fox",
                                                leadingIcon: '',
                                                subtitle: 'Designation',
                                                onTap: () {
                                                  toNamed(context,
                                                      Routes.otherUserProfile,
                                                      args: "52");
                                                },
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 15),
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColor.grey999.withOpacity(.5),
                                        spreadRadius: 0,
                                        blurRadius: 2,
                                        offset: const Offset(0, 1),
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(15),
                                    color: AppColor.primary),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 11),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: AppText(
                                          text: AppString.lastWeek,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(
                                        child: ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 3),
                                          itemCount: 4,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5),
                                              child: CustomTile(
                                                isHistory: true,
                                                time: "1h ago",
                                                title: "Courtney Henry",
                                                leadingIcon: '',
                                                subtitle: 'Designation',
                                                onTap: () {
                                                  toNamed(context,
                                                      Routes.otherUserProfile);
                                                },
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColor.grey999.withOpacity(.5),
                                        spreadRadius: 0,
                                        blurRadius: 2,
                                        offset: const Offset(0, 1),
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(15),
                                    color: AppColor.primary),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 11),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: AppText(
                                          text: AppString.lastMonth,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(
                                        child: ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 3),
                                          itemCount: 4,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5),
                                              child: CustomTile(
                                                isHistory: true,
                                                time: "1h ago",
                                                title: "Wade Warren",
                                                leadingIcon: '',
                                                subtitle: 'Designation',
                                                onTap: () {
                                                  toNamed(context,
                                                      Routes.otherUserProfile);
                                                },
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
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
