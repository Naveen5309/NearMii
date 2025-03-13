import 'package:NearMii/core/utils/routing/routes.dart';
import 'package:NearMii/feature/common_widgets/custom_profile_widget.dart';
import 'package:NearMii/feature/common_widgets/exit_app_confirmation.dart';
import 'package:NearMii/feature/history/presentation/view/history_view.dart';
import 'package:NearMii/feature/home/presentation/provider/bottom_nav_provider.dart';
import 'package:NearMii/feature/home/presentation/views/home_page_view.dart';
import 'package:NearMii/feature/notification/presentation/view/notification_view.dart';
import 'package:NearMii/feature/setting/presentation/view/setting_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../config/assets.dart';
import '../../../../../config/helper.dart';

class BottomNavigationView extends ConsumerWidget {
  final bool isFromAuth;
  BottomNavigationView({super.key, required this.isFromAuth});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (!didPop) {
          bool shouldExit = await showExitConfirmationDialog(context);
          if (shouldExit) {
            if (context.mounted) {
              back(context); // Exit if user confirms
            }
          }
        }
      },
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: EdgeInsets.symmetric(
              vertical: context.height * .015, horizontal: 18),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                BoxShadow(
                  color: AppColor.black000000
                      .withOpacity(.06), // Adjust opacity as needed
                  blurRadius: 5,
                  spreadRadius: 3, // No spreading to the sides
                  offset: const Offset(0, 5), // Move shadow downwards
                ),
              ],
            ),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  clipBehavior: Clip.antiAlias,
                  child: Container(
                    padding: const EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: AppColor.primary,
                    ),
                    width: context.width,
                    height: context.height * .09,
                    child: Consumer(
                      builder: (context, ref, child) {
                        return const Padding(
                          padding: EdgeInsets.only(),
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
                        padding: const EdgeInsets.only(),
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
                            InkWell(
                                onTap: () {
                                  toNamed(context, Routes.profile);
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
        ),
        body: Consumer(
          builder: (context, ref, child) {
            return _pageController[ref.watch(selectedIndex)];
          },
        ),
      ),
    );
  }

  final _pageController = [
    const HomePageView(
      isFromAuth: true,
    ),
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
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        splashColor: AppColor.green00C56524.withOpacity(.5),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset(
            icon,
            height: 26,
          ),
        ),
      ),
    );
  }
}
