import 'package:NearMii/config/assets.dart';
import 'package:NearMii/config/constants.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/feature/common_widgets/app_text.dart';
import 'package:NearMii/feature/common_widgets/common_button.dart';
import 'package:NearMii/feature/common_widgets/custom_appbar.dart';
import 'package:NearMii/feature/common_widgets/custom_label_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class DeletedDetailView extends StatelessWidget {
  const DeletedDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: AppString.deleteAccount),
      backgroundColor: AppColor.primary,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 130),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(Assets.deleteAccount),
              const SizedBox(height: 20),
              AppText(
                  text: AppString.deleteAccount,
                  fontFamily: Constants.fontFamily,
                  fontSize: 14.sp,
                  color: AppColor.black000000,
                  fontWeight: FontWeight.w500),
              const SizedBox(height: 10),
              AppText(
                text: AppString.enterYourCurrentPswd,
                fontFamily: Constants.fontFamily,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: AppColor.black000000.withValues(alpha: 0.6),
              ),
              const SizedBox(height: 20),
              CustomLabelTextField(
                prefixIcon: Assets.icLock,
                controller: TextEditingController(),
                labelText: AppString.currentPassword,
              ),
              const SizedBox(height: 20),
              const CommonAppBtn(
                title: AppString.done,
              )
            ],
          ),
        ),
      ),
    );
  }
}
