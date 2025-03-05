import 'dart:io';

import 'package:NearMii/config/app_utils.dart';
import 'package:NearMii/config/assets.dart';
import 'package:NearMii/config/enums.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/core/utils/routing/routes.dart';
import 'package:NearMii/feature/auth/data/models/social_profile_model.dart';
import 'package:NearMii/feature/auth/presentation/provider/login_provider.dart';
import 'package:NearMii/feature/auth/presentation/provider/signup_provider.dart';
import 'package:NearMii/feature/auth/presentation/provider/state_notifiers/signup_notifiers.dart';
import 'package:NearMii/feature/auth/presentation/provider/states/auth_states.dart';
import 'package:NearMii/feature/common_widgets/app_text.dart';
import 'package:NearMii/feature/common_widgets/bg_image_container.dart';
import 'package:NearMii/feature/common_widgets/common_button.dart';
import 'package:NearMii/feature/common_widgets/custom_label_text_field.dart';
import 'package:NearMii/feature/common_widgets/custom_rich_text.dart';
import 'package:NearMii/feature/common_widgets/custom_rich_text_three_widget.dart';
import 'package:NearMii/feature/common_widgets/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SignUpView extends ConsumerStatefulWidget {
  const SignUpView({super.key});

  @override
  ConsumerState<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends ConsumerState<SignUpView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        ref.watch(signupProvider.notifier).clearFormFields();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final signUpNotifier = ref.watch(signupProvider.notifier);

    ref.watch(signupProvider);
    // final loginNotifier = ref.watch(loginProvider.notifier);

    ref.listen(
      signupProvider,
      (previous, next) {
        if (next is AuthApiLoading && next.authType == AuthType.signup) {
          Utils.showLoader();
        } else if (next is AuthApiSuccess && next.authType == AuthType.signup) {
          Utils.hideLoader();

          // toast(msg: AppString.signupSuccess, isError: false);
          // back(context);
          // toNamed(context, Routes.completeProfile);

          final loginNotifier = ref.read(loginProvider.notifier);
          toNamed(
            context,
            Routes.completeProfile,
            args: SocialProfileModel(
                img: loginNotifier.socialImg,
                name: loginNotifier.fullNameController.text),
          );
        } else if (next is AuthApiFailed && next.authType == AuthType.signup) {
          Utils.hideLoader();

          toast(msg: next.error);
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
                      alignment: Alignment.center,
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
                                    onTap: () {
                                      toNamed(
                                          context, Routes.termsAndConditions);
                                    },
                                    onTap2: () {
                                      toNamed(
                                          context, Routes.termsAndConditions);
                                    },
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
                    //Sign up
                    CommonAppBtn(
                      onTap: () {
                        final isValid = signUpNotifier.validateSignUp();

                        if (isValid) {
                          if (!ref.read(checkPrivacy.notifier).state) {
                            toast(
                                msg: AppString.acceptTermsAndConditions,
                                isError: true);
                          } else {
                            signUpNotifier.registerApi();
                          }
                          // signUpNotifier.saveIsLogin().then((value) {
                          //   if (context.mounted) {
                          //     // offAllNamed(context, Routes.completeProfile);
                          //   }
                          // });
                        }
                      },
                      title: AppString.signUp,
                      textSize: 16.sp,
                    ),

                    //OR CONTINUE WITH

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
            isObscure: !isVisible,
            onTapOnSuffixIcon: () {
              ref.read(isPswdVisibleSignUp.notifier).state =
                  !ref.read(isPswdVisibleSignUp.notifier).state;
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
            return CustomLabelTextField(
              onTapOnSuffixIcon: () {
                ref.read(isPswdConfirmVisible.notifier).state =
                    !ref.read(isPswdConfirmVisible.notifier).state;
              },
              isObscure: !isVisible,
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

Widget socialMediaSection(
    {required VoidCallback onTapOnFb,
    required VoidCallback onTapOnGoogle,
    required VoidCallback onTapOnApple}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 25),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: onTapOnFb,
          child: SvgPicture.asset(Assets.icFbSingle),
        ),
        15.horizontalSpace,
        GestureDetector(
            onTap: onTapOnGoogle, child: SvgPicture.asset(Assets.google)),
        15.horizontalSpace,
        if (Platform.isIOS)
          GestureDetector(
              onTap: onTapOnApple, child: SvgPicture.asset(Assets.apple)),
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
