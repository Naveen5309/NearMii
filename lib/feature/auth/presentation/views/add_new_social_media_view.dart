import 'package:NearMii/config/app_utils.dart';
import 'package:NearMii/config/assets.dart';
import 'package:NearMii/config/constants.dart';
import 'package:NearMii/config/debouncer.dart';
import 'package:NearMii/config/enums.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/feature/auth/presentation/provider/signup_provider.dart';
import 'package:NearMii/feature/auth/presentation/provider/states/auth_states.dart';
import 'package:NearMii/feature/auth/presentation/provider/states/country_code_provider.dart';
import 'package:NearMii/feature/common_widgets/app_text.dart';
import 'package:NearMii/feature/common_widgets/bg_image_container.dart';
import 'package:NearMii/feature/common_widgets/common_back_btn.dart';
import 'package:NearMii/feature/common_widgets/common_button.dart';
import 'package:NearMii/feature/common_widgets/custom_bottom_sheet.dart';
import 'package:NearMii/feature/common_widgets/custom_search_bar_widget.dart';
import 'package:NearMii/feature/common_widgets/custom_social_gridview.dart';
import 'package:NearMii/feature/common_widgets/social_shimmer.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

class AddNewSocialMediaView extends ConsumerStatefulWidget {
  final Map<String, dynamic> oldPlatformData;
  const AddNewSocialMediaView({
    super.key,
    required this.oldPlatformData,
  });

  @override
  ConsumerState<AddNewSocialMediaView> createState() =>
      _AddNewSocialMediaViewState();
}

class _AddNewSocialMediaViewState extends ConsumerState<AddNewSocialMediaView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final notifier = ref.read(signupProvider.notifier);

      notifier.getAddNewSocialPlatform(
          myPlatformList: widget.oldPlatformData["myPlatformList"]);
    });
  }

  final _debounce = Debouncer();

  void _onSearchChanged(String query) {
    final notifier = ref.read(signupProvider.notifier);
    _debounce.run(() {
      notifier.getAddNewSocialPlatform(
          myPlatformList: widget.oldPlatformData["myPlatformList"]);
    });
  }

  @override
  Widget build(BuildContext context) {
    // final authState = ref.watch(loginProvider);
    ref.watch(signupProvider);
    final signupPro = ref.watch(signupProvider.notifier);
    ref.watch(countryPickerProvider);

    ref.listen(
      signupProvider,
      (previous, next) {
        printLog("next in auth is :-> $next");
        if (next is AuthApiLoading && next.authType == AuthType.addPlatform) {
          Utils.showLoader();
        } else if (next is AuthApiSuccess &&
            next.authType == AuthType.addPlatform) {
          Utils.hideLoader();
          back(context);

          printLog("add platform success called");
        } else if (next is AuthApiFailed &&
            next.authType == AuthType.addPlatform) {
          Utils.hideLoader();

          // toast(msg: next.error);
        }
      },
    );

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton:
          //login
          (signupPro.addSocialList.isNotEmpty)
              ? Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: context.width * .05,
                      vertical: context.height * .01),
                  child: CommonAppBtn(
                    onTap: () async {
                      signupPro.addPlatform().then(
                        (value) async {
                          if (context.mounted) {}
                        },
                      );

                      // back(context);
                    },
                    title: AppString.done,
                    textSize: 16.sp,
                  ),
                )
              : const SizedBox(),
      body: BgImageContainer(
          bgImage: Assets.icProfileBg,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: context.width * .05),
            child: SingleChildScrollView(
              child: Consumer(builder:
                  (BuildContext context, WidgetRef ref, Widget? child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: totalHeight,
                    ),

                    InkWell(
                      onTap: () {
                        back(context);
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: context.height * .02),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const CommonBackBtn(),
                            InkWell(
                              onTap: () async {},
                              child: AppText(
                                text: " ",
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),

                    SizedBox(
                      height: context.height * .02,
                    ),
                    //Logo

                    //ADD SOCIAL PROFILES TEXT

//  (signupPro.isSocialLoading)?

                    (signupPro.newPlatformLists.isNotEmpty ||
                            signupPro.isSocialLoading)
                        ? AppText(
                            text: AppString.addSocialProfiles,
                            fontSize: 32.sp,
                          )
                        : const SizedBox(),

                    10.verticalSpace,

                    ((signupPro.newPlatformLists.isNotEmpty) ||
                            (signupPro.isSocialLoading))
                        ? RichText(
                            text: TextSpan(
                              text: 'Upload the URL of your profiles. ',
                              style: TextStyle(
                                color: AppColor.grey999,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Learn More',
                                  style: TextStyle(
                                    color: AppColor.btnColor,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                    decoration: TextDecoration.underline,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      // Handle the tap action here

                                      showCustomBottomSheet(
                                          context: context,
                                          content: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: .0, vertical: 15),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    AppText(
                                                      text:
                                                          "Steps to Add Profile Link",
                                                      fontSize: 18.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                    InkWell(
                                                        onTap: () {
                                                          back(context);
                                                        },
                                                        child: SvgPicture.asset(
                                                            height: 30,
                                                            width: 30,
                                                            Assets
                                                                .icCloseCircle))
                                                  ],
                                                ),
                                                12.verticalSpace,
                                                SizedBox(
                                                  height: context.height * .8,
                                                  child: ListView.builder(
                                                    itemCount: AppString
                                                        .stepsList.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      var data = AppString
                                                          .stepsList[index];
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                vertical: 8.0),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            5.verticalSpace,
                                                            AppText(
                                                                fontFamily:
                                                                    Constants
                                                                        .fontFamily,
                                                                fontSize: 15.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                text: data[
                                                                        "step"] ??
                                                                    ''),
                                                            5.verticalSpace,
                                                            AppText(
                                                                fontFamily:
                                                                    Constants
                                                                        .fontFamily,
                                                                fontSize: 12.sp,
                                                                lineHeight: 1.5,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: AppColor
                                                                    .black000000
                                                                    .withValues(
                                                                        alpha:
                                                                            .6),
                                                                text: data[
                                                                        "msg"] ??
                                                                    ''),
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ));

                                      // You can add any navigation or action here, e.g., navigate to a new screen
                                    },
                                ),
                              ],
                            ),
                          )
                        : const SizedBox(),

                    15.verticalSpace,

                    CustomSearchBarWidget(
                      controller: signupPro.searchTextController,
                      onChanged: (value) {
                        _onSearchChanged(value);
                      },
                    ),

                    (signupPro.isSocialLoading)
                        ? const SocialMediaShimmer()
                        : signupPro.newPlatformLists.isNotEmpty
                            ? SizedBox(
                                height: context.height * .61,
                                child: ListView.builder(
                                  itemCount: signupPro.newPlatformLists.length,
                                  padding: EdgeInsets.zero,
                                  physics:
                                      const ClampingScrollPhysics(), // Keeps inner scroll smooth

                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    var data =
                                        signupPro.newPlatformLists[index];
                                    return CustomSocialGridview(
                                      title: data.title ?? '',
                                      socialMedia: data.list ?? [],
                                      notifier: signupPro,
                                    );
                                  },
                                ),
                              )
                            : SizedBox(
                                height: context.height,
                                width: context.width,
                                child: Center(
                                  child: Column(
                                    children: [
                                      20.verticalSpace,
                                      Lottie.asset(Assets.emptyAnimation,
                                          backgroundLoading: true,
                                          height: context.height * .4,
                                          width: context.width,
                                          fit: BoxFit.fill),
                                      AppText(
                                        text: "No more social profile to add",
                                        color: AppColor.black000000,
                                        fontSize: 16.sp,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                    //SOCIAL MEDIA

                    SizedBox(
                      height: context.height * .05,
                    ),
                  ],
                );
              }),
            ),
          )),
    );
  }
}
