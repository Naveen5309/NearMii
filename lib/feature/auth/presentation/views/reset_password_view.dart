import 'package:NearMii/config/assets.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/core/utils/routing/routes.dart';
import 'package:NearMii/feature/common_widgets/app_text.dart';
import 'package:NearMii/feature/common_widgets/bg_image_container.dart';
import 'package:NearMii/feature/common_widgets/common_back_btn.dart';
import 'package:NearMii/feature/common_widgets/common_button.dart';
import 'package:NearMii/feature/common_widgets/custom_label_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: BgImageContainer(
            bgImage: Assets.loginBg,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: context.width * .06),
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

                  SvgPicture.asset(
                    Assets.appLogo,
                    height: 20,
                    width: 20,
                  ),

                  AppText(
                    text: AppString.createNewPswd,
                    fontSize: 32.sp,
                  ),

                  15.verticalSpace,
                  AppText(
                    text: AppString.enterYourEmailBelow,
                    fontSize: 14.sp,
                    color: AppColor.grey999,
                  ),

                  SizedBox(
                    height: context.height * .05,
                  ),

                  //Field forms

                  formsFieldsSection(),
                  const Spacer(),

                  //login
                  CommonAppBtn(
                    onTap: () {
                      offAllNamed(context, Routes.login);
                    },
                    title: AppString.submit,
                    textSize: 16.sp,
                  ),

                  SizedBox(
                    height: context.height * .05,
                  ),
                ],
              ),
            )),
      ),
    );
  }

//FORMS FIELDS SECTION
  Widget formsFieldsSection() {
    return Column(
      children: [
        //NEW PASSWORD
        CustomLabelTextField(
          prefixIcon: Assets.icLock,
          controller: TextEditingController(),
          labelText: AppString.newPswd,
        ),

        //CONFIRM PASSWORD
        CustomLabelTextField(
          prefixIcon: Assets.icLock,
          controller: TextEditingController(),
          labelText: AppString.confirmPswd,
        )
      ],
    );
  }
}
