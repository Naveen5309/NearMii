import 'package:NearMii/config/assets.dart';
import 'package:NearMii/config/constants.dart';
import 'package:NearMii/config/enums.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/core/utils/routing/routes.dart';
import 'package:NearMii/feature/auth/presentation/provider/signup_provider.dart';
import 'package:NearMii/feature/auth/presentation/provider/states/auth_states.dart';
import 'package:NearMii/feature/common_widgets/app_text.dart';
import 'package:NearMii/feature/common_widgets/bg_image_container.dart';
import 'package:NearMii/feature/common_widgets/common_back_btn.dart';
import 'package:NearMii/feature/common_widgets/common_button.dart';
import 'package:NearMii/feature/common_widgets/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

class VerityOtpView extends ConsumerStatefulWidget {
  const VerityOtpView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VerityOtpViewState();
}

class _VerityOtpViewState extends ConsumerState<VerityOtpView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var notifier =
          ref.read(signupProvider.notifier); // Initialize the notifier
      notifier.startTimer();
      notifier.clearOtpFields();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final otpValidatorNotifier = ref.watch(signupProvider.notifier);
    ref.watch(signupProvider);

    ref.listen(
      signupProvider,
      (previous, next) {
        if (next is AuthApiLoading &&
            ((next.authType == AuthType.otpVerify) ||
                (next.authType == AuthType.resendOtp))) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.0),
                    color: AppColor.primary,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(28.0),
                    child: CircularProgressIndicator.adaptive(),
                  ),
                ),
              );
            },
          );
        } else if (next is AuthApiSuccess &&
            next.authType == AuthType.otpVerify) {
          otpValidatorNotifier.clearResetPasswordFields();
          Navigator.of(context, rootNavigator: true)
              .pop(); // Close loading dialog if open
          toast(msg: AppString.otpVerified, isError: false);
          otpValidatorNotifier.cancelTimer();

          toNamed(context, Routes.resetPassword);
        } else if (next is AuthApiFailed &&
            next.authType == AuthType.otpVerify) {
          Navigator.of(context, rootNavigator: true)
              .pop(); // Close loading dialog
          toast(msg: next.error);
        } else if (next is AuthApiSuccess &&
            next.authType == AuthType.resendOtp) {
          back(context);
          otpValidatorNotifier.startTimer();
          otpValidatorNotifier.clearOtpFields();

          toast(msg: AppString.otpVerifySuccess, isError: false);
        } else if (next is AuthApiFailed &&
            next.authType == AuthType.resendOtp) {
          Navigator.of(context, rootNavigator: true).pop();
          back(context);

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
              vertical: context.height * .05,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: context.height * .05),
                  child: CommonBackBtn(
                    onTap: () {
                      otpValidatorNotifier.cancelTimer().then(
                        (value) {
                          if (context.mounted) {
                            back(context);
                          }
                        },
                      );
                    },
                  ),
                ),
                AppText(
                  text: AppString.enterOneTimePswd,
                  fontSize: 32.sp,
                ),
                15.verticalSpace,
                Wrap(
                  spacing: 4.0, // Optional: Adds spacing between elements
                  runSpacing:
                      4.0, // Optional: Adds spacing between wrapped lines
                  children: [
                    AppText(
                      text: AppString.enterOtp,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColor.grey999,
                    ),
                    AppText(
                      text: ' ${otpValidatorNotifier.emailController.text}',
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColor.grey4848,
                    ),
                  ],
                ),
                SizedBox(height: context.height * .05),
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
                    ),
                    textStyle: TextStyle(
                      fontFamily: Constants.fontFamily,
                      color: AppColor.green42B002,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  defaultPinTheme: PinTheme(
                    height: context.width * .20,
                    width: context.width * .20,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColor.green42B002,
                      ),
                      borderRadius: BorderRadius.circular(100),
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
                      color: AppColor.green173E01,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: context.height * .04,
                    bottom: context.height * .015,
                  ),
                  child: AppText(
                    text: AppString.didntReceicedOtp,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColor.grey4848,
                  ),
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (otpValidatorNotifier.enableResend) {
                          otpValidatorNotifier.forgotPasswordApi(
                              authType: AuthType.resendOtp);
                        } else {}
                      },
                      child: AppText(
                        text: AppString.resendOtp,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: otpValidatorNotifier.enableResend
                            ? AppColor.black000000
                            : AppColor.greyD4D4D4,
                      ),
                    ),
                    AppText(
                      text: ' (00:${otpValidatorNotifier.secondsRemaining})',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColor.btnColor,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
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
              final isValidOtp = otpValidatorNotifier.validateOtp();
              if (isValidOtp) {
                otpValidatorNotifier.verifyOtp();
              }
            },
            title: AppString.submit,
            textSize: 16.sp,
          ),
        ),
      ),
    );
  }
}
