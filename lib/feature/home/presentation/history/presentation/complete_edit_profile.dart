import 'package:NearMii/config/assets.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/core/utils/routing/routes.dart';
import 'package:NearMii/feature/common_widgets/app_text.dart';
import 'package:NearMii/feature/common_widgets/bg_image_container.dart';
import 'package:NearMii/feature/common_widgets/common_button.dart';
import 'package:NearMii/feature/common_widgets/custom_cache_network.dart';
import 'package:NearMii/feature/common_widgets/custom_dropdown_button.dart';
import 'package:NearMii/feature/common_widgets/custom_label_text_field.dart';
import 'package:NearMii/feature/common_widgets/custom_phone_number.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CompleteEditProfile extends StatelessWidget {
  const CompleteEditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: AppColor.primary,
        body: BgImageContainer(
            bgImage: Assets.authBg,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: context.width * .05),
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
                      padding:
                          EdgeInsets.symmetric(vertical: context.height * .04),
                      child: profileSection(),
                    ),

                    //Field forms

                    formsFieldsSection(context: context),
                    SizedBox(
                      height: context.height * .04,
                    ),
                    //login
                    CommonAppBtn(
                      onTap: () {
                        toNamed(context, Routes.selectSocialMedia);
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
                decoration: BoxDecoration(
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
  Widget formsFieldsSection({required BuildContext context}) {
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
        //Bio
        CustomLabelTextField(
          prefixIcon: Assets.icCheck,
          controller: TextEditingController(),
          labelText: AppString.bio,
        ),

        //phone number

        CustomPhoneNumber(
          prefixIcon: Assets.icGender,
          controller: TextEditingController(),
          labelText: AppString.phoneNumber,
        ),

        // DropdownButtonFormField2<String>(
        //   isExpanded: true,
        //   decoration: InputDecoration(
        //     contentPadding: const EdgeInsets.symmetric(vertical: 16),
        //     border: OutlineInputBorder(
        //       borderRadius: BorderRadius.circular(100),
        //     ),
        //     // Add more decoration..
        //   ),
        //   hint: const Text(
        //     'Gender',
        //     style: TextStyle(fontSize: 14),
        //   ),
        //   items: genderList
        //       .map((item) => DropdownMenuItem<String>(
        //             value: item,
        //             child: Text(
        //               item,
        //               style: TextStyle(
        //                 fontSize: 14.sp,
        //               ),
        //             ),
        //           ))
        //       .toList(),
        //   validator: (value) {
        //     if (value == null) {
        //       return 'Please select gender.';
        //     }
        //     return null;
        //   },
        //   onChanged: (value) {
        //     //Do something when selected item is changed.
        //   },
        //   onSaved: (value) {
        //     // selectedValue = value.toString();
        //   },
        //   buttonStyleData: const ButtonStyleData(
        //     padding: EdgeInsets.only(right: 8),
        //   ),
        //   iconStyleData: const IconStyleData(
        //     icon: Icon(
        //       Icons.arrow_drop_down,
        //       color: Colors.black45,
        //     ),
        //     iconSize: 24,
        //   ),
        //   dropdownStyleData: DropdownStyleData(
        //     decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(15),
        //     ),
        //   ),
        //   menuItemStyleData: const MenuItemStyleData(
        //     padding: EdgeInsets.symmetric(horizontal: 16),
        //   ),
        // ),

        // //PHONE NUMBER
        // CustomDropdownButton(
        //   buttonWidth: context.width,
        //   // dropdownDecoration:
        //   //     BoxDecoration(borderRadius: BorderRadius.circular(100)),
        //   dropdownItems: const ["one", "two"],
        //   hint: "Gender",
        //   onChanged: (val) {},
        //   value: "one",
        //   icon: SvgPicture.asset(Assets.icArrowDown),
        // ),
        // const CustomPhoneNumberField(),

        // CustomLabelTextField(
        //   prefixIcon: Assets.icLock,
        //   controller: TextEditingController(),
        //   labelText: AppString.phoneNumber,
        // ),

        CustomDropdownButton(
          customBtn: IgnorePointer(
            child: CustomLabelTextField(
              prefixIcon: Assets.icGender,
              controller: TextEditingController(),
              suffixIcon: Assets.icArrowDown,
              labelText: AppString.gender,
              readOnly: true,
            ),
          ),
          hint: "Gender",
          value: "Male",
          dropdownItems: genderList,
          onChanged: (value) {},
        ),
        //GENDER
        // Stack(
        //   children: [
        //     CustomLabelTextField(
        //       prefixIcon: Assets.icGender,
        //       controller: TextEditingController(),
        //       suffixIcon: Assets.icArrowDown,
        //       labelText: AppString.gender,
        //       readOnly: true,
        //       onTapOnSuffixIcon: () {
        //         // log("on click on gender suffix icon");

        //         // showMenu(
        //         //   context: context,
        //         //   position: const RelativeRect.fromLTRB(
        //         //       100, 400, 100, 0), // Adjust position
        //         //   items: genderList.map((String gender) {
        //         //     return PopupMenuItem<String>(
        //         //       value: gender,
        //         //       child: Text(gender),
        //         //     );
        //         //   }).toList(),
        //         // ).then((value) {
        //         //   if (value != null) {
        //         //     // setState(() {
        //         //     //   selectedGender = value;
        //         //     // });
        //         //   }
        //         // });
        //       },
        //     ),
        //     // Positioned(
        //     //   top: 0,
        //     //   child: Container(
        //     //     decoration: const BoxDecoration(color: Colors.red),
        //     //     child: Column(
        //     //       children: genderList.map((String gender) {
        //     //         return PopupMenuItem<String>(
        //     //           value: gender,
        //     //           child: Text(gender),
        //     //         );
        //     //       }).toList(),
        //     //     ),
        //     //   ),
        //     // )
        //   ],
        // ),

        //DATE OF BIRTH
        CustomLabelTextField(
          readOnly: true,

          prefixIcon: Assets.icCake,
          controller: TextEditingController(),
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
            // if (picked != null && picked != selectedDate) {
            //   // setState(() {
            //   //   selectedDate = picked;
            //   // });
            // }
          },

          // labelText: AppString.confirmPswd,
        ),
      ],
    );
  }
}
