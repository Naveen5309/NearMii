import 'dart:io';
import 'package:NearMii/config/app_utils.dart';
import 'package:NearMii/config/assets.dart';
import 'package:NearMii/config/enums.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/core/utils/routing/routes.dart';
import 'package:NearMii/feature/auth/data/models/social_profile_model.dart';
import 'package:NearMii/feature/auth/presentation/provider/signup_provider.dart';
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
import 'package:NearMii/feature/common_widgets/exit_app_confirmation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

import '../provider/states/country_code_provider.dart';

class CompleteProfileView extends ConsumerStatefulWidget {
  final SocialProfileModel? profileData;
  const CompleteProfileView({super.key, this.profileData});

  @override
  ConsumerState<CompleteProfileView> createState() =>
      _CompleteProfileViewState();
}

class _CompleteProfileViewState extends ConsumerState<CompleteProfileView> {
  @override
  void initState() {
    printLog("update social data called:> ${widget.profileData?.name} ");
    if (widget.profileData != null) {
      final createProfileNotifier = ref.read(signupProvider.notifier);

      createProfileNotifier.updateSocialData(
        img: widget.profileData?.img ?? '',
        name: widget.profileData?.name ?? '',
        email: widget.profileData?.email ?? '',
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final createProfileNotifier = ref.read(signupProvider.notifier);

    ref.watch(signupProvider);
    ref.watch(countryPickerProvider);

    ref.listen(
      signupProvider,
      (previous, next) {
        if (next is AuthApiLoading &&
            next.authType == AuthType.completeProfile) {
          Utils.showLoader();
        } else if (next is AuthApiSuccess &&
            next.authType == AuthType.completeProfile) {
          Utils.hideLoader();

          // back(context);
          toNamed(context, Routes.selectSocialMedia, args: false);
        } else if (next is AuthApiFailed &&
            next.authType == AuthType.completeProfile) {
          Utils.hideLoader();

          toast(msg: next.error);
        }
      },
    );

    ref.watch(signupProvider);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) async {
          if (!didPop) {
            bool shouldExit = await showExitConfirmationDialog(context);
            if (shouldExit) {
              if (context.mounted) {
                back(context); // Exit if user confirms
              }
            }
          }
        },
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

                      Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: SvgPicture.asset(
                            Assets.icDummyLogo,

                            height: 50,
                            // width: 100,
                          ),
                        ),
                      ),

                      AppText(
                        text: AppString.completeProfile,
                        fontSize: 32.sp,
                      ),

                      10.verticalSpace,
                      AppText(
                        text:
                            "Complete Your Profile to Unlock Full Access and Personalized Experience.",
                        fontSize: 14.sp,
                        color: AppColor.grey999,
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: context.height * .04),
                        child: profileSection(
                          imgUrl: widget.profileData?.img ?? '',
                          image: createProfileNotifier.image,
                          onTap: () => showCustomBottomSheet(
                              context: context,
                              content: ChooseImageWidget(
                                onClickOnCamera: () {
                                  createProfileNotifier.pickAndCropImage(
                                      context: context,
                                      source: ImageSource.camera);
                                },
                                onClickOnGallery: () {
                                  createProfileNotifier.pickAndCropImage(
                                      context: context,
                                      source: ImageSource.gallery);
                                },
                              )),
                        ),
                      ),

                      //Field forms

                      formsFieldsSection(
                          context: context,
                          createProfileNotifier: createProfileNotifier),
                      SizedBox(
                        height: context.height * .01,
                      ),
                      //login
                      CommonAppBtn(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          final isComplete =
                              createProfileNotifier.validateProfile();
                          if (isComplete) {
                            createProfileNotifier.completeProfileApi();
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
      ),
    );
  }

  //PROFILE SECTION

  Widget profileSection(
      {required VoidCallback onTap, XFile? image, String? imgUrl, d}) {
    return Row(
      children: [
        image != null
            ? Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(120)),
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
            : CustomCacheNetworkImage(
                img: imgUrl ?? '',
                imageRadius: 120,
                height: 100,
                width: 100,
              ),
        15.horizontalSpace,
        InkWell(
          onTap: onTap,
          child: AppText(
            text: AppString.uploadImage,
            color: AppColor.btnColor,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
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
          maxLength: 35,
          prefixIcon: Assets.icUser,
          controller: createProfileNotifier.fullNameController,
          labelText: AppString.fullName,
        ),

        //DESIGNATION
        CustomLabelTextField(
          maxLength: 30,
          suffixIcon: Assets.icInfo,
          prefixIcon: Assets.icDesignation,
          controller: createProfileNotifier.designationController,
          labelText: "${AppString.designation} (optional)",
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
                        text: "Designation ",
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

        // CustomLabelTextField(

        //   prefixIcon: Assets.icCheck,
        //   controller: createProfileNotifier.bioController,
        //   labelText: AppString.bio,
        // ),

        //phone number

        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: CustomPhoneNumber(
            maxLength: createProfileNotifier.maxLength,
            minLength: createProfileNotifier.minLength,
            selectedCountryCode: createProfileNotifier.countryCode,
            selectedCountryFlag: createProfileNotifier.countryFlag,
            // onCountryCodeChanged: (code, flag) {
            //   createProfileNotifier.countryCode = code;
            // },
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

        //Bio

        CustomTextformFeild(
          maxLength: 80,
          radius: 19,
          prefixIcon: Assets.icCheck,
          controller: createProfileNotifier.bioController,
          labelText: "${AppString.bio} (optional)",
          maxLines: 5,
        ),

        //REFERREL CODE
        CustomLabelTextField(
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
                        text: "Referral code",
                        fontSize: 20.sp,
                      ),
                      10.verticalSpace,
                      AppText(
                          color: AppColor.grey4848,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          text:
                              "Please enter your referral code. Your referral code helps us identify who referred you and unlock any special rewards or benefits."),
                    ],
                  ),
                ));
          },
          suffixIcon: Assets.icInfo,
          prefixIcon: Assets.icReferrelCode,
          controller: (createProfileNotifier.referralController),
          labelText: AppString.enterReferralCode,
        ),
      ],
    );
  }
}
