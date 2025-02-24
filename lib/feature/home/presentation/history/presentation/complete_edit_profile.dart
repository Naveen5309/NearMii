import 'package:NearMii/config/assets.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/feature/auth/presentation/provider/state_notifiers/signup_notifiers.dart';
import 'package:NearMii/feature/common_widgets/app_text.dart';
import 'package:NearMii/feature/common_widgets/bg_image_container.dart';
import 'package:NearMii/feature/common_widgets/common_button.dart';
import 'package:NearMii/feature/common_widgets/custom_bottom_sheet.dart';
import 'package:NearMii/feature/common_widgets/custom_cache_network.dart';
import 'package:NearMii/feature/common_widgets/custom_dropdown_button.dart';
import 'package:NearMii/feature/common_widgets/custom_label_text_field.dart';
import 'package:NearMii/feature/common_widgets/custom_phone_number.dart';
import 'package:NearMii/feature/common_widgets/custom_textform_feild.dart';
import 'package:NearMii/feature/setting/presentation/provider/edit_profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CompleteEditProfile extends ConsumerWidget {
  const CompleteEditProfile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editProfileNotifier = ref.watch(editProfileProvider.notifier);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: AppColor.primary,
        body: BgImageContainer(
            bgImage: Assets.authBg,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: context.width * .05,
                  vertical: context.width * .05),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: totalHeight * 0.6,
                    ),
                    GestureDetector(
                        onTap: () => back(context),
                        child: SvgPicture.asset(Assets.leftArrow)),
                    SizedBox(
                      height: 18.h,
                    ),
                    //Logo

                    // const Text("APPlOGO"),

                    AppText(
                      text: AppString.editProfileSetting,
                      fontSize: 32.sp,
                    ),

                    15.verticalSpace,
                    AppText(
                      text: "Lorem ipsum dolor sit amet consectetur. Massa.",
                      fontSize: 14.sp,
                      color: AppColor.grey999,
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: context.height * .02),
                      child: profileSection(),
                    ),

                    //Field forms

                    formsFieldsSection(
                        context: context,
                        editProfileNotifier: editProfileNotifier),
                    SizedBox(
                      height: context.height * .04,
                    ),
                    //login
                    CommonAppBtn(
                      onTap: () {
                        final isUpdate =
                            editProfileNotifier.validateEditProfile();
                        print(isUpdate);
                        if (isUpdate) {
                          showCustomBottomSheet(
                              context: context,
                              content: updateSuccessWidget(context: context));
                          // }
                        }
                      },
                      title: AppString.update,
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

  //Update succcess bottom sheet CONTENT

  Widget updateSuccessWidget({required BuildContext context}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(Assets.bottomNav),
        //logo
        Padding(
          padding: EdgeInsets.symmetric(vertical: context.height * .05),
          child: SvgPicture.asset(Assets.icSuccess),
        ),

        //profile update success

        AppText(
          text: AppString.profileUpdateSuccess,
          fontSize: 20.sp,
          fontWeight: FontWeight.w500,
        ),

        Padding(
          padding: EdgeInsets.symmetric(vertical: context.height * .02),
          child: AppText(
              textAlign: TextAlign.center,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: AppColor.grey999,
              text:
                  "Lorem ipsum dolor sit amet consectetur. Semper\nvel interdum et posuere venenatis."),
        ),

        //Button

        CommonAppBtn(
          title: AppString.continu,
          textSize: 16.sp,
          onTap: () {
            back(context);
          },
        )
      ],
    );
  }

  //PROFILE SECTION

  Widget profileSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 125,
          child: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColor.greenC5EDD9,
                ),
                padding: const EdgeInsets.all(5),
                child: const CustomCacheNetworkImage(
                  img: '', imageRadius: 120, height: 100, width: 100,
                  // CircleAvatar(
                  //   radius: 30.r,
                  //   backgroundImage: NetworkImage(imageUrl),
                  // ),
                ),
              ),
              Positioned(
                right: 0,
                bottom: 15,
                child: SvgPicture.asset(
                  Assets.camera,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

//FORMS FIELDS SECTION
  Widget formsFieldsSection(
      {required BuildContext context,
      required SignupNotifiers editProfileNotifier}) {
    return Column(
      children: [
        //FULL NAME
        CustomLabelTextField(
          prefixIcon: Assets.icUser,
          controller: editProfileNotifier.fullNameController,
          labelText: AppString.fullName,
        ),
        SizedBox(
          height: context.height * 0.002,
        ),

        //DESIGNATION
        CustomLabelTextField(
          prefixIcon: Assets.icDesignation,
          controller: editProfileNotifier.designationController,
          labelText: AppString.designation,
        ),
        SizedBox(
          height: context.height * 0.014,
        ),
        //phone number

        CustomPhoneNumber(
          prefixIcon: Assets.icGender,
          controller: editProfileNotifier.phoneController,
          labelText: AppString.phoneNumber,
        ),
        SizedBox(
          height: context.height * 0.018,
        ),

        CustomDropdownButton(
          customBtn: IgnorePointer(
            child: CustomLabelTextField(
              prefixIcon: Assets.icGender,
              controller: editProfileNotifier.genderController,
              suffixIcon: Assets.icArrowDown,
              labelText: AppString.gender,
              readOnly: true,
            ),
          ),
          hint: "Gender",
          value: editProfileNotifier.genderController.text.isEmpty
              ? "Male"
              : editProfileNotifier.genderController.text,
          dropdownItems: genderList,
          onChanged: (value) {
            editProfileNotifier.genderController.text = value!;
          },
        ),
        SizedBox(
          height: context.height * 0.005,
        ),

        //DATE OF BIRTH
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
              editProfileNotifier.dobController.text = formatDOB(picked);
            }
          },

          prefixIcon: Assets.icCake,
          controller: editProfileNotifier.dobController,
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
              editProfileNotifier.dobController.text = formatDOB(picked);
            }
          },

          // labelText: AppString.confirmPswd,
        ),

        //Bio

        CustomTextformFeild(
          radius: 19,
          prefixIcon: Assets.icCheck,
          controller: editProfileNotifier.bioController,
          labelText: AppString.bio,
          maxLines: 5,
        ),
      ],
    );
  }
}
