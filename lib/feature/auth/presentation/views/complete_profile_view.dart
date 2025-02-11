import 'package:NearMii/config/assets.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/core/utils/routing/routes.dart';
import 'package:NearMii/feature/auth/presentation/provider/signup_provider.dart';
import 'package:NearMii/feature/auth/presentation/provider/state_notifiers/signup_notifiers.dart';
import 'package:NearMii/feature/common_widgets/app_text.dart';
import 'package:NearMii/feature/common_widgets/bg_image_container.dart';
import 'package:NearMii/feature/common_widgets/common_button.dart';
import 'package:NearMii/feature/common_widgets/custom_cache_network.dart';
import 'package:NearMii/feature/common_widgets/custom_dropdown_button.dart';
import 'package:NearMii/feature/common_widgets/custom_label_text_field.dart';
import 'package:NearMii/feature/common_widgets/custom_phone_number.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CompleteProfileView extends ConsumerWidget {
  const CompleteProfileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final createProfileNotifier = ref.watch(signupProvider.notifier);

    final signupPro = ref.watch(signupProvider.notifier);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: BgImageContainer(
            bgImage: Assets.authBg,
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
                      text: AppString.completeProfile,
                      fontSize: 32.sp,
                    ),

                    15.verticalSpace,
                    AppText(
                      text: "Lorem ipsum dolor sit amet consectetur. Massa.",
                      fontSize: 14.sp,
                      color: AppColor.grey999,
                    ),

                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: context.height * .04),
                      child: profileSection(),
                    ),

                    //Field forms

                    formsFieldsSection(
                        context: context, createProfileNotifier: signupPro),
                    SizedBox(
                      height: context.height * .01,
                    ),
                    //login
                    CommonAppBtn(
                      onTap: () {
                        final isComplete =
                            createProfileNotifier.validateProfile();
                        print(isComplete);
                        if (isComplete) {
                          toNamed(context, Routes.selectSocialMedia);
                        }
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
  Widget formsFieldsSection(
      {required BuildContext context,
      required SignupNotifiers createProfileNotifier}) {
    return Column(
      children: [
        //FULL NAME
        CustomLabelTextField(
          prefixIcon: Assets.icUser,
          controller: createProfileNotifier.fullNameController,
          labelText: AppString.fullName,
        ),

        //DESIGNATION
        CustomLabelTextField(
          prefixIcon: Assets.icDesignation,
          controller: createProfileNotifier.designationController,
          labelText: AppString.designation,
        ),
        //Bio
        CustomLabelTextField(
          prefixIcon: Assets.icCheck,
          controller: createProfileNotifier.bioController,
          labelText: AppString.bio,
        ),

        //phone number

        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: CustomPhoneNumber(
            prefixIcon: Assets.icGender,
            controller: createProfileNotifier.phoneController,
            labelText: AppString.phoneNumber,
          ),
        ),

//GENDER
        CustomDropdownButton(
          customBtn: IgnorePointer(
            child: CustomLabelTextField(
              prefixIcon: Assets.icGender,
              controller: createProfileNotifier.genderController,
              suffixIcon: Assets.icArrowDown,
              labelText: AppString.gender,
              readOnly: true,
            ),
          ),
          hint: "Gender",
          value: createProfileNotifier.genderController.text.isEmpty
              ? "Male"
              : createProfileNotifier.genderController.text,
          dropdownItems: genderList,
          onChanged: (value) {
            createProfileNotifier.genderController.text = value!;
          },
        ),

        //--->> DATE OF BIRTH
        CustomLabelTextField(
          readOnly: true,
          onTap: () async {
            final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1970, 8),
              lastDate: DateTime.now(),
              builder: (context, child) {
                return Theme(
                  data: ThemeData.light().copyWith(
                    primaryColor: Colors.green, // Header background color
                    hintColor: Colors.green, // Accent color
                    colorScheme: const ColorScheme.light(
                        primary: Colors.green), // Active date color
                    buttonTheme: const ButtonThemeData(
                        textTheme: ButtonTextTheme.primary),
                  ),
                  child: child!,
                );
              },
            );

            if (picked != null) {
              createProfileNotifier.dobController.text = formatDOB(picked);
            }
          },

          prefixIcon: Assets.icCake,
          controller: createProfileNotifier.dobController,
          suffixIcon: Assets.icCalender,
          labelText: AppString.dob,
          onTapOnSuffixIcon: () async {
            final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1970, 8),
              lastDate: DateTime.now(),
              builder: (context, child) {
                return Theme(
                  data: ThemeData.light().copyWith(
                    primaryColor: Colors.green, // Header background color
                    hintColor: Colors.green, // Accent color
                    colorScheme: const ColorScheme.light(
                        primary: Colors.green), // Active date color
                    buttonTheme: const ButtonThemeData(
                        textTheme: ButtonTextTheme.primary),
                  ),
                  child: child!,
                );
              },
            );

            if (picked != null) {
              createProfileNotifier.dobController.text = formatDOB(picked);
            }
          },

          // labelText: AppString.confirmPswd,
        ),

        //REFERREL CODE
        CustomLabelTextField(
          prefixIcon: Assets.icReferrelCode,
          controller: (createProfileNotifier.referralController),
          labelText: AppString.enterReferralCode,
        ),
      ],
    );
  }
}
