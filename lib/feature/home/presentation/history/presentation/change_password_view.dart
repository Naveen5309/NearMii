import 'package:NearMii/config/assets.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/feature/auth/presentation/provider/login_provider.dart';
import 'package:NearMii/feature/common_widgets/common_button.dart';
import 'package:NearMii/feature/common_widgets/custom_appbar.dart';
import 'package:NearMii/feature/common_widgets/custom_label_text_field.dart';
import 'package:NearMii/feature/setting/presentation/provider/change_password_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChangePasswordView extends ConsumerWidget {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final changePasswordNotifier = ref.watch(changePasswordProvider.notifier);

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
                      !isVisible;
                },
                isObscure: isVisible,
                prefixIcon: Assets.icLock,
                controller: changePasswordNotifier.currentPasswordController,
                labelText: AppString.currentPassword,
                suffixIcon: !isVisible ? Assets.icEye : Assets.icEyeOff,
              );
            }),
            Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
              var isVisible = ref.watch(isNewPswdVisible);
              return CustomLabelTextField(
                onTapOnSuffixIcon: () {
                  ref.read(isNewPswdVisible.notifier).state = !isVisible;
                },
                isObscure: isVisible,
                prefixIcon: Assets.icLock,
                controller: changePasswordNotifier.newPasswordController,
                labelText: AppString.newPswd,
                suffixIcon: !isVisible ? Assets.icEye : Assets.icEyeOff,
              );
            }),
            Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
              var isVisible = ref.watch(isConfirmPswdVisible);
              return CustomLabelTextField(
                onTapOnSuffixIcon: () {
                  ref.read(isConfirmPswdVisible.notifier).state = !isVisible;
                },
                isObscure: isVisible,
                prefixIcon: Assets.icLock,
                controller: changePasswordNotifier.confirmPasswordController,
                labelText: AppString.confirmPswd,
                suffixIcon: !isVisible ? Assets.icEye : Assets.icEyeOff,
              );
            }),
            SizedBox(
              height: 33.h,
            ),
            CommonAppBtn(
              onTap: () {
                // final isNewPassword =
                //     changePasswordNotifier.validateChangePassword();
                // print(isNewPassword);
                // if (isNewPassword) {
                back(context);
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
