import 'package:NearMii/config/app_utils.dart';
import 'package:NearMii/feature/common_widgets/custom_toast.dart';
import 'package:NearMii/feature/notification/presentation/provider/notification_provider.dart';
import 'package:NearMii/feature/notification/presentation/provider/state/notification_state.dart';
import 'package:flutter/material.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/feature/common_widgets/app_text.dart';
import 'package:NearMii/feature/common_widgets/custom_appbar_widget.dart';
import 'package:NearMii/feature/common_widgets/custom_history_tile.dart';
import 'package:NearMii/feature/common_widgets/custom_search_bar_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationView extends ConsumerStatefulWidget {
  const NotificationView({super.key});

  @override
  ConsumerState<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends ConsumerState<NotificationView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        final notifier = ref.read(notificationProvider.notifier);
        notifier.notificationApi();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      notificationProvider,
      (previous, next) async {
        if (next is NotificationApiLoading) {
          Utils.showLoader();
        } else if (next is NotificationApiSuccess) {
          Utils.hideLoader();
        } else if (next is NotificationApiFailed) {
          Utils.hideLoader();

          toast(msg: next.error);
        }
      },
    );
    return Scaffold(
        backgroundColor: AppColor.greyf9f9f9,
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              const CustomAppbarWidget(
                title: AppString.notification,
              ),
              SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(
                        width: context.width * .9,
                        child: CustomSearchBarWidget(
                          controller: TextEditingController(),
                          onChanged: (value) {},
                        )),
                    SizedBox(
                      height: context.height * .81,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color:
                                              AppColor.grey999.withOpacity(.5),
                                          spreadRadius: 0,
                                          blurRadius: 2,
                                          offset: const Offset(0, 1),
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(15),
                                      color: AppColor.primary),
                                  // height: context.height * .45,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 11),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          child: AppText(
                                            text: AppString.recent,
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        ListView.builder(
                                          shrinkWrap: true,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 1),
                                          itemCount: 2,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            return Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 1),
                                                child: Column(
                                                  children: [
                                                    CustomTile(
                                                      isHistory: false,
                                                      type: "search",
                                                      onTap: () {},
                                                      time: "1h ago",
                                                      title:
                                                          "20 People near you",
                                                      leadingIcon: "",
                                                      subtitle:
                                                          'Check out their profile.',
                                                    ),
                                                    CustomTile(
                                                      isHistory: false,
                                                      type: "",
                                                      onTap: () {},
                                                      time: "1h ago",
                                                      title:
                                                          "Someone viewed your profile",
                                                      leadingIcon: "",
                                                      subtitle:
                                                          'Check out their profile.',
                                                    ),
                                                  ],
                                                ));
                                          },
                                        ),
                                      ],
                                    ),
                                  )),
                              Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 18),
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color:
                                              AppColor.grey999.withOpacity(.5),
                                          spreadRadius: 0,
                                          blurRadius: 2,
                                          offset: const Offset(0, 1),
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(15),
                                      color: AppColor.primary),
                                  // height: context.height * .45,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 11),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          child: AppText(
                                            text: AppString.lastWeek,
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        ListView.builder(
                                          shrinkWrap: true,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 1),
                                          itemCount: 2,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            return Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 1),
                                                child: Column(
                                                  children: [
                                                    CustomTile(
                                                      isHistory: false,
                                                      type: "search",
                                                      onTap: () {},
                                                      time: "1h ago",
                                                      title:
                                                          "20 People near you",
                                                      leadingIcon: "",
                                                      subtitle:
                                                          'Check out their profile.',
                                                    ),
                                                    CustomTile(
                                                      isHistory: false,
                                                      type: "",
                                                      onTap: () {},
                                                      time: "1h ago",
                                                      title:
                                                          "Someone viewed your profile",
                                                      leadingIcon: "",
                                                      subtitle:
                                                          'Check out their profile.',
                                                    ),
                                                  ],
                                                ));
                                          },
                                        ),
                                      ],
                                    ),
                                  )),
                              Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color:
                                              AppColor.grey999.withOpacity(.5),
                                          spreadRadius: 0,
                                          blurRadius: 2,
                                          offset: const Offset(0, 1),
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(15),
                                      color: AppColor.primary),
                                  // height: context.height * .45,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 11),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          child: AppText(
                                            text: AppString.lastMonth,
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        ListView.builder(
                                          shrinkWrap: true,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 1),
                                          itemCount: 2,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            return Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 1),
                                                child: Column(
                                                  children: [
                                                    CustomTile(
                                                      isHistory: false,
                                                      type: "search",
                                                      onTap: () {},
                                                      time: "1h ago",
                                                      title:
                                                          "20 People near you",
                                                      leadingIcon: "",
                                                      subtitle:
                                                          'Check out their profile.',
                                                    ),
                                                    CustomTile(
                                                      isHistory: false,
                                                      type: "",
                                                      onTap: () {},
                                                      time: "1h ago",
                                                      title:
                                                          "Someone viewed your profile",
                                                      leadingIcon: "",
                                                      subtitle:
                                                          'Check out their profile.',
                                                    ),
                                                  ],
                                                ));
                                          },
                                        ),
                                      ],
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
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


