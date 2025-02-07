import 'package:NearMii/config/assets.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/core/utils/routing/routes.dart';
import 'package:NearMii/feature/common_widgets/app_text.dart';
import 'package:NearMii/feature/common_widgets/bg_image_container.dart';
import 'package:NearMii/feature/common_widgets/common_button.dart';
import 'package:NearMii/feature/common_widgets/custom_label_text_field.dart';
import 'package:NearMii/feature/common_widgets/custom_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
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
                    //Logo

                    // const Text("APPlOGO"),

                    Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: SvgPicture.asset(
                        Assets.icDummyLogo,
                        // height: 100,
                        // width: 100,
                      ),
                    ),

                    AppText(
                      text: AppString.signInToYourAccount,
                      fontSize: 32.sp,
                      // style: AppTextStyle.regular,
                    ),

                    15.verticalSpace,
                    AppText(
                      text: AppString.letSignInToYourAccount,
                      fontSize: 14.sp,
                      color: AppColor.grey999,
                    ),

                    SizedBox(
                      height: context.height * .05,
                    ),

                    //FORMS FIELDS

                    formsFieldsSection(),

                    //FORGOT PASSWORD

                    InkWell(
                      onTap: () {
                        toNamed(context, Routes.forgetPassword);
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: context.height * .02,
                            bottom: context.height * .04),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: AppText(
                            text: AppString.forgotPswd,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),

                    //login
                    CommonAppBtn(
                      onTap: () {
                        offAllNamed(context, Routes.bottomNavBar);
                      },
                      title: AppString.login,
                      textSize: 16.sp,
                    ),

                    //or

                    orContinueWith(context: context),

                    //social media section
                    socialMediaSection(),
                    SizedBox(
                      height: context.height * .05,
                    ),

                    //DON'T HAVE AN ACCOUNT
                    Align(
                      alignment: Alignment.center,
                      child: CustomRichText(
                        onTap: () {
                          toNamed(context, Routes.signUp);
                        },
                        text: AppString.dontHaveAnAccount,
                        clickableText: AppString.signUp,
                      ),
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }

  Widget formsFieldsSection() {
    return Column(
      children: [
        //EMAIL ADDRESS
        CustomLabelTextField(
          prefixIcon: Assets.icUser,
          controller: TextEditingController(),
          labelText: AppString.emailAddress,
        ),

        //PASSWORD
        CustomLabelTextField(
          prefixIcon: Assets.icLock,
          controller: TextEditingController(),
          labelText: AppString.pswd,
          suffixIcon: Assets.icEye,
        )
      ],
    );
  }
}

//SOCIAL MEDIA SECTION

Widget socialMediaSection() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      SvgPicture.asset(Assets.icFbSingle),
      SvgPicture.asset(Assets.google),
      SvgPicture.asset(Assets.apple),
    ],
  );
}

//OR CONTINUE WITH

Widget orContinueWith({required BuildContext context}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: context.height * .05),
    child: Row(
      children: [
        Expanded(
          child: customDividerContainer(gradientColor: [
            AppColor.black000000.withOpacity(.01),
            AppColor.black000000.withOpacity(.2),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: AppText(
            text: AppString.orContinueWiths,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: AppColor.black000000.withOpacity(.6),
          ),
        ),
        Expanded(
          child: customDividerContainer(gradientColor: [
            AppColor.black000000.withOpacity(.2),
            AppColor.black000000.withOpacity(.01),
          ]),
        ),
      ],
    ),
  );
}

//CUSTOM DIVIDER CONTAINER
Widget customDividerContainer({required List<Color> gradientColor}) {
  return Container(
    height: 1.5,
    decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: gradientColor)),
  );
}
