import 'dart:developer';
import 'package:NearMii/config/app_utils.dart';
import 'package:NearMii/config/assets.dart';
import 'package:NearMii/config/constants.dart';
import 'package:NearMii/config/enums.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/core/helpers/all_getter.dart';
import 'package:NearMii/core/network/http_service.dart';
import 'package:NearMii/core/utils/routing/routes.dart';
import 'package:NearMii/feature/auth/presentation/provider/login_provider.dart';
import 'package:NearMii/feature/auth/presentation/provider/states/auth_states.dart';
import 'package:NearMii/feature/common_widgets/app_text.dart';
import 'package:NearMii/feature/common_widgets/common_btn.dart';
import 'package:NearMii/feature/common_widgets/common_button.dart';
import 'package:NearMii/feature/common_widgets/custom_appbar_widget.dart';
import 'package:NearMii/feature/common_widgets/custom_bottom_sheet.dart';
import 'package:NearMii/feature/common_widgets/custom_cache_network.dart';
import 'package:NearMii/feature/common_widgets/custom_dotted_box.dart';
import 'package:NearMii/feature/common_widgets/custom_toast.dart';
import 'package:NearMii/feature/common_widgets/setting_custom_tile.dart';
import 'package:NearMii/feature/home/presentation/history/presentation/invite_friend.dart';
import 'package:NearMii/feature/home/presentation/history/presentation/logout_confirmation_view.dart';
import 'package:NearMii/feature/setting/presentation/provider/get_profile_provider.dart';
import 'package:NearMii/feature/setting/presentation/view/shimmer_loader.dart';
import 'package:NearMii/feature/web_view/web_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SettingView extends ConsumerStatefulWidget {
  const SettingView({super.key});

  @override
  ConsumerState<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends ConsumerState<SettingView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(getProfileProvider.notifier).getProfileApi();
    });
  }

  @override
  Widget build(BuildContext context) {
    var notifier = ref.watch(getProfileProvider.notifier);
    ref.watch(getProfileProvider);

    ref.watch(loginProvider);

    ref.listen(loginProvider, (previous, next) async {
      if (next is AuthApiLoading && next.authType == AuthType.logOut) {
        Utils.showLoader();
      } else if (next is AuthApiSuccess && next.authType == AuthType.logOut) {
        toast(msg: AppString.logoutSuccess, isError: false);
        await Getters.getLocalStorage.saveFirstIn(false);

        await Getters.getLocalStorage.clearLoginData();
        Utils.hideLoader();

        // back(context);

        if (context.mounted) {
          offAllNamed(context, Routes.login);
        }
      } else if (next is AuthApiFailed && next.authType == AuthType.logOut) {
        Utils.hideLoader();

        toast(msg: next.error);
      }
    });

    final isVIP = notifier.userProfileModel != null
        ? notifier.userProfileModel?.isSubscription == 1
        : false;
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
                physics: const ClampingScrollPhysics(),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 18, horizontal: 11),
                  child: Column(
                    children: [
                      notifier.userProfileModel == null
                          // notifier.userProfileModel?.profilePhoto == null
                          ? const SettingProfileShimmer()
                          : profileWidget(
                              imageUrl: notifier
                                          .userProfileModel?.profilePhoto !=
                                      null
                                  ? ApiConstants.profileBaseUrl +
                                      notifier.userProfileModel!.profilePhoto!
                                  : notifier.userProfileModel?.socialImage ??
                                      '',
                              name: notifier.userProfileModel?.name ?? '',
                              points: notifier.userProfileModel?.points ?? 0,
                              isVip: isVIP,
                            ),
                      28.verticalSpace,
                      dottedContainer(context, isVIP),
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

                      //UPDATE PROFILE
                      CustomTile(
                        leadingIcon: Assets.iconPerson,
                        title: AppString.editProfile,
                        subtitle: AppString.updateProfile,
                        trailingIcon: Assets.iconArrowRight,
                        onTap: () async {
                          await toNamed(context, Routes.editProfile).then(
                            (value) {
                              ref
                                  .read(getProfileProvider.notifier)
                                  .getProfileApi();
                            },
                          );
                        },
                      ),
                      10.verticalSpace,

                      //INVITE FRIENDS
                      CustomTile(
                        leadingIcon: Assets.add,
                        title: AppString.inviteFriends,
                        subtitle: AppString.get15points,
                        trailingIcon: Assets.iconArrowRight,
                        onTap: () => showCustomBottomSheet(
                            context: context,
                            content: InviteFriendBottomSheet(
                              text: notifier.userProfileModel?.token ?? '',
                              title: AppString.inviteFriend,
                              subtitle:
                                  "Share the referral code with your friends and get 5 credits for each invite",
                            )),
                      ),

                      10.verticalSpace,

                      //SET RADIUS
                      CustomTile(
                        leadingIcon: Assets.iconSetRadius,
                        title: AppString.setRadius,
                        subtitle: (notifier.userProfileModel?.radius != null &&
                                double.tryParse(notifier
                                        .userProfileModel!.radius
                                        .toString()) !=
                                    null)
                            ? "${(double.parse(notifier.userProfileModel!.radius.toString()) * 1000).toStringAsFixed(0)} M"
                            : "50 M",
                        trailingIcon: Assets.iconArrowRight,
                        onTap: () {
                          toNamed(context, Routes.setRadius).then(
                            (value) {
                              notifier.getProfileApi();
                            },
                          );
                        },
                      ),
                      10.verticalSpace,

                      CustomTile(
                          leadingIcon: Assets.iconCheckBox,
                          title: AppString.termsAndConditions,
                          subtitle: AppString.viewOurPolicies,
                          trailingIcon: Assets.iconArrowRight,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const CustomWebView(
                                    url: ApiConstants.termsAndConditions,
                                    title: AppString.termsAndConditions,
                                    // url:
                                    //     "https://www.latlong.net/Show-Latitude-Longitude.html",
                                  ),
                                ));
                          }

                          // toNamed(context, Routes.termsAndConditions),
                          ),
                      10.verticalSpace,

                      CustomTile(
                          leadingIcon: Assets.iconCheckBox,
                          title: AppString.privacyPolicy,
                          subtitle: AppString.viewOurPolicies,
                          trailingIcon: Assets.iconArrowRight,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const CustomWebView(
                                    url: ApiConstants.privacyPolicy,
                                    title: AppString.privacyPolicy,
                                  ),
                                ));
                          }

                          // toNamed(context, Routes.termsAndConditions),
                          ),
                      10.verticalSpace,

                      //CHANGE PASSWORD

                      notifier.userProfileModel?.socialId == null
                          ? CustomTile(
                              leadingIcon: Assets.iconChangePassword,
                              title: AppString.changePassword,
                              subtitle: AppString.resetYourPswd,
                              trailingIcon: Assets.iconArrowRight,
                              onTap: () =>
                                  toNamed(context, Routes.changePassword),
                            )
                          : const SizedBox.shrink(),
                      notifier.userProfileModel?.socialId == null
                          ? 10.verticalSpace
                          : const SizedBox.shrink(),

                      //CONTACT US
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
                        onTap: () => toNamed(
                            context, Routes.deleteAccountReason,
                            args: notifier.userProfileModel?.socialId ?? ''),
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
                          onTap: () => showCustomBottomSheet(
                              context: context,
                              content: LogoutConfirmationView(
                                confirm: () {
                                  final notifier =
                                      ref.read(loginProvider.notifier);
                                  notifier.logOutApi();
                                },
                                onCancel: () {
                                  back(context);
                                },
                              )),
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

  Widget profileWidget({
    required String imageUrl,
    required String name,
    required int points,
    required bool isVip,
  }) {
    log("img url si :-> $imageUrl");

    log("img url si :-> ${(imageUrl.runtimeType)}");

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            CustomCacheNetworkImage(
              img: imageUrl,
              imageRadius: 70,
              height: 100,
              width: 100,
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

        //NAME
        AppText(
          text: name,
          fontFamily: Constants.fontFamily,
          fontSize: 24.sp,
          color: AppColor.black000000,
          fontWeight: FontWeight.w500,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: const Color(0xff01C27D).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: AppText(
            text: "$points Credits",
            color: const Color(0xff01C27D),
            fontFamily: Constants.fontFamily,
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget dottedContainer(
    BuildContext context,
    bool isVip,
  ) {
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
                  color: AppColor.grey21203F.withValues(alpha: .5),
                ),
              ],
            ),
            const Spacer(),
            (isVip == false)
                ? SizedBox(
                    height: 28.h,
                    width: 76.w,
                    child: Consumer(
                      builder: (_, WidgetRef ref, __) {
                        return CommonBtn(
                          text: "Buy Now",
                          onPressed: () {
                            toNamed(context, Routes.subscription).then(
                              (value) {
                                ref
                                    .read(getProfileProvider.notifier)
                                    .getProfileApi();
                              },
                            );
                          },
                        );
                      },
                    ),
                  )
                : Consumer(
                    builder: (_, WidgetRef ref, __) {
                      ref.watch(getProfileProvider);

                      String daysLeft = ref
                          .read(getProfileProvider.notifier)
                          .subscriptionDaysLeft;
                      return AppText(
                        fontFamily: Constants.fontFamily,
                        text: "$daysLeft days left",
                        color: const Color(0xff00C565),
                        fontSize: 12.sp,
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
