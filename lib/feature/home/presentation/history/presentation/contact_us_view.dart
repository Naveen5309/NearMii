import 'package:NearMii/config/assets.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/feature/common_widgets/common_button.dart';
import 'package:NearMii/feature/common_widgets/custom_appbar.dart';
import 'package:NearMii/feature/common_widgets/custom_label_text_field.dart';
import 'package:NearMii/feature/common_widgets/custom_textform_feild.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContactUsView extends StatelessWidget {
  const ContactUsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary,
      appBar: const CustomAppBar(title: AppString.contactUs),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 28),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomLabelTextField(
                labelBckColor: AppColor.primary,
                prefixIcon: Assets.icUser,
                controller: TextEditingController(),
                labelText: AppString.currentPassword,
              ),
              CustomLabelTextField(
                labelBckColor: AppColor.primary,
                prefixIcon: Assets.icSms,
                controller: TextEditingController(),
                labelText: AppString.newPswd,
              ),
              CustomLabelTextField(
                labelBckColor: AppColor.primary,
                prefixIcon: Assets.icSubject,
                controller: TextEditingController(),
                labelText: AppString.subject,
              ),
              CustomTextformFeild(
                radius: 19,
                prefixIcon: Assets.icCheck,
                controller: TextEditingController(),
                labelText: AppString.message,
                maxLines: 5,
              ),
              SizedBox(
                height: 130.h,
              ),
              const CommonAppBtn(
                title: AppString.submit,
                textColor: AppColor.whiteFFFFFF,
                borderColor: AppColor.appThemeColor,
                backGroundColor: AppColor.appThemeColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
