import 'package:NearMii/config/helper.dart';
import 'package:NearMii/feature/common_widgets/app_text.dart';
import 'package:NearMii/feature/common_widgets/custom_appbar_widget.dart';
import 'package:NearMii/feature/common_widgets/custom_history_tile.dart';
import 'package:NearMii/feature/common_widgets/custom_search_bar_widget.dart';
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
      backgroundColor: AppColor.primary,
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            const CustomAppbarWidget(
              title: AppString.history,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.width * .07),
              child: Column(
                children: [
                  const CustomSearchBarWidget(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        text: AppString.recent,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(
                        height: context.height * .7,
                        child: ListView.builder(
                          shrinkWrap: true,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          itemCount: 15,
                          itemBuilder: (context, index) {
                            return const Padding(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              child: CustomTile(
                                isHistory: true,
                                time: "1h ago",
                                title: "NAME",
                                leadingIcon: '',
                                subtitle: 'Designation',
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
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


