import 'dart:developer';
import 'dart:io';

import 'package:NearMii/config/app_utils.dart';
import 'package:NearMii/config/assets.dart';
import 'package:NearMii/config/enums.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/core/network/http_service.dart';
import 'package:NearMii/feature/auth/presentation/provider/state_notifiers/signup_notifiers.dart';
import 'package:NearMii/feature/auth/presentation/provider/states/auth_states.dart';
import 'package:NearMii/feature/common_widgets/app_text.dart';
import 'package:NearMii/feature/common_widgets/bg_image_container.dart';
import 'package:NearMii/feature/common_widgets/choose_image_widget.dart';
import 'package:NearMii/feature/common_widgets/common_button.dart';
import 'package:NearMii/feature/common_widgets/custom_bottom_sheet.dart';
import 'package:NearMii/feature/common_widgets/custom_cache_network.dart';
import 'package:NearMii/feature/common_widgets/custom_dropdown_button.dart';
import 'package:NearMii/feature/common_widgets/custom_label_text_field.dart';
import 'package:NearMii/feature/common_widgets/custom_phone_number.dart';
import 'package:NearMii/feature/common_widgets/custom_textform_feild.dart';
import 'package:NearMii/feature/common_widgets/custom_toast.dart';
import 'package:NearMii/feature/setting/presentation/provider/edit_profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../auth/presentation/provider/states/country_code_provider.dart';

class CompleteEditProfile extends ConsumerStatefulWidget {
  const CompleteEditProfile({super.key});

  @override
  ConsumerState<CompleteEditProfile> createState() =>
      _CompleteEditProfileState();
}

class _CompleteEditProfileState extends ConsumerState<CompleteEditProfile> {
  @override
  void initState() {
    log("edit profile called");
    final editProfileNotifier = ref.read(editProfileProvider.notifier);
    final countryNotifier = ref.read(countryPickerProvider.notifier);
    editProfileNotifier.setDatainFields().then(
      (value) {
        WidgetsBinding.instance.addPostFrameCallback(
          (timeStamp) async {
            print("==========>>>>> ${editProfileNotifier.countryCode}");
            countryNotifier
                .updateInitialCountry(editProfileNotifier.countryCode);
          },
        );
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log("edit profile called52");
    final editProfileNotifier = ref.read(editProfileProvider.notifier);
    final countryNotifier = ref.read(countryPickerProvider.notifier);
    ref.watch(editProfileProvider);
    ref.watch(countryPickerProvider);

    ref.listen(
      editProfileProvider,
      (previous, next) {
        if (next is AuthApiLoading && next.authType == AuthType.editProfile) {
          Utils.showLoader();
        } else if (next is AuthApiSuccess &&
            next.authType == AuthType.editProfile) {
          Utils.hideLoader();

          // toast(msg: AppString.profileUpdateSuccess, isError: false);
          // toNamed(context, Routes.otpVerify);
          showCustomBottomSheet(
              context: context, content: updateSuccessWidget(context: context));
        } else if (next is AuthApiFailed &&
            next.authType == AuthType.editProfile) {
          Utils.hideLoader();

          toast(msg: next.error);
        }
      },
    );
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

                    AppText(
                      text: AppString.editProfileSetting,
                      fontSize: 32.sp,
                    ),

                    15.verticalSpace,
                    AppText(
                      text: "Make changes to your profile information.",
                      fontSize: 14.sp,
                      color: AppColor.grey999,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: context.height * .02),
                      child: profileSection(
                          image: editProfileNotifier.image,
                          onTap: () => showCustomBottomSheet(
                              context: context,
                              content: ChooseImageWidget(
                                onClickOnCamera: () {
                                  editProfileNotifier.pickAndCropImage(
                                      context: context,
                                      source: ImageSource.camera);
                                },
                                onClickOnGallery: () {
                                  editProfileNotifier.pickAndCropImage(
                                      context: context,
                                      source: ImageSource.gallery);
                                },
                              )),
                          editProfileNotifier: editProfileNotifier),
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
                        if (isUpdate) {
                          editProfileNotifier
                              .editProfileApi(countryNotifier.country);

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
                  "Your profile has been updated successfully. All your changes have been saved and applied to your account"),
        ),

        //Button

        CommonAppBtn(
          title: AppString.continu,
          textSize: 16.sp,
          onTap: () {
            back(context);
            back(context);
          },
        )
      ],
    );
  }

  //PROFILE SECTION

  Widget profileSection({
    required SignupNotifiers editProfileNotifier,
    XFile? image,
    required VoidCallback onTap,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 125,
          child: Stack(
            children: [
              image != null
                  ? Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(120)),
                      height: 100,
                      width: 100,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(120),
                          child: Image(
                            image: FileImage(
                              File(image.path),
                            ),
                            fit: BoxFit.cover,
                          )))
                  : Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColor.greenC5EDD9,
                      ),
                      padding: const EdgeInsets.all(5),
                      child: CustomCacheNetworkImage(
                        img: editProfileNotifier.imageUrl.isNotEmpty
                            ? ApiConstants.profileBaseUrl +
                                editProfileNotifier.imageUrl
                            : editProfileNotifier.socialImage.isNotEmpty
                                ? editProfileNotifier.socialImage
                                : '',
                        imageRadius: 120,
                        height: 100,
                        width: 100,
                      ),
                    ),
              Positioned(
                right: 0,
                bottom: 15,
                child: InkWell(
                  onTap: onTap,
                  child: SvgPicture.asset(
                    Assets.camera,
                  ),
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
          maxLength: 35,
          prefixIcon: Assets.icUser,
          controller: editProfileNotifier.fullNameController,
          labelText: AppString.fullName,
        ),
        SizedBox(
          height: context.height * 0.002,
        ),

        //DESIGNATION
        CustomLabelTextField(
          maxLength: 40,
          suffixIcon: Assets.icInfo,
          prefixIcon: Assets.icDesignation,
          controller: editProfileNotifier.designationController,
          labelText: AppString.designation,
          onTapOnSuffixIcon: () {
            showCustomBottomSheet(
                context: context,
                content: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Align(
                          alignment: Alignment.topRight,
                          child: InkWell(
                              onTap: () {
                                back(context);
                              },
                              child: SvgPicture.asset(Assets.icCloseCircle))),
                      AppText(
                        text: "Designation",
                        fontSize: 20.sp,
                      ),
                      10.verticalSpace,
                      AppText(
                          color: AppColor.grey4848,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          text:
                              "Please enter your professional designation. Your designation reflects your role, expertise, and responsibilities in your industry."),
                    ],
                  ),
                ));
          },
        ),
        SizedBox(
          height: context.height * 0.014,
        ),
        //phone number

        CustomPhoneNumber(
          selectedCountryCode: editProfileNotifier.countryCode,
          selectedCountryFlag: editProfileNotifier.countryFlag,
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
            if (editProfileNotifier.dobController.text.isNotEmpty) {
              DateTime? selectedDate =
                  formatDOBtoDateTime(editProfileNotifier.dobController.text);

              log("selected date:-. $selectedDate ,${editProfileNotifier.dobController.text}");
              final DateTime? picked = await showDatePicker(
                context: context,
                initialDate: selectedDate ?? DateTime.now(),
                firstDate: DateTime(1970, 8),
                lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
                builder: (context, child) {
                  return Theme(
                    data: ThemeData.light().copyWith(
                      primaryColor:
                          AppColor.btnColor, // Header background color
                      hintColor: AppColor.btnColor, // Accent color
                      colorScheme: const ColorScheme.light(
                          primary: AppColor.btnColor), // Active date color
                      buttonTheme: const ButtonThemeData(
                          textTheme: ButtonTextTheme.primary),
                    ),
                    child: child!,
                  );
                },
              );

              if (picked != null) {
                editProfileNotifier.dobController.text = formatDOB(picked);
                log("pciked is :-, > ${editProfileNotifier.dobController.text}");
              }
            } else {
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
                log("pciked is :-, > ${editProfileNotifier.dobController.text}");
              }
            }
          },

          prefixIcon: Assets.icCake,
          controller: editProfileNotifier.dobController,
          suffixIcon: Assets.icCalender,
          labelText: AppString.dob,
          onTapOnSuffixIcon: () async {
            if (editProfileNotifier.dobController.text.isNotEmpty) {
              DateTime? selectedDate =
                  formatDOBtoDateTime(editProfileNotifier.dobController.text);

              log("selected date:-. $selectedDate ,${editProfileNotifier.dobController.text}");
              final DateTime? picked = await showDatePicker(
                context: context,
                initialDate: selectedDate ?? DateTime.now(),
                firstDate: DateTime(1970, 8),
                lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
                builder: (context, child) {
                  return Theme(
                    data: ThemeData.light().copyWith(
                      primaryColor:
                          AppColor.btnColor, // Header background color
                      hintColor: AppColor.btnColor, // Accent color
                      colorScheme: const ColorScheme.light(
                          primary: AppColor.btnColor), // Active date color
                      buttonTheme: const ButtonThemeData(
                          textTheme: ButtonTextTheme.primary),
                    ),
                    child: child!,
                  );
                },
              );

              if (picked != null) {
                editProfileNotifier.dobController.text = formatDOB(picked);
                log("pciked is :-, > ${editProfileNotifier.dobController.text}");
              }
            } else {
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
                log("pciked is :-, > ${editProfileNotifier.dobController.text}");
              }
            }
          },

          // labelText: AppString.confirmPswd,
        ),

        //Bio

        CustomTextformFeild(
          maxLength: 60,
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
