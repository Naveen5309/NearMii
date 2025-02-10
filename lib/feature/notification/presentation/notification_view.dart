import 'package:flutter/material.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/feature/common_widgets/app_text.dart';
import 'package:NearMii/feature/common_widgets/custom_appbar_widget.dart';
import 'package:NearMii/feature/common_widgets/custom_history_tile.dart';
import 'package:NearMii/feature/common_widgets/custom_search_bar_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationView extends ConsumerWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColor.primary,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomAppbarWidget(
              title: AppString.notification,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.width * .05),
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
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: Column(
                                  children: [
                                    CustomTile(
                                      isHistory: false,
                                      type: "search",
                                      onTap: () {},
                                      time: "1h ago",
                                      title: "20 People near you",
                                      leadingIcon: "",
                                      subtitle: 'Check out their profile.',
                                    ),
                                    CustomTile(
                                      isHistory: false,
                                      type: "",
                                      onTap: () {},
                                      time: "1h ago",
                                      title: "Someone viewed your profile",
                                      leadingIcon: "",
                                      subtitle: 'Check out their profile.',
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
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



// class HistoryView extends StatefulWidget {
//   const HistoryView({super.key});

//   @override
//   State<HistoryView> createState() => _HistoryViewState();
// }

// class _HistoryViewState extends State<HistoryView> {
//   // late Future<List<TileModel>> tiles;

//   @override
//   void initState() {
//     super.initState();
//     // tiles = fetchTilesFromBackend();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColor.primary,
//       body: SingleChildScrollView(
//         physics: const NeverScrollableScrollPhysics(),
//         child: Column(
//           children: [
//             const CustomAppbarWidget(),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: context.width * .07),
//               child: Column(
//                 children: [
//                   const CustomSearchBarWidget(),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       AppText(
//                         text: AppString.recent,
//                         fontSize: 18.sp,
//                         fontWeight: FontWeight.w500,
//                       ),
//                       SizedBox(
//                         height: context.height * .7,
//                         child: ListView.builder(
//                           shrinkWrap: true,
//                           padding: const EdgeInsets.symmetric(vertical: 10),
//                           itemCount: 15,
//                           itemBuilder: (context, index) {
//                             return const Padding(
//                               padding: EdgeInsets.symmetric(vertical: 5),
//                               child: CustomTile(
//                                 time: "1h ago",
//                                 title: "NAME",
//                                 leadingIcon: '',
//                                 subtitle: 'Designation',
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }




// }


