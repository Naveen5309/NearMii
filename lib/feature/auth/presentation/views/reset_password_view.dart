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

class ResetPasswordView extends ConsumerWidget {
  const ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final validateCreateNewPassword = ref.watch(signupProvider.notifier);

    ref.listen(
      signupProvider,
      (previous, next) {
        if (next is AuthApiLoading && next.authType == AuthType.resetPassword) {
          Utils.showLoader();
        } else if (next is AuthApiSuccess &&
            next.authType == AuthType.resetPassword) {
          Utils.hideLoader();

          toast(msg: AppString.resetPswdSuccessfully, isError: false);
          // back(context);
          offAllNamed(context, Routes.login);
        } else if (next is AuthApiFailed &&
            next.authType == AuthType.resetPassword) {
          Utils.hideLoader();

          toast(msg: next.error);
        }
      },
    );

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
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

                    // SvgPicture.asset(
                    //   Assets.appLogo,
                    //   height: 20,
                    //   width: 20,
                    // ),

                    AppText(
                      text: AppString.createNewPswd,
                      fontSize: 32.sp,
                    ),

                    15.verticalSpace,
                    AppText(
                      text: AppString.enterYourEmailBelow,
                      fontSize: 13.sp,
                      color: AppColor.grey999,
                    ),

                    SizedBox(
                      height: context.height * .03,
                    ),

                    //Field forms

                    formsFieldsSection(validateCreateNewPassword),
                    // const Spacer(),

                    // //login
                    // CommonAppBtn(
                    //   onTap: () {
                    //     // final isNewPassword =
                    //     //     validateCreateNewPassword.validateCreateNewPassword();
                    //     // print(isNewPassword);
                    //     // if (isNewPassword) {
                    //     offAllNamed(context, Routes.login);
                    //     // }
                    //   },
                    //   title: AppString.submit,
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
              log("on click on create new pswd btn");
              final isValidOtp =
                  validateCreateNewPassword.validateResetPassword();
              // print(isValidOtp);
              if (isValidOtp) {
                validateCreateNewPassword.resetPassword();
                // toNamed(context, Routes.login);
              }
            },
            title: AppString.submit,
            textSize: 16.sp,
          ),
        ),
      ),
    );
  }

//FORMS FIELDS SECTION
  Widget formsFieldsSection(SignupNotifiers validateCreateNewPassword) {
    return Column(
      children: [
        //NEW PASSWORD
        Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
          var isVisible = ref.watch(isPswdVisibleSignUp);
          return CustomLabelTextField(
            onTapOnSuffixIcon: () {
              ref.read(isPswdVisibleSignUp.notifier).state =
                  !ref.read(isPswdVisibleSignUp.notifier).state;
            },
            isObscure: isVisible,
            prefixIcon: Assets.icLock,
            controller: validateCreateNewPassword.pswdController,
            labelText: AppString.newPswd,
            suffixIcon: isVisible ? Assets.icEye : Assets.icEyeOff,
          );
        }),

        //CONFIRM PASSWORD
        Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
          var isVisible = ref.watch(isConfirmPswdVisibleSignUp);
          return CustomLabelTextField(
            onTapOnSuffixIcon: () {
              ref.read(isConfirmPswdVisibleSignUp.notifier).state =
                  !ref.read(isConfirmPswdVisibleSignUp.notifier).state;
            },
            isObscure: isVisible,
            prefixIcon: Assets.icLock,
            controller: validateCreateNewPassword.confirmPswdController,
            labelText: AppString.confirmPswd,
            suffixIcon: isVisible ? Assets.icEye : Assets.icEyeOff,
          );
        })
      ],
    );
  }
}
