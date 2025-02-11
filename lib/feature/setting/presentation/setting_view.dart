import 'package:NearMii/config/assets.dart';
import 'package:NearMii/config/constants.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/core/utils/routing/routes.dart';
import 'package:NearMii/feature/common_widgets/app_text.dart';
import 'package:NearMii/feature/common_widgets/common_button.dart';
import 'package:NearMii/feature/common_widgets/custom_appbar_widget.dart';
import 'package:NearMii/feature/common_widgets/custom_cache_network.dart';
import 'package:NearMii/feature/common_widgets/custom_dotted_box.dart';
import 'package:NearMii/feature/common_widgets/setting_custom_tile.dart';
import 'package:NearMii/feature/home/data/models/subscription_model.dart';
import 'package:NearMii/feature/home/presentation/history/presentation/share_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomAppbarWidget(
              title: AppString.settings,
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 11),
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
                    onTap: () => showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20)),
                      ),
                      builder: (context) {
                        return const InviteFriendBottomSheet(
                          title: AppString.inviteFriend,
                          subtitle:
                              "Lorem ipsum dolor sit amet consectetur. Dui etiam tempus scelerisque donec nisl vitae. Amet nulla etiam.",
                        );
                      },
                    ),
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
                    onTap: () => toNamed(context, Routes.termsAndConditions),
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
                    padding:
                        EdgeInsets.symmetric(horizontal: 11.w, vertical: 8.h),
                    child: CommonAppBtn(
                      title: AppString.logOut,
                      textColor: AppColor.redE40505,
                      height: 60,
                      borderColor: AppColor.redE40505,
                      borderWidth: 1,
                      backGroundColor: AppColor.redF8E2E2,
                      onTap: () {
                        offAllNamed(context, Routes.login);
                      },
                    ),
                  ),
                  90.verticalSpace
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
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
