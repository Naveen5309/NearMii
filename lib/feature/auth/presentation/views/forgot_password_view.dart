import 'dart:developer';

import 'package:NearMii/config/app_utils.dart';
import 'package:NearMii/config/assets.dart';
import 'package:NearMii/config/enums.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/core/utils/routing/routes.dart';
import 'package:NearMii/feature/auth/presentation/provider/signup_provider.dart';
import 'package:NearMii/feature/auth/presentation/provider/state_notifiers/signup_notifiers.dart';
import 'package:NearMii/feature/auth/presentation/provider/states/auth_states.dart';
import 'package:NearMii/feature/common_widgets/app_text.dart';
import 'package:NearMii/feature/common_widgets/bg_image_container.dart';
import 'package:NearMii/feature/common_widgets/common_back_btn.dart';
import 'package:NearMii/feature/common_widgets/common_button.dart';
import 'package:NearMii/feature/common_widgets/custom_label_text_field.dart';
import 'package:NearMii/feature/common_widgets/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgotPasswordView extends ConsumerStatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  ConsumerState<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends ConsumerState<ForgotPasswordView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        final forgetPasswordNotifier = ref.read(signupProvider.notifier);
        forgetPasswordNotifier.clearFormFields();
        forgetPasswordNotifier.cancelTimer();
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final forgetPasswordNotifier = ref.read(signupProvider.notifier);

    ref.listen(
      signupProvider,
      (previous, next) {
        if (next is AuthApiLoading &&
            next.authType == AuthType.forgotPassword) {
          Utils.showLoader();
        } else if (next is AuthApiSuccess &&
            next.authType == AuthType.forgotPassword) {
          Utils.hideLoader();

          toast(msg: AppString.otpVerifySuccess, isError: false);
          toNamed(context, Routes.otpVerify);
        } else if (next is AuthApiFailed &&
            next.authType == AuthType.forgotPassword) {
          Utils.hideLoader();

          toast(msg: next.error);
        }
      },
    );

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: BgImageContainer(
            bgImage: Assets.authBg,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: context.width * .06,
                  vertical: context.height * .05),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: totalHeight - AppBar().preferredSize.height,
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: context.height * .05),
                      child: const CommonBackBtn(),
                    ),
                    //Logo

                    // const Text("APPlOGO"),

                    AppText(
                      text: AppString.didYouForgotYourPswd,
                      fontSize: 32.sp,
                    ),

                    15.verticalSpace,
                    AppText(
                      text: AppString.enterYourEmailBelow,
                      fontSize: 13.sp,
                      color: AppColor.grey999,
                    ),

                    SizedBox(
                      height: context.height * .05,
                    ),

                    //Field forms

                    formsFieldsSection(forgetPasswordNotifier),
                    // const Spacer(),
                    // //login
                    // CommonAppBtn(
                    //   onTap: () {
                    //     // final isForget =
                    //     //     forgetPasswordNotifier.validateForgetPassword();
                    //     // print(isForget);
                    //     // if (isForget) {
                    //     toNamed(context, Routes.otpVerify);
                    //     // }
                    //   },
                    //   title: AppString.send,
                    //   textSize: 16.sp,
                    // ),

                    SizedBox(
                      height: context.height * .05,
                    ),
                  ],
                ),
              ),
            )),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: EdgeInsets.only(
            left: context.width * .06,
            right: context.width * .06,
            top: context.width * .06,
            bottom: context.width * .03,
          ),
          child: CommonAppBtn(
            onTap: () {
              final isForget = forgetPasswordNotifier.validateForgetPassword();
              print(isForget);
              if (isForget) {
                forgetPasswordNotifier.forgotPasswordApi(
                    authType: AuthType.forgotPassword);
                // toNamed(context, Routes.otpVerify);
              }
            },
            title: AppString.send,
            textSize: 16.sp,
          ),
        ),
      ),
    );
  }

  Widget formsFieldsSection(SignupNotifiers forgetPasswordNotifier) {
    return Column(
      children: [
        //EMAIL ADDRESS
        CustomLabelTextField(
          prefixIcon: Assets.icUser,
          controller: forgetPasswordNotifier.emailController,
          labelText: AppString.emailAddress,
        ),
      ],
    );
  }
}
