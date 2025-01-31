import 'package:NearMii/config/assets.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/core/utils/routing/routes.dart';
import 'package:NearMii/feature/common_widgets/app_text.dart';
import 'package:NearMii/feature/common_widgets/bg_image_container.dart';
import 'package:NearMii/feature/common_widgets/common_back_btn.dart';
import 'package:NearMii/feature/common_widgets/common_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SelectSocialMediaView extends StatelessWidget {
  const SelectSocialMediaView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BgImageContainer(
          bgImage: Assets.loginBg,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: context.width * .05),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: totalHeight,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CommonBackBtn(),
                      AppText(
                        text: AppString.skip,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      )
                    ],
                  ),

                  SizedBox(
                    height: context.height * .05,
                  ),
                  //Logo

                  // const Text("APPlOGO"),

                  AppText(
                    text: AppString.addSocialProfiles,
                    fontSize: 32.sp,
                  ),

                  15.verticalSpace,
                  AppText(
                    text: "Lorem ipsum dolor sit amet consectetur. Massa.",
                    fontSize: 14.sp,
                    color: AppColor.grey999,
                  ),

                  //Field forms

                  //login
                  CommonAppBtn(
                    onTap: () {
                      offAllNamed(context, Routes.login);
                    },
                    title: AppString.next,
                    textSize: 16.sp,
                  ),

                  SizedBox(
                    height: context.height * .05,
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
