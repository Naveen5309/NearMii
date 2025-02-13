import 'package:NearMii/config/assets.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/core/utils/routing/routes.dart';
import 'package:NearMii/feature/auth/presentation/provider/signup_provider.dart';
import 'package:NearMii/feature/auth/presentation/provider/state_notifiers/signup_notifiers.dart';
import 'package:NearMii/feature/common_widgets/app_text.dart';
import 'package:NearMii/feature/common_widgets/bg_image_container.dart';
import 'package:NearMii/feature/common_widgets/common_button.dart';
import 'package:NearMii/feature/common_widgets/custom_label_text_field.dart';
import 'package:NearMii/feature/common_widgets/custom_rich_text.dart';
import 'package:NearMii/feature/common_widgets/custom_rich_text_three_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SignUpView extends ConsumerWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signUpNotifier = ref.watch(signupProvider.notifier);

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

                    Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: SvgPicture.asset(
                        Assets.icDummyLogo,
                        // height: 100,
                        // width: 100,
                      ),
                    ),

                    AppText(
                      text: AppString.signUpToYourAccount,
                      fontSize: 32.sp,
                    ),

                    15.verticalSpace,
                    AppText(
                      text: AppString.letSignUpToYourAccount,
                      fontSize: 14.sp,
                      color: AppColor.grey999,
                    ),

                    SizedBox(
                      height: context.height * .04,
                    ),

                    //Field forms

                    formsFieldsSection(signUpNotifier),

                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: context.height * .02),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Consumer(
                            builder: (context, ref, child) {
                              final isTrue = ref.watch(checkPrivacy);

                              return

                                  // final check = ref.watch(checkPrivacy);
                                  // return GestureDetector(
                                  //   onTap: () {
                                  //     ref.read(checkPrivacy.notifier).state =
                                  //         !ref.read(checkPrivacy.notifier).state;
                                  //   },
                                  //   child:
                                  GestureDetector(
                                onTap: () {
                                  ref.read(checkPrivacy.notifier).state =
                                      !isTrue;
                                },
                                child: Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1.0,
                                        color: isTrue
                                            ? AppColor.btnColor
                                            : AppColor.black000000),
                                    borderRadius: BorderRadius.circular(4.0),
                                    color: isTrue
                                        ? AppColor.btnColor
                                        : AppColor.whiteFFFFFF,
                                  ),
                                  child: isTrue
                                      ? Center(
                                          child: Icon(
                                            Icons.check_sharp,
                                            color: AppColor.primary,
                                            size: 16
                                                .sp, // Adjust icon size to fit nicely in the box.
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                                  //  check
                                  //     ?

                                  // : const SizedBox()
                                  // );
                                ),
                              );
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: context.width * .02),
                            child: SizedBox(
                              width: context.width * .8,
                              child: Wrap(
                                children: [
                                  CustomRichTextThreeWidget(
                                    text: AppString.iAgreeTo,
                                    onTap: () {},
                                    onTap2: () {},
                                    clickableText: AppString.termsAndConditions,
                                    clickableText2: AppString.privacyPolicy,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: context.height * .01,
                    ),
                    //login
                    CommonAppBtn(
                      onTap: () {
                        // final isLogin = signUpNotifier.validateSignUp();

                        // if (isLogin) {
                        //   signUpNotifier.saveIsLogin().then(
                        //     (value) {
                        //       if (context.mounted) {
                        offAllNamed(context, Routes.completeProfile);
                        // }
                        // },
                        // );
                        // }
                      },
                      title: AppString.signUp,
                      textSize: 16.sp,
                    ),

                    //OR CONTINUE WITH

                    orContinueWith(context: context),

                    //social media section
                    socialMediaSection(),
                    SizedBox(
                      height: context.height * .05,
                    ),

                    //ALREADY HAVE AN ACCOUNT
                    Align(
                      alignment: Alignment.center,
                      child: CustomRichText(
                          onTap: () {
                            toNamed(context, Routes.login);
                          },
                          text: AppString.alreadyHaveAnAccount,
                          clickableText: AppString.signIn),
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }

//FORMS FIELDS SECTION
  Widget formsFieldsSection(SignupNotifiers signUpNotifier) {
    return Column(
      children: [
        //EMAIL ADDRESS
        CustomLabelTextField(
          prefixIcon: Assets.icUser,
          controller: signUpNotifier.emailController,
          labelText: AppString.emailAddress,
        ),

        //PASSWORD
        Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
          var isVisible = ref.watch(isPswdVisibleSignUp);
          return CustomLabelTextField(
            isObscure: isVisible,
            onTapOnSuffixIcon: () {
              ref.read(isPswdVisibleSignUp.notifier).state = !isVisible;
            },
            prefixIcon: Assets.icLock,
            controller: signUpNotifier.pswdController,
            labelText: AppString.pswd,
            suffixIcon: !isVisible ? Assets.icEye : Assets.icEyeOff,
          );
        }),

        //CONFIRM PASSWORD
        Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            var isVisible = ref.watch(isPswdConfirmVisible);
            print("isVisible===>$isVisible");
            return CustomLabelTextField(
              onTapOnSuffixIcon: () {
                ref.read(isPswdConfirmVisible.notifier).state = !isVisible;
              },
              isObscure: isVisible,
              prefixIcon: Assets.icLock,
              controller: signUpNotifier.confirmPswdController,
              labelText: AppString.confirmPswd,
              suffixIcon: !isVisible ? Assets.icEye : Assets.icEyeOff,
            );
          },
        ),
      ],
    );
  }
}

//SOCIAL MEDIA SECTION

Widget socialMediaSection() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 25),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SvgPicture.asset(Assets.icFbSingle),
        SvgPicture.asset(Assets.google),
        SvgPicture.asset(Assets.apple),
      ],
    ),
  );
}

//OR CONTINUE WITH

Widget orContinueWith({required BuildContext context}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: context.height * .03),
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
            text: AppString.orContinueWiths,
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
