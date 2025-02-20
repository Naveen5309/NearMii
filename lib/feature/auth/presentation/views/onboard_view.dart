import 'dart:developer';

import 'package:NearMii/config/assets.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/core/helpers/all_getter.dart';
import 'package:NearMii/core/utils/routing/routes.dart';
import 'package:NearMii/feature/auth/presentation/provider/onboard_provider.dart';
import 'package:NearMii/feature/common_widgets/app_text.dart';
import 'package:NearMii/feature/common_widgets/common_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingView extends ConsumerStatefulWidget {
  final bool? isFromSetting;
  const OnboardingView({super.key, this.isFromSetting = false});

  @override
  ConsumerState<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends ConsumerState<OnboardingView> {
  late PageController controller;

  @override
  void initState() {
    super.initState();
    controller = PageController();

    log("is from setting:-> ${widget.isFromSetting}");
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: context.height -
                context.padding.top - // Top safe area
                context.padding.bottom,
          ),
          // Background image
          SizedBox(
            height: context.height,
            width: context.width,
            child: Image.asset(
              height: context.height,
              width: context.width,

              Assets.icAppBg2,
              // Replace with your background image asset

              fit: BoxFit.cover,
              // Ensures the image covers the entire background
            ),
          ),
          // Content
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.width * 0.05),
            child: Column(
              children: [
                //SKIP

                (!widget.isFromSetting!)
                    ? Align(
                        alignment: Alignment.topRight,
                        child: InkWell(
                          onTap: () {
                            Getters.getLocalStorage.saveFirstIn(false).then(
                              (value) {
                                offAllNamed(context, Routes.auth);
                              },
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: context.height * .1,
                                bottom: context.height * .05),
                            child: ((ref.watch(onboardIndicatorIndex) != 2))
                                ? AppText(
                                    text: AppString.skip,
                                    fontSize: 14.sp,
                                  )
                                : const SizedBox(
                                    child: Text(' '),
                                  ),
                          ),
                        ),
                      )
                    : SizedBox(
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: context.height * .1,
                              bottom: context.height * .05),
                          child: const SizedBox(
                            child: Text(' '),
                          ),
                        ),
                      ),
                // IMAGE
                Consumer(
                  builder: (context, ref, child) {
                    return SizedBox(
                      height: context.height * 0.63,
                      child: PageView(
                        controller:
                            controller, // Attach the PageController here
                        onPageChanged: (value) {
                          log("on page changed value:-> $value");

                          ref.read(onboardIndicatorIndex.notifier).state =
                              value;
                        },
                        children: [
                          //PAGE 1
                          onboardTitleSubtitle(
                              title: AppString.addYourPersonalInfo,
                              subTitle: AppString.createYourUniqueProfile,
                              img: Assets.introOne),

                          //PAGE 2
                          onboardTitleSubtitle(
                              title: AppString.addSocialMedia,
                              subTitle: AppString.linkYourSocialMedia,
                              img: Assets.introTwo),

                          //PAGE 3
                          onboardTitleSubtitle(
                              title: AppString.refreshAndExplore,
                              subTitle: AppString.youAreAllSet,
                              img: Assets.introThree),
                        ],
                      ),
                    );
                  },
                ),

                // INDICATOR
                Padding(
                  padding: EdgeInsets.symmetric(vertical: context.height * .03),
                  child: SmoothPageIndicator(
                    controller: controller, // PageController
                    count: 3,

                    effect: CustomizableEffect(
                      dotDecoration: DotDecoration(
                        width: 42.w,
                        height: 6.w,
                        borderRadius: BorderRadius.circular(100),
                        color: AppColor.grey999.withOpacity(.6),
                      ),
                      activeDotDecoration: DotDecoration(
                          width: 42.w,
                          height: 6.w,
                          borderRadius: BorderRadius.circular(100),
                          color: AppColor.appThemeColor),
                    ),
                  ),
                ),
                const Spacer(),

                Consumer(
                  builder: (context, ref, child) {
                    final onboardIndex = ref.watch(onboardIndicatorIndex);
                    return
                        // GET STARTED BUTTON
                        CommonAppBtn(
                      onTap: () {
                        if (ref.read(onboardIndicatorIndex) == 0) {
                          ref.read(onboardIndicatorIndex.notifier).state = 1;
                          controller.jumpToPage(1);
                        } else if (ref.read(onboardIndicatorIndex) == 1) {
                          ref.read(onboardIndicatorIndex.notifier).state = 2;
                          controller.jumpToPage(2);
                        } else {
                          if (widget.isFromSetting!) {
                            back(context);
                          } else {
                            if (widget.isFromSetting!) {
                            } else {
                              Getters.getLocalStorage.saveFirstIn(false).then(
                                (value) {
                                  offAllNamed(context, Routes.auth);
                                },
                              );
                            }
                          }
                        }
                      },
                      title: onboardIndex != 2
                          ? AppString.continu
                          : AppString.getStarted,
                    );
                  },
                ),

                SizedBox(
                  height: context.height * .04,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

//Onboard Title Subtitle
  Widget onboardTitleSubtitle({
    required String title,
    required String subTitle,
    required String img,
  }) {
    return SizedBox(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //Title
          AppText(
            text: title,
            fontSize: 32.sp,
            fontWeight: FontWeight.w500,
          ),

          10.verticalSpace,

          //Description
          AppText(
            lineHeight: 1.2,
            text: subTitle,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: AppColor.grey999,
          ),
          SizedBox(
            height: context.height * .01,
          ),
          //Image
          SizedBox(
            child: SvgPicture.asset(
              height: context.height * 0.42,
              width: context.width,
              img,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
