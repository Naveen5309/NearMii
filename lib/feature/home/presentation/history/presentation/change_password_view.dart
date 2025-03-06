import 'package:NearMii/config/app_utils.dart';
import 'package:NearMii/config/assets.dart';
import 'package:NearMii/config/enums.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/feature/auth/presentation/provider/states/auth_states.dart';
import 'package:NearMii/feature/common_widgets/common_button.dart';
import 'package:NearMii/feature/common_widgets/custom_appbar.dart';
import 'package:NearMii/feature/common_widgets/custom_label_text_field.dart';
import 'package:NearMii/feature/common_widgets/custom_toast.dart';
import 'package:NearMii/feature/setting/presentation/provider/change_password_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChangePasswordView extends ConsumerWidget {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(changePasswordProvider);
    // final signUpNotifiers = ref.watch(signupProvider.notifier);

    final changePasswordNotifier = ref.watch(changePasswordProvider.notifier);
    // ref.listen(changePasswordProvider, (previous, next) async {
    //   if (next is AuthApiLoading) {
    //     print("other user loading is called");
    //     Utils.showLoader();
    //   } else if (next is AuthApiSuccess) {
    //     Utils.hideLoader();

    //     // toNamed(context, Routes.bottomNavBar);
    //   } else if (next is AuthApiFailed) {
    //     if (context.mounted) {
    //       Utils.hideLoader();
    //     }

    //     toast(msg: next.error);
    //   }
    // });
    ref.listen(
      changePasswordProvider,
      (previous, next) {
        if (next is AuthApiLoading &&
            next.authType == AuthType.changePassword) {
          Utils.showLoader();
        } else if (next is AuthApiSuccess &&
            next.authType == AuthType.changePassword) {
          Utils.hideLoader();

          toast(msg: AppString.updatePasswordSuccess, isError: false);
          // toNamed(context, Routes.otpVerify);
          back(context);
        } else if (next is AuthApiFailed &&
            next.authType == AuthType.changePassword) {
          Utils.hideLoader();

          toast(msg: next.error);
        }
      },
    );

    return Scaffold(
      backgroundColor: AppColor.greyf9f9f9,
      appBar: const CustomAppBar(title: AppString.changePassword),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 28),
        child: Column(
          children: [
            Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
              var isVisible = ref.watch(isCurrentPasswordVisible);
              return CustomLabelTextField(
                onTapOnSuffixIcon: () {
                  ref.read(isCurrentPasswordVisible.notifier).state =
                      !ref.read(isCurrentPasswordVisible.notifier).state;
                },
                isObscure: isVisible,
                prefixIcon: Assets.icLock,
                controller: changePasswordNotifier.currentPasswordController,
                labelText: AppString.currentPassword,
                suffixIcon: !isVisible ? Assets.icEyeOff : Assets.icEye,
              );
            }),
            Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
              var isVisible = ref.watch(isNewPswdVisible);
              return CustomLabelTextField(
                onTapOnSuffixIcon: () {
                  ref.read(isNewPswdVisible.notifier).state =
                      !ref.read(isNewPswdVisible.notifier).state;
                },
                isObscure: isVisible,
                prefixIcon: Assets.icLock,
                controller: changePasswordNotifier.newPasswordController,
                labelText: AppString.newPswd,
                suffixIcon: !isVisible ? Assets.icEyeOff : Assets.icEye,
              );
            }),
            Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
              var isVisible = ref.watch(isPswdConfirmVisible);
              return CustomLabelTextField(
                onTapOnSuffixIcon: () {
                  ref.read(isPswdConfirmVisible.notifier).state =
                      !ref.read(isPswdConfirmVisible.notifier).state;
                },
                isObscure: isVisible,
                prefixIcon: Assets.icLock,
                controller: changePasswordNotifier.confirmPasswordController,
                labelText: AppString.confirmPswd,
                suffixIcon: !isVisible ? Assets.icEyeOff : Assets.icEye,
              );
            }),
            SizedBox(
              height: 33.h,
            ),
            CommonAppBtn(
              onTap: () {
                final isForget =
                    changePasswordNotifier.validateChangePassword();
                print(isForget);
                if (isForget) {
                  changePasswordNotifier.changePasswordApi(
                      authType: AuthType.changePassword);

                  // toNamed(context, Routes.otpVerify);

                  // final isNewPassword =
                  //     changePasswordNotifier.validateChangePassword();
                  // print(isNewPassword);
                  // if (isNewPassword) {
                }
                // }
              },
              title: AppString.update,
              textColor: AppColor.whiteFFFFFF,
              borderColor: AppColor.appThemeColor,
              backGroundColor: AppColor.appThemeColor,
            )
          ],
        ),
      ),
    );
  }
}
