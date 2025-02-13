import 'package:NearMii/config/assets.dart';
import 'package:NearMii/config/constants.dart';
import 'package:NearMii/config/enums.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/core/helpers/all_getter.dart';
import 'package:NearMii/core/utils/routing/routes.dart';
import 'package:NearMii/feature/auth/presentation/provider/login_provider.dart';
import 'package:NearMii/feature/auth/presentation/provider/states/auth_states.dart';
import 'package:NearMii/feature/common_widgets/app_text.dart';
import 'package:NearMii/feature/common_widgets/common_button.dart';
import 'package:NearMii/feature/common_widgets/custom_appbar_widget.dart';
import 'package:NearMii/feature/common_widgets/custom_bottom_sheet.dart';
import 'package:NearMii/feature/common_widgets/custom_cache_network.dart';
import 'package:NearMii/feature/common_widgets/custom_dotted_box.dart';
import 'package:NearMii/feature/common_widgets/custom_toast.dart';
import 'package:NearMii/feature/common_widgets/setting_custom_tile.dart';
import 'package:NearMii/feature/home/data/models/subscription_model.dart';
import 'package:NearMii/feature/home/presentation/history/presentation/invite_friend.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SettingView extends ConsumerWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginNotifier = ref.watch(loginProvider.notifier);

    ref.watch(loginProvider);
    // final loginNotifier = ref.watch(loginProvider.notifier);

    ref.listen(
      loginProvider,
      (previous, next) async {
        if (next is AuthApiLoading && next.authType == AuthType.logOut) {
          showDialog(
            context: context,
            builder: (context) {
              return Center(
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.0),
                      color: AppColor.primary,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(28.0),
                      child: CircularProgressIndicator.adaptive(),
                    )),
              );
            },
          );
        } else if (next is AuthApiSuccess && next.authType == AuthType.logOut) {
          toast(msg: AppString.logoutSuccess, isError: false);

          await Getters.getLocalStorage.saveIsLogin(false);

          // back(context);
          offAllNamed(context, Routes.login);
        } else if (next is AuthApiFailed && next.authType == AuthType.logOut) {
          back(context);
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
              title: AppString.settings,
            ),
            SizedBox(
              height: context.height * .85,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 18, horizontal: 11),
                  child: Column(
                    children: [
                      ProfileWidget(
                        imageUrl: '',
                        name: "Cameron Williamson",
                        points: 124,
                        isVip: true,
                        model: SubscriptionModel(Points: 221, daysLeft: 11),
                      ),
                      28.verticalSpace,
                      dottedContainer(
                          context, SubscriptionModel(Points: 0, daysLeft: 27)),
                      35.verticalSpace,

                      //SETTING TEXT
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 11.w),
                          child: AppText(
                            fontFamily: Constants.fontFamily,
                            text: AppString.settings,
                            color: AppColor.black000000,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      8.verticalSpace,
                      CustomTile(
                        leadingIcon: Assets.iconPerson,
                        title: AppString.editProfile,
                        subtitle: AppString.updateProfile,
                        trailingIcon: Assets.iconArrowRight,
                        onTap: () => toNamed(context, Routes.editProfile),
                      ),
                      10.verticalSpace,
                      CustomTile(
                        leadingIcon: Assets.add,
                        title: AppString.inviteFriends,
                        subtitle: AppString.get15points,
                        trailingIcon: Assets.iconArrowRight,
                        onTap: () => showCustomBottomSheet(
                            context: context,
                            content: const InviteFriendBottomSheet(
                              title: AppString.inviteFriend,
                              subtitle:
                                  "Lorem ipsum dolor sit amet consectetur. Dui etiam tempus scelerisque donec nisl vitae. Amet nulla etiam.",
                            )),
                        // showModalBottomSheet(
                        //   context: context,
                        //   shape: const RoundedRectangleBorder(
                        //     borderRadius:
                        //         BorderRadius.vertical(top: Radius.circular(20)),
                        //   ),
                        //   builder: (context) {
                        //     return

                        //      InviteFriendBottomSheet(
                        //       title: AppString.inviteFriend,
                        //       subtitle:
                        //           "Lorem ipsum dolor sit amet consectetur. Dui etiam tempus scelerisque donec nisl vitae. Amet nulla etiam.",
                        //     );
                        //   },
                        // ),
                      ),
                      10.verticalSpace,
                      CustomTile(
                        leadingIcon: Assets.iconSetRadius,
                        title: AppString.setRadius,
                        subtitle: AppString.meter,
                        trailingIcon: Assets.iconArrowRight,
                        onTap: () => toNamed(context, Routes.setRadius),
                      ),
                      10.verticalSpace,
                      CustomTile(
                        leadingIcon: Assets.iconCheckBox,
                        title: AppString.termsAndConditions,
                        subtitle: AppString.viewOurPolicies,
                        trailingIcon: Assets.iconArrowRight,
                        onTap: () =>
                            toNamed(context, Routes.termsAndConditions),
                      ),
                      10.verticalSpace,
                      CustomTile(
                        leadingIcon: Assets.iconChangePassword,
                        title: AppString.changePassword,
                        subtitle: AppString.resetYourPswd,
                        trailingIcon: Assets.iconArrowRight,
                        onTap: () => toNamed(context, Routes.changePassword),
                      ),
                      10.verticalSpace,
                      CustomTile(
                        leadingIcon: Assets.iconContactUs,
                        title: AppString.contactUs,
                        subtitle: AppString.reachOutToSupport,
                        trailingIcon: Assets.iconArrowRight,
                        onTap: () => toNamed(context, Routes.contactUs),
                      ),
                      10.verticalSpace,

                      //HOW IT WORKS
                      CustomTile(
                        leadingIcon: Assets.iconHowItWorks,
                        title: AppString.howItWorks,
                        subtitle: AppString.checkHowOur,
                        trailingIcon: Assets.iconArrowRight,
                        onTap: () {
                          toNamed(context, Routes.onboard, args: true);
                        },
                      ),
                      10.verticalSpace,
                      CustomTile(
                        leadingIcon: Assets.iconDelete,
                        title: AppString.deleteAccount,
                        subtitle: AppString.deleteYourAccount,
                        trailingIcon: Assets.iconArrowRight,
                        onTap: () => toNamed(context, Routes.deleteAccount),
                      ),
                      15.verticalSpace,

                      //LOGOUT BUTTON
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 11.w, vertical: 8.h),
                        child: CommonAppBtn(
                          title: AppString.logOut,
                          textColor: AppColor.redE40505,
                          height: 60,
                          borderColor: AppColor.redE40505,
                          borderWidth: 1,
                          backGroundColor: AppColor.redF8E2E2,
                          onTap: () {
                            // final notifier = ref.read(loginProvider.notifier);
                            // notifier.getSocialPlatform();
                            offAllNamed(context, Routes.login);
                          },
                        ),
                      ),
                      90.verticalSpace
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

  Widget ProfileWidget({
    required String imageUrl,
    required String name,
    required int points,
    required bool isVip,
    required SubscriptionModel model,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            CustomCacheNetworkImage(
              img: imageUrl, imageRadius: 70, height: 70, width: 70,
              // CircleAvatar(
              //   radius: 30.r,
              //   backgroundImage: NetworkImage(imageUrl),
              // ),
            ),
            if (isVip)
              Positioned(
                right: 0,
                bottom: -1,
                child: SvgPicture.asset(
                  Assets.imgVip,
                ),
              ),
          ],
        ),
        SizedBox(height: 10.h),
        AppText(
          text: name,
          fontFamily: Constants.fontFamily,
          fontSize: 24.sp,
          color: AppColor.black000000,
          fontWeight: FontWeight.w700,
        ),
        SizedBox(height: 10.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: const Color(0xff01C27D).withOpacity(0.1),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: AppText(
            text: "${model.Points} Points",
            color: const Color(0xff01C27D),
            fontFamily: Constants.fontFamily,
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget dottedContainer(BuildContext context, SubscriptionModel model) {
    return CommonDottedBorder(
      borderRadius: 20,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColor.primary,
        ),
        padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 8.h),
        width: context.width * 0.9,
        height: 70.h,
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(Assets.iconVip),
            SizedBox(width: 10.w),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  fontFamily: Constants.fontFamily,
                  text: AppString.subscription,
                  color: AppColor.black000000,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
                2.verticalSpace,
                AppText(
                  fontFamily: Constants.fontFamily,
                  text: AppString.pricePerMonth,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColor.grey21203F.withOpacity(.5),
                ),
              ],
            ),
            const Spacer(),
            AppText(
              fontFamily: Constants.fontFamily,
              text: "${model.daysLeft} days left",
              color: const Color(0xff00C565),
              fontSize: 12.sp,
            ),
          ],
        ),
      ),
    );
  }
}
