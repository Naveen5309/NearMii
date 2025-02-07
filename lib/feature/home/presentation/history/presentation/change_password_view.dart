import 'package:NearMii/config/assets.dart';
import 'package:NearMii/config/constants.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/feature/common_widgets/app_text.dart';
import 'package:NearMii/feature/common_widgets/common_button.dart';
import 'package:NearMii/feature/common_widgets/custom_appbar.dart';
import 'package:NearMii/feature/common_widgets/custom_appbar_widget.dart';
import 'package:NearMii/feature/common_widgets/custom_label_text_field.dart';
import 'package:NearMii/feature/common_widgets/custombtn.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: AppString.changePassword),
      // AppBar(
      //   shape: Border.all(width: 0),

      //   leading: Padding(
      //     padding: const EdgeInsets.all(5.0),
      //     child: SvgPicture.asset(Assets.iconBackBtn),
      //   ),
      //   backgroundColor: AppColor.primary,
      //   centerTitle: true,
      //   title: AppText(
      //     text: AppString.changePassword,
      //     fontSize: 20.sp,
      //     fontWeight: FontWeight.w500,
      //     fontFamily: Constants.fontFamily,
      //     color: AppColor.black000000,
      //   ),

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
