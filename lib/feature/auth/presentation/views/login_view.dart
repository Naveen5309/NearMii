import 'dart:developer';
import 'dart:io';

import 'package:NearMii/config/app_utils.dart';
import 'package:NearMii/config/assets.dart';
import 'package:NearMii/config/enums.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/core/utils/routing/routes.dart';
import 'package:NearMii/feature/auth/data/models/social_profile_model.dart';
import 'package:NearMii/feature/auth/presentation/provider/login_provider.dart';
import 'package:NearMii/feature/auth/presentation/provider/state_notifiers/login_notifiers.dart';
import 'package:NearMii/feature/auth/presentation/provider/states/auth_states.dart';
import 'package:NearMii/feature/common_widgets/app_text.dart';
import 'package:NearMii/feature/common_widgets/bg_image_container.dart';
import 'package:NearMii/feature/common_widgets/common_button.dart';
import 'package:NearMii/feature/common_widgets/custom_bottom_sheet.dart';
import 'package:NearMii/feature/common_widgets/custom_label_text_field.dart';
import 'package:NearMii/feature/common_widgets/custom_rich_text.dart';
import 'package:NearMii/feature/common_widgets/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        final loginNotifier = ref.read(loginProvider.notifier);
        loginNotifier.clearLoginFields();
      },
    );
    super.initState();
  }

  void showCustomBottomSheet(
      {required BuildContext context,
      required Widget content,
      Color? color,
      final EdgeInsetsGeometry? contentPadding,
      double? radius}) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      context: context,
      isScrollControlled: true,
      builder: (
        BuildContext context,
      ) {
        return Container(
            decoration: color != null
                ? BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(radius ?? 20),
                      topRight: Radius.circular(radius ?? 20),
                    ),
                    color: color)
                : const BoxDecoration(
                    color: AppColor.primary,

                    // gradient: LinearGradient(
                    //   colors: AppColor.splashGradientColor,
                    //   begin: Alignment.topCenter,
                    //   end: Alignment.bottomCenter,
                    // ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context)
                    .viewInsets
                    .bottom, // Adjusts for the keyboard
              ),
              child: CustomBottomSheet(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 8,
                      width: context.width * .5,
                      decoration: BoxDecoration(
                          color: Colors.grey.withValues(alpha: .4),
                          borderRadius: BorderRadius.circular(100)),
                    ),
                    20.verticalSpace,
                    SvgPicture.asset(Assets.icAccountSuspend),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      child: AppText(
                        text: AppString.accountSuspended,
                        fontSize: 20.sp,
                      ),
                    ),
                    const AppText(
                      text: AppString.yourAccountIsSuspend,
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                      textAlign: TextAlign.center,
                    ),
                    20.verticalSpace,
                    CommonAppBtn(
                      height: 50,
                      width: context.width * .6,
                      title: AppString.contactUs,
                      onTap: () {
                        final loginNotifier = ref.read(loginProvider.notifier);
                        loginNotifier.clearLoginFields();
                        back(context);
                        toNamed(context, Routes.contactUs);
                      },
                    ),
                    20.verticalSpace,
                  ],
                ),
                color: color,
                contentPadding: contentPadding,
              ),
            ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final loginNotifier = ref.watch(loginProvider.notifier);

    ref.watch(loginProvider);
    // final loginNotifier = ref.watch(loginProvider.notifier);

    ref.listen(
      loginProvider,
      (previous, next) {
        if (next is AuthApiLoading && next.authType == AuthType.login) {
          Utils.showLoader();
        } else if (next is AuthApiSuccess && next.authType == AuthType.login) {
          Utils.hideLoader();

          log("success:-> ${loginNotifier.userModel?.isProfile}");

          if (loginNotifier.userModel?.isProfile == 1) {
            toast(msg: AppString.loginSuccess, isError: false);
            toNamed(context, Routes.bottomNavBar, args: true);
          } else if (loginNotifier.userModel?.isProfile == 0) {
            toast(
                msg: AppString.completeYourProfile,
                isError: false,
                isInfo: true);
            toNamed(
              context,
              Routes.completeProfile,
              args: SocialProfileModel(
                  img: loginNotifier.socialImg,
                  name: loginNotifier.fullNameController.text,
                  email: loginNotifier.socialEmail),
            );

            // SocialProfileModel(

            // )
            //  {"name"loginNotifier.fullNameController.text:,"img":loginNotifier.profilePic});
          }
        } else if (next is AuthApiFailed && next.authType == AuthType.login) {
          // back(context);
          Utils.hideLoader();
          // toast(msg: next.error);

          if (next.error == "Your account has been suspended") {
            showCustomBottomSheet(content: const Text("df"), context: context);
          } else {
            toast(msg: next.error);
          }
        }
      },
    );

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: BgImageContainer(
            bgImage: Assets.loginBg,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: context.width * .05),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: totalHeight,
                    ),
                    //Logo

                    // const Text("APPlOGO"),

                    Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: SvgPicture.asset(
                          Assets.icDummyLogo,
                          height: 50,
                          // width: 100,
                        ),
                      ),
                    ),
                    15.verticalSpace,
                    AppText(
                      text: AppString.signInToYourAccount,
                      fontSize: 32.sp,
                      // style: AppTextStyle.regular,
                    ),

                    15.verticalSpace,
                    AppText(
                      text: AppString.letSignInToYourAccount,
                      fontSize: 14.sp,
                      color: AppColor.grey999,
                    ),

                    SizedBox(
                      height: context.height * .05,
                    ),

                    //FORMS FIELDS

                    formsFieldsSection(loginNotifier),

                    //FORGOT PASSWORD

                    InkWell(
                      onTap: () {
                        loginNotifier.clearLoginFields().then(
                          (value) {
                            if (context.mounted) {
                              toNamed(context, Routes.forgetPassword);
                            }
                          },
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: context.height * .02,
                            bottom: context.height * .04),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: AppText(
                            text: AppString.forgotPswd,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),

                    //login
                    CommonAppBtn(
                      onTap: () {
                        final isLogin = loginNotifier.validateLogin();

                        if (isLogin) {
                          loginNotifier.loginApi();

                          // offAllNamed(context, Routes.bottomNavBar);
                        }
                      },
                      title: AppString.login,
                      textSize: 16.sp,
                    ),

                    //or

                    orContinueWith(context: context),

                    //social media section
                    socialMediaSection(
                      onTapOnApple: () {},
                      onTapOnFb: () {},
                      onTapOnGoogle: () {
                        final loginNotifier = ref.watch(loginProvider.notifier);

                        loginNotifier.signInWithGoogle(context);
                      },
                    ),
                    SizedBox(
                      height: context.height * .05,
                    ),

                    //DON'T HAVE AN ACCOUNT
                    Align(
                      alignment: Alignment.center,
                      child: CustomRichText(
                        onTap: () {
                          toNamed(context, Routes.signUp);
                        },
                        text: AppString.dontHaveAnAccount,
                        clickableText: AppString.signUp,
                      ),
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }

  Widget formsFieldsSection(LoginNotifier loginNotifier) {
    return Column(
      children: [
        //EMAIL ADDRESS
        CustomLabelTextField(
          prefixIcon: Assets.icUser,
          controller: loginNotifier.emailController,
          labelText: AppString.emailAddress,
        ),

        //PASSWORD
        Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            var isVisible = ref.watch(isPswdVisible);
            return CustomLabelTextField(
              onTapOnSuffixIcon: () {
                ref.read(isPswdVisible.notifier).state =
                    !ref.read(isPswdVisible.notifier).state;
              },
              isObscure: isVisible,
              prefixIcon: Assets.icLock,
              controller: loginNotifier.passwordController,
              labelText: AppString.pswd,
              suffixIcon: isVisible ? Assets.icEyeOff : Assets.icEye,
            );
          },
        )
      ],
    );
  }
}

//SOCIAL MEDIA SECTION

Widget socialMediaSection({
  required VoidCallback onTapOnFb,
  required VoidCallback onTapOnGoogle,
  required VoidCallback onTapOnApple,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      GestureDetector(
          onTap: onTapOnFb, child: SvgPicture.asset(Assets.icFbSingle)),
      15.horizontalSpace,
      GestureDetector(
          onTap: onTapOnGoogle, child: SvgPicture.asset(Assets.google)),
      15.horizontalSpace,
      if (Platform.isIOS)
        GestureDetector(
            onTap: onTapOnApple, child: SvgPicture.asset(Assets.apple)),
    ],
  );
}

//OR CONTINUE WITH

Widget orContinueWith({required BuildContext context}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: context.height * .05),
    child: Row(
      children: [
        Expanded(
          child: customDividerContainer(gradientColor: [
            AppColor.black000000.withValues(alpha: .01),
            AppColor.black000000.withValues(alpha: .2),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: AppText(
            text: AppString.orContinueWiths,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: AppColor.black000000.withValues(alpha: .6),
          ),
        ),
        Expanded(
          child: customDividerContainer(gradientColor: [
            AppColor.black000000.withValues(alpha: .2),
            AppColor.black000000.withValues(alpha: .01),
          ]),
        ),
      ],
    ),
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
