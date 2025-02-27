import 'dart:developer';

import 'package:NearMii/config/app_utils.dart';
import 'package:NearMii/config/assets.dart';
import 'package:NearMii/config/enums.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/core/utils/routing/routes.dart';
import 'package:NearMii/feature/auth/presentation/provider/login_provider.dart';
import 'package:NearMii/feature/auth/presentation/provider/signup_provider.dart';
import 'package:NearMii/feature/auth/presentation/provider/state_notifiers/signup_notifiers.dart';
import 'package:NearMii/feature/auth/presentation/provider/states/auth_states.dart';
import 'package:NearMii/feature/common_widgets/app_text.dart';
import 'package:NearMii/feature/common_widgets/custom_cache_network.dart';
import 'package:NearMii/feature/common_widgets/custom_search_bar_widget.dart';
import 'package:NearMii/feature/common_widgets/custom_switch_btn.dart';
import 'package:NearMii/feature/common_widgets/profile_grid_view.dart';
import 'package:NearMii/feature/home/data/models/subscription_model.dart';
import 'package:NearMii/feature/home/domain/profile_model.dart';
import 'package:NearMii/feature/self_user_profile/presentation/provider/get_self_platform_provider.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sliver_snap/widgets/sliver_snap.dart';

class MyProfileView extends ConsumerStatefulWidget {
  const MyProfileView({super.key});

  @override
  ConsumerState<MyProfileView> createState() => _MyProfileViewState();
}

class _MyProfileViewState extends ConsumerState<MyProfileView> {
  ProfileModel? profile;

  @override
  void initState() {
    super.initState();
    // fetchProfileData();
    Future.microtask(() {
      final notifier = ref.read(signupProvider.notifier);
      notifier.getSocialPlatform();
      final selfNotifier = ref.read(getSelfPlatformProvider.notifier);
      selfNotifier.getSelfPlatformApi(name: '');
    });
  }

  // void fetchProfileData() {
  //   // Simulating data fetch from an API or database
  //   setState(() {
  //     profile = ProfileModel(
  //       name: 'Brooklyn Simmons',
  //       designation: 'Designation',
  //       imageUrl: 'https://picsum.photos/250?image=9',
  //       description:
  //           'Lorem ipsum dolor sit amet consectetur. Tempus cursus et tincidunt sollicitudin a eu feugiat sagittis.',
  //       social: '10',
  //       contact: '04',
  //       portfolio: '10',
  //       finance: '06',
  //       business: '06',
  //     );
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    ref.watch(signupProvider);
    final signUpNotifier = ref.watch(signupProvider.notifier);

    ref.listen(
      loginProvider,
      (previous, next) {
        if (next is AuthApiLoading && next.authType == AuthType.socialMedia) {
          Utils.showLoader();
        } else if (next is AuthApiSuccess &&
            next.authType == AuthType.socialMedia) {
          // toast(msg: AppString.loginSuccess, isError: false);
          Utils.hideLoader();

          // toNamed(context, Routes.bottomNavBar);
        } else if (next is AuthApiFailed &&
            next.authType == AuthType.socialMedia) {
          Utils.hideLoader();

          // toast(msg: next.error);
        }
      },
    );

    return Scaffold(
        backgroundColor: AppColor.primary,
        floatingActionButton: InkWell(
          onTap: () {
            toNamed(context, Routes.selectSocialMedia, args: true);
          },
          child: Container(
            decoration: BoxDecoration(
                // color: AppColor.primary,
                borderRadius: BorderRadius.circular(100),
                color: AppColor.green00C56524),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SvgPicture.asset(Assets.icAddBtn),
            ),
          ),
        ),
        body: SliverSnap(
            stretch: true,
            scrollBehavior: const CupertinoScrollBehavior(),
            pinned: true,
            animationCurve: Curves.easeInOutCubicEmphasized,
            // bottom: const PreferredSize(
            //   preferredSize: Size.fromHeight(100),
            //   child: Icon(
            //     Icons.directions_boat,
            //     color: Colors.blue,
            //     size: 45,
            //   ),
            // ),
            // collapsedBarHeight: 60,
            animationDuration: const Duration(milliseconds: 1),
            onCollapseStateChanged: (isCollapsed, scrollingOffset, maxExtent) {
              log("isCollapsed $isCollapsed");
              log("scrollingOffset $scrollingOffset");
              log("maxExtent $maxExtent");
            },
            collapsedBackgroundColor: AppColor.btnColor,
            expandedBackgroundColor: const Color.fromRGBO(0, 0, 0, 0),
            backdropWidget: Container(
              decoration: const BoxDecoration(
                color: AppColor.greyf9f9f9,
                // image: DecorationImage(
                //   image: AssetImage(Assets.background),
                //   fit: BoxFit.fill,
                // ),
              ),
            ),
            expandedContentHeight: context.height * .55,
            expandedContent:
                profileSection(context: context, profile: profile!),
            collapsedContent: appBarWidgetSection(context: context),
            body: bottomSection(
                signUpNotifier: signUpNotifier, context: context)));
  }
}

//APP BAR WIDGET SECTION

Widget appBarWidgetSection({required BuildContext context}) {
  return Row(
    children: [
      GestureDetector(
        onTap: () {
          back(context);
        },
        child: SvgPicture.asset(
          Assets.icBackBtn,
          colorFilter:
              const ColorFilter.mode(AppColor.primary, BlendMode.srcIn),
        ),
      ),
      15.horizontalSpace,
      Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xff69DDA5),
        ),
        padding: const EdgeInsets.all(3),
        child: CustomCacheNetworkImage(
          img: '',
          imageRadius: 150,
          height: 40.w,
          width: 40.w,
        ),
      ),
      5.horizontalSpace,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            text: "Brooklyn Simmons",
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
            color: AppColor.whiteFFFFFF,
          ),
          AppText(
            text: "Designation",
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: AppColor.whiteFFFFFF.withOpacity(.8),
          ),
        ],
      )
    ],
  );
}

//BOTTOM SECTION

Widget bottomSection(
    {required SignupNotifiers signUpNotifier, required BuildContext context}) {
  return Container(
    color: AppColor.greyf9f9f9,
    width: context.width,
    child: Padding(
      padding: EdgeInsets.symmetric(
          horizontal: context.width * .04, vertical: context.width * .01),
      child: Column(children: [
        CustomSearchBarWidget(
          controller: TextEditingController(),
          onChanged: (value) {},
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: hideAllSection(),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ProfileGridView(
            isMyProfile: true,
            title: AppString.socialMedia,
            socialMedia: signUpNotifier.socialMediaList,
          ),
        )
      ]),
    ),
  );
}

//PROFILE SECTION

Widget profileSection(
    {required BuildContext context, required ProfileModel profile}) {
  return Container(
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage(Assets.background),
        fit: BoxFit.fill,
      ),
    ),
    child: Column(
        mainAxisSize:
            MainAxisSize.min, // Ensures column takes only necessary space
        children: [
          SizedBox(height: context.height * .1),
          Align(
            alignment: Alignment.centerLeft,
            child: InkWell(
              onTap: () {
                back(context);
              },
              child: Padding(
                padding: EdgeInsets.only(left: context.width * .05),
                child: SvgPicture.asset(
                  Assets.icBackBtn,
                  colorFilter:
                      const ColorFilter.mode(AppColor.primary, BlendMode.srcIn),
                ),
              ),
            ),
          ),
          SizedBox(height: context.height * .02),
          Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xff69DDA5),
            ),
            padding: const EdgeInsets.all(6),
            child: CustomCacheNetworkImage(
              img: '',
              imageRadius: 150,
              height: 105.w,
              width: 105.w,
            ),
          ),
          10.verticalSpace,
          AppText(
            color: AppColor.whiteFFFFFF,
            text: profile.name,
            fontSize: 20.sp,
            fontWeight: FontWeight.w500,
          ),
          5.verticalSpace,
          AppText(
            text: profile.designation,
            fontWeight: FontWeight.w500,
            fontSize: 16.sp,
            color: AppColor.whiteFFFFFF.withOpacity(.8),
          ),
          25.verticalSpace,
          AppText(
            text: profile.description,
            textAlign: TextAlign.center,
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: AppColor.whiteFFFFFF.withOpacity(.8),
          ),
          20.verticalSpace,
          Wrap(
            alignment: WrapAlignment.center,
            runSpacing: 8,
            spacing: 6,
            children: [
              InfoChip(label: 'Social', value: profile.social),
              InfoChip(label: 'Contact', value: profile.contact),
              InfoChip(label: 'Portfolio', value: profile.portfolio),
              InfoChip(label: 'Finance', value: profile.finance),
              InfoChip(label: 'Business', value: profile.business),
            ],
          )
        ]),
  );
  // background: Container(
  //   width: MediaQuery.of(context).size.width,
  //   padding: EdgeInsets.only(
  //     left: 12.w,
  //     right: 12.w,
  //     top: context.height * .1,
  //     bottom: context.height * .025,
  //   ),
  //   decoration: const BoxDecoration(
  //     image: DecorationImage(
  //       image: AssetImage(Assets.background),
  //       fit: BoxFit.fill,
  //     ),
  // ),
  // ),
  // )
  // ),
}

// HIDE ALL SECTION

Widget hideAllSection() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            text: AppString.hideAll,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
          5.verticalSpace,
          AppText(
            text: "Lorem ipsum dolor sit amet consectetur.",
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: AppColor.grey999,
          ),
        ],
      ),

      //SWITCH BUTTON

      ToggleSwitchBtn(
        onToggled: (isToggled) {},
      ),
    ],
  );
}

class InfoChip extends StatelessWidget {
  final String label;
  final String value;

  const InfoChip({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: AppColor.whiteFFFFFF.withOpacity(.2),
        // border: BorderSide.none,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          //LABEL
          AppText(
            color: AppColor.whiteFFFFFF,
            text: '$label: ',
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
          ),

          //VALUE

          AppText(
            color: AppColor.whiteFFFFFF,
            text: value,
            fontSize: 12.sp,
            fontWeight: FontWeight.w700,
          ),
        ],
      ),
    );
  }
}

Widget profileWidget({
  required String imageUrl,
  required String name,
  required int points,
  required bool isVip,
}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Stack(
        children: [
          CircleAvatar(
            radius: 30.r,
            backgroundImage: NetworkImage(imageUrl),
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
          text: "$points Points",
          color: const Color(0xff01C27D),
          fontSize: 15.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    ],
  );
}
