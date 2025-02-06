import 'package:NearMii/config/assets.dart';
import 'package:NearMii/config/constants.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/feature/common_widgets/app_text.dart';
import 'package:NearMii/feature/common_widgets/common_button.dart';
import 'package:NearMii/feature/common_widgets/custom_cache_network.dart';
import 'package:NearMii/feature/common_widgets/custom_dotted_box.dart';
import 'package:NearMii/feature/common_widgets/custombtn.dart';
import 'package:NearMii/feature/common_widgets/setting_custom_tile.dart';
import 'package:NearMii/feature/home/data/models/subscription_model.dart';
import 'package:NearMii/feature/home/presentation/history/presentation/change_password_view.dart';
import 'package:NearMii/feature/home/presentation/history/presentation/complete_edit_profile.dart';
import 'package:NearMii/feature/home/presentation/history/presentation/contact_us_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SettingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff00C565),
        // title: AppText(text: AppString.settings),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
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
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  AppText(
                    fontFamily: Constants.fontFamily,
                    text: AppString.settings,
                    color: AppColor.black000000,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
              8.verticalSpace,
              CustomTile(
                leadingIcon: Assets.iconPerson,
                title: 'Edit Profile Details',
                subtitle: 'Update your profile info',
                trailingIcon: Assets.iconArrowRight,
                onTap: () => pushTo(context, const CompleteEditProfile()),
              ),
              10.verticalSpace,
              const CustomTile(
                leadingIcon: Assets.iconChangePassword,
                title: 'Invite Friends',
                subtitle: 'Get 15 Points',
                trailingIcon: Assets.iconArrowRight,
              ),
              10.verticalSpace,
              const CustomTile(
                leadingIcon: Assets.iconDelete,
                title: 'Set Radius',
                subtitle: '50 M',
                trailingIcon: Assets.iconArrowRight,
              ),
              10.verticalSpace,
              const CustomTile(
                leadingIcon: Assets.iconCheckBox,
                title: 'Terms & Conditions',
                subtitle: 'View our Policies  ',
                trailingIcon: Assets.iconArrowRight,
              ),
              10.verticalSpace,
              CustomTile(
                leadingIcon: Assets.iconChangePassword,
                title: 'Change Password',
                subtitle: 'Reset your password',
                trailingIcon: Assets.iconArrowRight,
                onTap: () => pushTo(context, const ChangePasswordView()),
              ),
              10.verticalSpace,
              CustomTile(
                leadingIcon: Assets.iconContactUs,
                title: 'Contact Us',
                subtitle: 'Reach out to our support team',
                trailingIcon: Assets.iconArrowRight,
                onTap: () => pushTo(context, const ContactUsView()),
              ),
              10.verticalSpace,
              const CustomTile(
                leadingIcon: Assets.iconHowItWorks,
                title: 'How it works',
                subtitle: 'Check how our organization works',
                trailingIcon: Assets.iconArrowRight,
              ),
              10.verticalSpace,
              const CustomTile(
                leadingIcon: Assets.iconDelete,
                title: 'Delete Account',
                subtitle: 'Delete your account',
                trailingIcon: Assets.iconArrowRight,
              ),
              15.verticalSpace,
              const CommonAppBtn(
                title: AppString.logOut,
                textColor: AppColor.redE40505,
                height: 60,
                borderColor: AppColor.redE40505,
                borderWidth: 1,
                backGroundColor: AppColor.redF8E2E2,
              ),
              55.verticalSpace
            ],
          ),
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
          color: const Color(0xff01C27D).withValues(alpha: 0.1),
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
      height: 80.h,
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
                color: AppColor.grey21203F.withValues(alpha: .5),
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
