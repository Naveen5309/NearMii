import 'package:NearMii/config/assets.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/core/utils/routing/routes.dart';
import 'package:NearMii/feature/common_widgets/app_text.dart';
import 'package:NearMii/feature/common_widgets/bg_image_container.dart';
import 'package:NearMii/feature/common_widgets/common_button.dart';
import 'package:NearMii/feature/common_widgets/custom_cache_network.dart';
import 'package:NearMii/feature/common_widgets/custom_label_text_field.dart';
import 'package:NearMii/feature/common_widgets/custom_rich_text_three_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CompleteProfileView extends StatelessWidget {
  const CompleteProfileView({super.key});

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

                    SvgPicture.asset(
                      Assets.appLogo,
                      height: 20,
                      width: 20,
                    ),

                    AppText(
                      text: AppString.completeProfile,
                      fontSize: 32.sp,
                    ),

                    15.verticalSpace,
                    AppText(
                      text: "Lorem ipsum dolor sit amet consectetur. Massa.",
                      fontSize: 14.sp,
                      color: AppColor.grey999,
                    ),

                    SizedBox(
                      height: context.height * .05,
                    ),

                    profileSection(),
                    //Field forms

                    formsFieldsSection(),

                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: context.height * .02),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Consumer(
                            builder: (context, ref, child) {
                              return
                                  // final check = ref.watch(checkPrivacy);
                                  // return GestureDetector(
                                  //   onTap: () {
                                  //     ref.read(checkPrivacy.notifier).state =
                                  //         !ref.read(checkPrivacy.notifier).state;
                                  //   },
                                  //   child:
                                  Container(
                                      height: 20,
                                      width: 20,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 1.0,
                                          color: AppColor.btnColor,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                        color: AppColor.btnColor,
                                      ),
                                      child:
                                          //  check
                                          //     ?

                                          Center(
                                        child: Icon(
                                          Icons.check_sharp,
                                          color: AppColor.primary,
                                          size: 16
                                              .sp, // Adjust icon size to fit nicely in the box.
                                        ),
                                      )
                                      // : const SizedBox()
                                      // );
                                      );
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: context.width * .02),
                            child: SizedBox(
                              width: context.width * .83,
                              child: Wrap(
                                children: [
                                  CustomRichTextThreeWidget(
                                    text: AppString.iAgreeTo,
                                    onTap: () {},
                                    onTap2: () {},
                                    clickableText: AppString.termsAndConditions,
                                    clickableText2: AppString.privacyPolicy,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    //login
                    CommonAppBtn(
                      onTap: () {
                        offAllNamed(context, Routes.login);
                      },
                      title: AppString.login,
                      textSize: 16.sp,
                    ),

                    //OR CONTINUE WITH
                  ],
                ),
              ),
            )),
      ),
    );
  }

  //PROFILE SECTION

  Widget profileSection() {
    return Row(
      children: [
        const CustomCacheNetworkImage(
          img: '',
          imageRadius: 120,
          height: 100,
          width: 100,
        ),
        15.horizontalSpace,
        AppText(
          text: AppString.uploadImage,
          color: AppColor.btnColor,
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
        )
      ],
    );
  }

//FORMS FIELDS SECTION
  Widget formsFieldsSection() {
    return Column(
      children: [
        //FULL NAME
        CustomLabelTextField(
          prefixIcon: Assets.icUser,
          controller: TextEditingController(),
          labelText: AppString.fullName,
        ),

        //DESIGNATION
        CustomLabelTextField(
          prefixIcon: Assets.icDesignation,
          controller: TextEditingController(),
          labelText: AppString.designation,
        ),

        //PHONE NUMBER
        CustomLabelTextField(
          prefixIcon: Assets.icLock,
          controller: TextEditingController(),
          labelText: AppString.phoneNumber,
        ),

        //GENDER
        CustomLabelTextField(
          prefixIcon: Assets.icGender,
          controller: TextEditingController(),
          suffixIcon: Assets.icArrowDown,
          labelText: AppString.gender,
        ),

        //DATE OF BIRTH
        CustomLabelTextField(
          prefixIcon: Assets.icCake,
          controller: TextEditingController(),
          suffixIcon: Assets.icCalender,
          labelText: AppString.dob,

          // labelText: AppString.confirmPswd,
        ),
      ],
    );
  }
}
