import 'package:NearMii/config/assets.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/feature/common_widgets/common_button.dart';
import 'package:NearMii/feature/common_widgets/custom_appbar.dart';
import 'package:NearMii/feature/common_widgets/custom_label_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary,
      appBar: const CustomAppBar(title: AppString.changePassword),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 28),
        child: Column(
          children: [
            CustomLabelTextField(
              prefixIcon: Assets.icLock,
              controller: TextEditingController(),
              labelText: AppString.currentPassword,
            ),
            CustomLabelTextField(
              prefixIcon: Assets.icLock,
              controller: TextEditingController(),
              labelText: AppString.newPswd,
            ),
            CustomLabelTextField(
              prefixIcon: Assets.icLock,
              controller: TextEditingController(),
              labelText: AppString.confirmPswd,
            ),
            SizedBox(
              height: 33.h,
            ),
            const CommonAppBtn(
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
