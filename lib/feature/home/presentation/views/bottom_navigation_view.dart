import 'package:NearMii/core/utils/routing/routes.dart';
import 'package:NearMii/feature/common_widgets/custom_profile_widget.dart';
import 'package:NearMii/feature/home/presentation/history/presentation/history_view.dart';
import 'package:NearMii/feature/home/presentation/provider/bottom_nav_provider.dart';
import 'package:NearMii/feature/home/presentation/views/home_page_view.dart';
import 'package:NearMii/feature/notification/presentation/notification_view.dart';
import 'package:NearMii/feature/setting/presentation/setting_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../config/assets.dart';
import '../../../../../config/helper.dart';

class BottomNavigationView extends ConsumerWidget {
  BottomNavigationView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 18),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              clipBehavior: Clip.antiAlias,
              child: Container(
                padding: const EdgeInsets.only(top: 20),
                // margin: const EdgeInsets.only(left: 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: AppColor.primary,
                ),
                width: context.width,
                height: context.height * .09,
                child: Consumer(
                  builder: (context, ref, child) {
                    return const Padding(
                      padding: EdgeInsets.only(
                          // bottom: context.height * .03,
                          // left: context.width * .02,
                          // right: context.width * .02
                          ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [],
                      ),
                    );
                  },
                ),
              ),
            ),
            Container(
              // padding: const EdgeInsets.only(top: 10),
              // margin: const EdgeInsets.only(left: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                // color: AppColor.whiteFFFFFF.withOpacity(0.1),
              ),
              width: context.width,
              height: context.height * .09,
              child: Consumer(
                builder: (context, ref, child) {
                  var indexSelected = ref.watch(selectedIndex);
                  return Padding(
                    padding: const EdgeInsets.only(
                        // bottom: context.height * .03,
                        // left: context.width * .02,
                        // right: context.width * .02
                        ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // HOME
                        navItems(
                          onTap: () {
                            ref.read(selectedIndex.notifier).state = 0;
                          },
                          ref: ref,
                          isSelected: indexSelected == 0,
                          context: context,
                          index: 0,
                          icon: indexSelected == 0
                              ? Assets.icSelectedHome
                              : Assets.icUnselectedHome,
                        ),
                        // HISTORY
                        navItems(
                          onTap: () {
                            ref.read(selectedIndex.notifier).state = 1;
                          },
                          ref: ref,
                          isSelected: indexSelected == 1,
                          context: context,
                          index: 1,
                          icon: indexSelected == 1
                              ? Assets.icSelectedClock
                              : Assets.icUnselectedClock,
                        ),

//PROFILE
                        GestureDetector(
                            onTap: () {
                              toNamed(context, Routes.profile);

                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) =>
                              //           const NewProfileScreen(),
                              //     ));
                            },
                            child: const CustomProfileWidget()),
                        // NOTIFICATION

                        navItems(
                          onTap: () {
                            ref.read(selectedIndex.notifier).state = 2;
                          },
                          ref: ref,
                          isSelected: indexSelected == 2,
                          context: context,
                          index: 2,
                          icon: indexSelected == 2
                              ? Assets.icSelectedNotification
                              : Assets.icUnselectedNotification,
                        ),
                        // SETTINGS
                        navItems(
                          onTap: () {
                            ref.read(selectedIndex.notifier).state = 3;
                          },
                          ref: ref,
                          isSelected: indexSelected == 3,
                          context: context,
                          index: 3,
                          icon: indexSelected == 3
                              ? Assets.icSelectedSetting
                              : Assets.icUnselectedSetting,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          return _pageController[ref.watch(selectedIndex)];
        },
      ),
    );
  }

  final _pageController = [
    const HomePageView(),
    const HistoryView(),
    const NotificationView(),
    const SettingView()
  ];

  Widget navItems(
      {required int index,
      required bool isSelected,
      required WidgetRef ref,
      required String icon,
      required VoidCallback onTap,
      required BuildContext context}) {
    return GestureDetector(
      onTap: onTap,
      child: SvgPicture.asset(
        icon,
        height: 26,
      ),
    );
  }
}
