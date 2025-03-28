import 'dart:developer';
import 'package:NearMii/config/app_utils.dart';
import 'package:NearMii/config/assets.dart';
import 'package:NearMii/config/debouncer.dart';
import 'package:NearMii/config/enums.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/core/network/http_service.dart';
import 'package:NearMii/core/utils/routing/routes.dart';
import 'package:NearMii/feature/auth/presentation/provider/login_provider.dart';
import 'package:NearMii/feature/auth/presentation/provider/states/auth_states.dart';
import 'package:NearMii/feature/common_widgets/app_text.dart';
import 'package:NearMii/feature/common_widgets/custom_bottom_sheet.dart';
import 'package:NearMii/feature/common_widgets/custom_cache_network.dart';
import 'package:NearMii/feature/common_widgets/custom_search_bar_widget.dart';
import 'package:NearMii/feature/common_widgets/custom_switch_btn.dart';
import 'package:NearMii/feature/common_widgets/custom_toast.dart';
import 'package:NearMii/feature/common_widgets/profile_grid_view.dart';
import 'package:NearMii/feature/self_user_profile/presentation/provider/get_self_social_provider.dart';
import 'package:NearMii/feature/self_user_profile/presentation/provider/state/self_user_profile_state.dart';
import 'package:NearMii/feature/self_user_profile/presentation/provider/state_notifier/self_user_profile_notifier.dart';
import 'package:NearMii/feature/setting/data/model/profile_model.dart';
import 'package:NearMii/feature/setting/presentation/view/delete_account_confirmation_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sliver_snap/widgets/sliver_snap.dart';

class MyProfileView extends ConsumerStatefulWidget {
  const MyProfileView({super.key});

  @override
  ConsumerState<MyProfileView> createState() => _MyProfileViewState();
}

class _MyProfileViewState extends ConsumerState<MyProfileView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final notifier = ref.read(getSocialProfileProvider.notifier);

      // notifier.getSocialPlatform(query: '');
      notifier.getProfileApi();
      // final selfNotifier = ref.read(getSocialProfileProvider.notifier);
      // selfNotifier.getSelfPlatformApi();
    });
  }

  final _debounce = Debouncer();

  void onSearchChanged(String query) {
    final notifier = ref.read(getSocialProfileProvider.notifier);
    _debounce.run(() {
      notifier.getSelfPlatformApi();
    });
  }

  @override
  Widget build(BuildContext context) {
    printLog("profile screen called");
    final next = ref.watch(getSocialProfileProvider);
    printLog("======>>>>>>>>>>> $next");
    final notifier = ref.read(getSocialProfileProvider.notifier);
    // ref.watch(getSocialProfileProvider);
    ref.listen(
      getSocialProfileProvider,
      (previous, next) {
        printLog("next is :-> $next");
        printLog("next is :-> $previous");

        if (next is SelfUserProfileApiLoading &&
            next.selfProfileDataType == SelfProfileDataType.getProfile) {
          Utils.showLoader();
        } else if (next is SelfUserProfileApiSuccess &&
            next.selfProfileDataType == SelfProfileDataType.getProfile) {
          // toast(msg: AppString.loginSuccess, isError: false);
          Utils.hideLoader();
          notifier.getSelfPlatformApi();

          // toNamed(context, Routes.bottomNavBar);
        } else if (next is SelfUserProfileApiFailed &&
            next.selfProfileDataType == SelfProfileDataType.getProfile) {
          Utils.hideLoader();

          // toast(msg: next.error);
        } else if (next is SelfUserProfileApiLoading &&
            next.selfProfileDataType == SelfProfileDataType.deletePlatform) {
          Utils.showLoader();
        } else if (next is SelfUserProfileApiSuccess &&
            next.selfProfileDataType == SelfProfileDataType.deletePlatform) {
          Utils.hideLoader();
          back(context);
          toast(msg: "Social profile deleted successfully", isError: false);
          notifier.getSelfPlatformApi();

          // toNamed(context, Routes.bottomNavBar);
        } else if (next is SelfUserProfileApiFailed &&
            next.selfProfileDataType == SelfProfileDataType.deletePlatform) {
          Utils.hideLoader();
          toast(msg: next.error);
        } else if (next is SelfUserProfileApiLoading &&
            next.selfProfileDataType == SelfProfileDataType.hideAll) {
          Utils.showLoader();
        } else if (next is SelfUserProfileApiSuccess &&
            next.selfProfileDataType == SelfProfileDataType.hideAll) {
          Utils.hideLoader();
          back(context);
          //   toast(msg: "Data updated", isError: false);
          // notifier.getSelfPlatformApi();
          notifier.getProfileApi();
        } else if (next is SelfUserProfileApiFailed &&
            next.selfProfileDataType == SelfProfileDataType.hideAll) {
          Utils.hideLoader();
          toast(msg: next.error);
        } else if (next is SelfUserProfileApiLoading &&
            next.selfProfileDataType == SelfProfileDataType.hidePlatform) {
          Utils.showLoader();
        } else if (next is SelfUserProfileApiSuccess &&
            next.selfProfileDataType == SelfProfileDataType.hidePlatform) {
          Utils.hideLoader();
          notifier.getSelfPlatformApi();

          // toNamed(context, Routes.bottomNavBar);
        } else if (next is SelfUserProfileApiFailed &&
            next.selfProfileDataType == SelfProfileDataType.hidePlatform) {
          Utils.hideLoader();
          toast(msg: next.error);
        } else if (next is SelfUserProfileApiLoading &&
            next.selfProfileDataType == SelfProfileDataType.updatePlatform) {
          Utils.showLoader();
        } else if (next is SelfUserProfileApiSuccess &&
            next.selfProfileDataType == SelfProfileDataType.updatePlatform) {
          Utils.hideLoader();
          back(context);
          notifier.getSelfPlatformApi();

          // toNamed(context, Routes.bottomNavBar);
        } else if (next is SelfUserProfileApiFailed &&
            next.selfProfileDataType == SelfProfileDataType.updatePlatform) {
          Utils.hideLoader();
          toast(msg: next.error);
        }
      },
    );

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
            toNamed(context, Routes.addNewSocialMedia, args: {
              // "socialMedia": notifier.socialMediaList,
              // "contactInformation": notifier.contactList,
              // "portfolio": notifier.portfolioList,

              "myPlatformList": notifier.newPlatformLists
            }).then(
              (value) {
                notifier.getSelfPlatformApi();
              },
            );
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
        body: (notifier.userProfileModel == null)
            ? Shimmer.fromColors(
                baseColor: AppColor.whiteF0F5FE,
                highlightColor: AppColor.grey9EAE95,
                child: Column(
                    mainAxisSize: MainAxisSize
                        .min, // Ensures column takes only necessary space
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
                              colorFilter: const ColorFilter.mode(
                                  AppColor.primary, BlendMode.srcIn),
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
                      Container(
                        height: 20,
                        width: 150,
                        color: Colors.grey.shade400,
                      ),
                      5.verticalSpace,
                      Container(
                        height: 20,
                        width: 150,
                        color: Colors.grey.shade400,
                      ),
                      25.verticalSpace,
                      Container(
                        height: 20,
                        width: 150,
                        color: Colors.grey.shade400,
                      ),
                      20.verticalSpace,
                      20.verticalSpace,
                      Wrap(
                        alignment: WrapAlignment.center,
                        runSpacing: 8,
                        spacing: 6,
                        children: [
                          Container(
                            height: 20,
                            width: 150,
                            color: Colors.grey.shade400,
                          ),
                          Container(
                            height: 20,
                            width: 150,
                            color: Colors.grey.shade400,
                          ),
                          Container(
                            height: 20,
                            width: 150,
                            color: Colors.grey.shade400,
                          ),
                          Container(
                            height: 20,
                            width: 150,
                            color: Colors.grey.shade400,
                          ),
                          Container(
                            height: 20,
                            width: 150,
                            color: Colors.grey.shade400,
                          ),
                          Container(
                            height: 255,
                            width: context.width,
                            color: Colors.grey.shade400,
                          ),
                        ],
                      )
                    ]),
              )
            : SliverSnap(
                stretch: true,
                scrollBehavior: const CupertinoScrollBehavior(),
                pinned: true,
                animationCurve: Curves.easeInOutCubicEmphasized,
                animationDuration: const Duration(milliseconds: 1),
                onCollapseStateChanged:
                    (isCollapsed, scrollingOffset, maxExtent) {},
                collapsedBackgroundColor: AppColor.btnColor,
                expandedBackgroundColor: const Color.fromRGBO(0, 0, 0, 0),
                expandedContentHeight: () {
                  double baseHeight = context.height * .55;

                  if (notifier.userProfileModel == null) {
                    return context.height *
                        .5; // Default height when profile is null
                  }

                  int emptyFields = 0;

                  if (notifier.userProfileModel!.name == null ||
                      notifier.userProfileModel!.name!.isEmpty) {
                    emptyFields++;
                  }
                  if (notifier.userProfileModel!.designation == null ||
                      notifier.userProfileModel!.designation!.isEmpty) {
                    emptyFields++;
                  }
                  if (notifier.userProfileModel!.bio == null ||
                      notifier.userProfileModel!.bio!.isEmpty) {
                    emptyFields++;
                  }

                  return baseHeight - (emptyFields * context.height * .03);
                }(),
                expandedContent: profileSection(
                    selfUserProfileNotifier: notifier,
                    context: context,
                    profile: notifier.userProfileModel),
                collapsedContent: appBarWidgetSection(
                  profile: notifier.userProfileModel,
                  context: context,
                ),
                body: bottomSection(
                    profile: notifier.userProfileModel,
                    selfUserProfileNotifier: notifier,
                    context: context,
                    onSearchChanged: onSearchChanged)));
  }
}

//APP BAR WIDGET SECTION

Widget appBarWidgetSection({
  required BuildContext context,
  required UserProfileModel? profile,
}) {
  return Row(
    children: [
      InkWell(
        onTap: () {
          back(context);
        },
        child: Padding(
          padding: EdgeInsets.only(
            right: 15.w,
            top: 15,
            bottom: 15,
          ),
          child: SvgPicture.asset(
            Assets.icBackBtn,
            colorFilter:
                const ColorFilter.mode(AppColor.primary, BlendMode.srcIn),
          ),
        ),
      ),
      Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xff69DDA5),
        ),
        padding: const EdgeInsets.all(3),
        child: CustomCacheNetworkImage(
          img: profile?.profilePhoto != null
              ? ("${ApiConstants.profileBaseUrl}${profile?.profilePhoto}")
              : '',
          imageRadius: 150,
          height: 40.w,
          width: 40.w,
        ),
      ),
      5.horizontalSpace,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: context.width * .7,
            child: AppText(
              text: profile?.name ?? '',
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
              color: AppColor.whiteFFFFFF,
            ),
          ),
          profile?.designation != null
              ? SizedBox(
                  width: context.width * .7,
                  child: AppText(
                    text: profile?.designation ?? '',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColor.whiteFFFFFF.withValues(alpha: .8),
                  ),
                )
              : const SizedBox(),
        ],
      )
    ],
  );
}

//BOTTOM SECTION

Widget bottomSection({
  required SelfUserProfileNotifier selfUserProfileNotifier,
  required BuildContext context,
  required UserProfileModel? profile,
  required Function(String) onSearchChanged, // Add this parameter
}) {
  return Container(
    color: AppColor.greyf9f9f9,
    width: context.width,
    child: Padding(
      padding: EdgeInsets.symmetric(
          horizontal: context.width * .04, vertical: context.width * .01),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(children: [
          CustomSearchBarWidget(
            controller: selfUserProfileNotifier.searchTextController,
            onChanged: (value) {
              onSearchChanged(value);
            },
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: hideAllSection(
                      context: context,
                      profile: profile,
                      selfUserProfileNotifier: selfUserProfileNotifier),
                ),
                SizedBox(
                  // height: context.height * .8,
                  child: ListView.builder(
                      shrinkWrap: true, // Allow wrapping content height
                      physics: const NeverScrollableScrollPhysics(),
                      hitTestBehavior: HitTestBehavior.translucent,
                      padding: EdgeInsets.zero,
                      itemCount:
                          selfUserProfileNotifier.newPlatformLists.length,
                      itemBuilder: (context, index) {
                        var data =
                            selfUserProfileNotifier.newPlatformLists[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ProfileGridView(
                            isMyProfile: true,
                            title: data.title ?? '',
                            socialMedia: data.list ?? [],
                          ),
                        );
                      }),
                )
              ],
            ),
          )
        ]),
      ),
    ),
  );
}

//PROFILE SECTION

Widget profileSection(
    {required BuildContext context,
    required UserProfileModel? profile,
    required SelfUserProfileNotifier selfUserProfileNotifier}) {
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
          // SizedBox(height: context.height * .1),
          Align(
            alignment: Alignment.centerLeft,
            child: InkWell(
              onTap: () {
                back(context);
              },
              child: Container(
                alignment: Alignment.centerLeft,
                width: context.width,
                child: Padding(
                  padding: EdgeInsets.only(
                      top: context.height * .1, bottom: context.height * .02),
                  child: SizedBox(
                    height: 30,
                    width: 30,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: context.width * .05,
                      ),
                      child: SvgPicture.asset(
                        Assets.icBackBtn,
                        colorFilter: const ColorFilter.mode(
                            AppColor.primary, BlendMode.srcIn),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // SizedBox(height: context.height * .02),
          Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xff69DDA5),
            ),
            padding: const EdgeInsets.all(6),
            child: CustomCacheNetworkImage(
              dummyPadding: 30,
              img: profile?.profilePhoto != null
                  ? "${ApiConstants.profileBaseUrl}${profile?.profilePhoto}"
                  : '',
              imageRadius: 150,
              height: 105.w,
              width: 105.w,
            ),
          ),
          10.verticalSpace,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.width * .05),
            child: AppText(
              color: AppColor.whiteFFFFFF,
              text: profile?.name ?? '',
              fontSize: 20.sp,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w500,
            ),
          ),
          8.verticalSpace,
          if (profile?.designation != null &&
              profile!.designation!.isNotEmpty) ...[
            8.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.width * .05),
              child: AppText(
                text: profile.designation!,
                fontWeight: FontWeight.w500,
                fontSize: 16.sp,
                textAlign: TextAlign.center,
                color: AppColor.whiteFFFFFF.withValues(alpha: .8),
              ),
            ),
          ],
          if (profile?.bio != null && profile!.bio!.isNotEmpty) ...[
            25.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.width * .05),
              child: AppText(
                text: profile.bio!,
                textAlign: TextAlign.center,
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: AppColor.whiteFFFFFF.withValues(alpha: .8),
              ),
            ),
          ],

          20.verticalSpace,
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 12,
            runSpacing: 12,
            children:
                selfUserProfileNotifier.newPlatformListsProfile.map((entry) {
              return InfoChip(
                  label: entry.title ?? "Unknown",
                  value: entry.list?.length.toString() ?? '0');
            }).toList(),
          ),
        ]),
  );
}

// HIDE ALL SECTION

Widget hideAllSection({
  required BuildContext context,
  required UserProfileModel? profile,
  required SelfUserProfileNotifier selfUserProfileNotifier,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            text: profile != null
                ? ((profile.hideProfile == 0)
                    ? AppString.hideProfile
                    : AppString.showProfile)
                : AppString.hideProfile,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
          5.verticalSpace,
          AppText(
            text: "Hide/Show your profile to other users",
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: AppColor.grey999,
          ),
        ],
      ),

      //SWITCH BUTTON

      ToggleSwitchBtn(
        isToggled: profile != null
            ? ((profile.hideProfile == 0) ? true : false)
            : false,
        onToggled: (isToggled) {
          log("toggle called");

          showCustomBottomSheet(
              context: context,
              content: DeleteAccountConfirmationView(
                  btnText: profile != null
                      ? ((profile.hideProfile == 0)
                          ? AppString.hide
                          : AppString.show)
                      : AppString.hide,
                  title: profile?.hideProfile == 0
                      ? AppString.areYouSureProfileHide
                      : AppString.areYouSureProfileShow,
                  delete: () {
                    selfUserProfileNotifier.hideAllLinksApi(
                        hideProfile: profile?.hideProfile == 0 ? 1 : 0);
                  },
                  onCancel: () {
                    back(context);
                  }));
        },
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
