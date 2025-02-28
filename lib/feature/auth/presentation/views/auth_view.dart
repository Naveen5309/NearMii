import 'dart:developer';
import 'dart:io';

import 'package:NearMii/config/app_utils.dart';
import 'package:NearMii/config/assets.dart';
import 'package:NearMii/config/enums.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/core/utils/routing/routes.dart';
import 'package:NearMii/feature/auth/presentation/provider/login_provider.dart';
import 'package:NearMii/feature/auth/presentation/provider/states/auth_states.dart';
import 'package:NearMii/feature/common_widgets/app_text.dart';
import 'package:NearMii/feature/common_widgets/bg_image_container.dart';
import 'package:NearMii/feature/common_widgets/common_button.dart';
import 'package:NearMii/feature/common_widgets/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class AuthView extends ConsumerWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      loginProvider,
      (previous, next) {
        if (next is AuthApiLoading && next.authType == AuthType.login) {
          Utils.showLoader();
        } else if (next is AuthApiSuccess && next.authType == AuthType.login) {
          log("login success");
          Utils.hideLoader();
          toast(msg: AppString.loginSuccess, isError: false);
          // back(context);
          offAllNamed(context, Routes.bottomNavBar, args: true);
        } else if (next is AuthApiFailed && next.authType == AuthType.login) {
          Utils.hideLoader();

          toast(msg: next.error);
        }
      },
    );
    return Scaffold(
      body: BgImageContainer(
        bgImage: Assets.authBg,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.width * .05),
          child: Column(
            children: [
              SizedBox(
                height: totalHeight,
              ),
              //Logo

              SizedBox(
                height: context.height * 0.05,
              ),
              // const Text("APPlOGO"),

              Padding(
                padding: const EdgeInsets.only(bottom: 18.0),
                child: SvgPicture.asset(
                  height: 50,

                  Assets.icDummyLogo,
                  // height: 100,
                  // width: 100,
                ),
              ),

              //Title
              AppText(
                text: AppString.fromRealityToReach,
                fontSize: 26.sp,
                fontWeight: FontWeight.w500,
              ),

              SizedBox(
                height: context.height * .1,
              ),

              //sign up btm
              CommonAppBtn(
                onTap: () {
                  offAllNamed(context, Routes.signUp);
                },
                title: AppString.signUp,
                textSize: 16.sp,
              ),

              15.verticalSpace,

              //I Have an account
              CommonAppBtn(
                borderColor: AppColor.appThemeColor.withOpacity(.15),
                backGroundColor: AppColor.appThemeColor.withOpacity(.15),
                onTap: () {
                  offAllNamed(context, Routes.login);
                },
                textColor: AppColor.appThemeColor,
                title: AppString.iHaveAnAccount,
                textSize: 16.sp,
              ),

              //--OR--
              Padding(
                padding: EdgeInsets.symmetric(vertical: context.height * .05),
                child: Row(
                  children: [
                    Expanded(
                      child: customDividerContainer(gradientColor: [
                        AppColor.black000000.withOpacity(.01),
                        AppColor.black000000.withOpacity(.2),
                      ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: AppText(
                        text: AppString.or,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColor.black000000.withOpacity(.6),
                      ),
                    ),
                    Expanded(
                      child: customDividerContainer(gradientColor: [
                        AppColor.black000000.withOpacity(.2),
                        AppColor.black000000.withOpacity(.01),
                      ]),
                    ),
                  ],
                ),
              ),

              //SOCIAL MEDIA SECTION
              socialMediaSection(context: context)
            ],
          ),
        ),
      ),
    );
  }

  //Social media section

  Widget socialMediaSection({required BuildContext context}) {
    return Consumer(
      builder: (context, ref, child) {
        final loginNotifier = ref.watch(loginProvider.notifier);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //GOOGLE
            customSocialMediaBtn(
              onTap: () {
                loginNotifier.signInWithGoogle(context);
              },
              icon: Assets.icGoogle2,
              text: AppString.signInWithGoogle,
              context: context,
            ),

            //FACEBOOK
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: context.height * .03,
              ),
              child: customSocialMediaBtn(
                onTap: () {},
                icon: Assets.icFb2,
                text: AppString.singInWithFb,
                context: context,
              ),
            ),

            //APPLE
            if (Platform.isIOS)
              customSocialMediaBtn(
                onTap: () {},
                icon: Assets.icApple2,
                text: AppString.singInWithApple,
                context: context,
              ),
          ],
        );
      },
    );
  }

//CUSTOM DIVIDER CONTAINER
  Widget customDividerContainer({required List<Color> gradientColor}) {
    return Container(
      height: 1.5,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: gradientColor)),
    );
  }

  //Custom social media section
  Widget customSocialMediaBtn(
      {required String icon,
      required String text,
      required VoidCallback onTap,
      required BuildContext context}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: context.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50), color: AppColor.primary),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(icon),
              10.horizontalSpace,
              AppText(
                text: text,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: AppColor.green173E01,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
