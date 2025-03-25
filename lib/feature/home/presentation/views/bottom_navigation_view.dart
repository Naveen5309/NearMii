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
  const BottomNavigationView({super.key, required this.isFromAuth});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var indexSelected = ref.watch(selectedIndex);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (!didPop) {
          bool shouldExit = await showExitConfirmationDialog(context);
          if (shouldExit && context.mounted) {
            back(context);
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
                  color: AppColor.black000000.withOpacity(.06),
                  blurRadius: 5,
                  spreadRadius: 3,
                  offset: const Offset(0, 5),
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
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  width: context.width,
                  height: context.height * .09,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      navItems(
                        onTap: () => ref.read(selectedIndex.notifier).state = 0,
                        isSelected: indexSelected == 0,
                        context: context,
                        icon: indexSelected == 0
                            ? Assets.icSelectedHome
                            : Assets.icUnselectedHome,
                      ),
                      navItems(
                        onTap: () => ref.read(selectedIndex.notifier).state = 1,
                        isSelected: indexSelected == 1,
                        context: context,
                        icon: indexSelected == 1
                            ? Assets.icSelectedClock
                            : Assets.icUnselectedClock,
                      ),
                      InkWell(
                        onTap: () => toNamed(context, Routes.profile),
                        child: const CustomProfileWidget(),
                      ),
                      navItems(
                        onTap: () => ref.read(selectedIndex.notifier).state = 2,
                        isSelected: indexSelected == 2,
                        context: context,
                        icon: indexSelected == 2
                            ? Assets.icSelectedNotification
                            : Assets.icUnselectedNotification,
                      ),
                      navItems(
                        onTap: () => ref.read(selectedIndex.notifier).state = 3,
                        isSelected: indexSelected == 3,
                        context: context,
                        icon: indexSelected == 3
                            ? Assets.icSelectedSetting
                            : Assets.icUnselectedSetting,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Stack(
          children: [
            const HomePageView(
                isFromAuth: true), // Keep HomePageView always alive
            if (indexSelected == 1) const HistoryView(),
            if (indexSelected == 2) const NotificationView(),
            if (indexSelected == 3) const SettingView(),
          ],
        ),
      ),
    );
  }

  Widget navItems({
    required bool isSelected,
    required String icon,
    required VoidCallback onTap,
    required BuildContext context,
  }) {
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
