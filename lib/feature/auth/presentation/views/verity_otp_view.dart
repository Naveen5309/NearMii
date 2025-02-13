import 'package:NearMii/config/assets.dart';
import 'package:NearMii/config/constants.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/core/utils/routing/routes.dart';
import 'package:NearMii/feature/auth/presentation/provider/signup_provider.dart';
import 'package:NearMii/feature/common_widgets/app_text.dart';
import 'package:NearMii/feature/common_widgets/bg_image_container.dart';
import 'package:NearMii/feature/common_widgets/common_back_btn.dart';
import 'package:NearMii/feature/common_widgets/common_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

class VerityOtpView extends ConsumerWidget {
  const VerityOtpView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final otpValidatorNotifier = ref.watch(signupProvider.notifier);

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
                  //   height: 50,
                  //   width: 50,
                  // ),

                  AppText(
                    text: AppString.enterOneTimePswd,
                    fontSize: 32.sp,
                  ),

                  15.verticalSpace,
                  Row(
                    children: [
                      AppText(
                        text: AppString.enterOtp,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColor.grey999,
                      ),
                      AppText(
                        text: ' "example@gmail.com"',
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColor.grey4848,
                      ),
                    ],
                  ),

                  SizedBox(
                    height: context.height * .05,
                  ),

                  Pinput(
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    controller: otpValidatorNotifier.otpController,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    focusedPinTheme: PinTheme(
                        height: context.width * .20,
                        width: context.width * .20,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColor.green42B002,
                          ),
                          borderRadius: BorderRadius.circular(100),
                          // color: AppColor.green42B002,
                        ),
                        textStyle: TextStyle(
                          fontFamily: Constants.fontFamily,
                          color: AppColor.green42B002,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w400,
                        )),
                    defaultPinTheme: PinTheme(
                      height: context.width * .20,
                      width: context.width * .20,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColor.green42B002,
                        ),
                        borderRadius: BorderRadius.circular(100),
                        // color: AppColor.green42B002,
                      ),
                    ),
                    submittedPinTheme: PinTheme(
                      height: context.width * .20,
                      width: context.width * .20,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColor.green42B002,
                        ),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      textStyle: TextStyle(
                        fontFamily: Constants.fontFamily,
                        color: AppColor
                            .green173E01, // Set text color to white when filled
                        fontSize: 20.sp, // Set font size to 24
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),

                  //didn't receive otp

                  Padding(
                    padding: EdgeInsets.only(
                        top: context.height * .04,
                        bottom: context.height * .015),
                    child: AppText(
                      text: AppString.didntReceicedOtp,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColor.grey4848,
                    ),
                  ),

                  //RESEND OTP

                  Row(
                    children: [
                      AppText(
                        text: AppString.resendOtp,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColor.black000000,
                      ),
                      AppText(
                        text: " (00:24)",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColor.btnColor,
                      ),
                    ],
                  ),

                  SizedBox(
                    height: context.height * .05,
                  ),

                  //Field forms

                  //login

                  SizedBox(
                    height: context.height * .05,
                  ),
                ],
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
              // final isValidOtp = otpValidatorNotifier.validateOtp();
              // print(isValidOtp);
              // if (isValidOtp) {
              toNamed(context, Routes.resetPassword);
              // }
            },
            title: AppString.submit,
            textSize: 16.sp,
          ),
        ),
      ),
    );
  }
}
