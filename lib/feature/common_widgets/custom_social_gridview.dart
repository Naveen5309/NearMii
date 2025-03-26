import 'package:NearMii/config/app_utils.dart';
import 'package:NearMii/config/assets.dart';
import 'package:NearMii/config/enums.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/core/network/http_service.dart';
import 'package:NearMii/feature/auth/data/models/get_platform_model.dart';
import 'package:NearMii/feature/auth/data/models/social_profile_response_model.dart';
import 'package:NearMii/feature/auth/presentation/provider/signup_provider.dart';
import 'package:NearMii/feature/auth/presentation/provider/state_notifiers/signup_notifiers.dart';
import 'package:NearMii/feature/auth/presentation/provider/states/auth_states.dart';
import 'package:NearMii/feature/auth/presentation/provider/states/country_code_provider.dart';
import 'package:NearMii/feature/common_widgets/app_text.dart';
import 'package:NearMii/feature/common_widgets/common_button.dart';
import 'package:NearMii/feature/common_widgets/custom_bottom_sheet.dart';
import 'package:NearMii/feature/common_widgets/custom_cache_network.dart';
import 'package:NearMii/feature/common_widgets/custom_label_text_field.dart';
import 'package:NearMii/feature/common_widgets/custom_phone_number.dart';
import 'package:NearMii/feature/common_widgets/custom_toast.dart';
import 'package:NearMii/feature/common_widgets/social_media_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomSocialGridview extends ConsumerWidget {
  final String title;
  final List<PlatformData> socialMedia;
  final SignupNotifiers notifier;

  const CustomSocialGridview({
    super.key,
    required this.title,
    required this.socialMedia,
    required this.notifier,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(signupProvider);
    final notifier = ref.watch(signupProvider.notifier);
    final countryNotifier = ref.read(countryPickerProvider.notifier);
    ref.listen(
      signupProvider,
      (previous, next) {
        if (next is AuthApiLoading && next.authType == AuthType.addPlatform) {
          Utils.showLoader();
        } else if (next is AuthApiSuccess &&
            next.authType == AuthType.addPlatform) {
          Utils.hideLoader();

          toast(msg: AppString.platformUpdateSuccess, isError: false);

          printLog("Platform added succesfully");
        } else if (next is AuthApiFailed &&
            next.authType == AuthType.addPlatform) {
          Utils.hideLoader();

          toast(msg: next.error);
        }
      },
    );

    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: AppColor.primary,
        borderRadius: BorderRadius.circular(12), // Smooth rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03), // Adjust opacity as needed
            blurRadius: 2,
            spreadRadius: 0, // No spreading to the sides
            offset: const Offset(0, 5), // Move shadow downwards
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: context.height * .02, horizontal: context.width * .06),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //TITLE

            AppText(
              text: title,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
            //SOCIAL MEDIA

            Container(
                padding: EdgeInsets.only(top: context.height * .025),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                  ),
                ),
                // margin: const EdgeInsets.all(10.0),
                child: GridView.builder(
                  padding: EdgeInsets.zero,
                  // physics: const NeverScrollableScrollPhysics(),

                  itemCount: socialMedia.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, pIndex) {
                    return GestureDetector(
                        onTap: () {
                          var matchedItem = notifier.addSocialList.firstWhere(
                            (item) => item.platformId == socialMedia[pIndex].id,
                            orElse: () => AddSocialProfileModel(
                                platformId: -1,
                                url: '',
                                type: ''), // Provide a default object
                          );

                          if (matchedItem.platformId != -1) {
                            printLog("Matched Item: ${matchedItem.toJson()}");
                            printLog("Matched Item: ${matchedItem.type}");

                            notifier.urlController.text = matchedItem.url ?? '';
                            // if (socialMedia[pIndex].platform?.type ==
                            //     "Enter phone number") {
                            //   notifier.updateUserPhone(
                            //       phoneNumber: socialMedia[pIndex].url ?? '');

                            //   countryNotifier.updateInitialCountry(
                            //       socialMedia[pIndex].url?.split(' ').first ??
                            //           '+1');

                            if (matchedItem.type == 'Enter phone number') {
                              printLog("Its phone number");
                              notifier.updateUserPhone();

                              countryNotifier.updateInitialCountry(
                                  matchedItem.url?.split(' ').first ?? '+1');
                              showCustomBottomSheet(
                                context: context,
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        AppText(
                                          text: socialMedia[pIndex].name ?? '',
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        InkWell(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            onTap: () {
                                              back(context);
                                            },
                                            child: SvgPicture.asset(
                                                Assets.icCloseCircle))
                                      ],
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10.0),
                                      child: Divider(),
                                    ),
                                    // 10.verticalSpace,

                                    CustomPhoneNumber(
                                      minLength: notifier.minLength,
                                      maxLength: notifier.maxLength,
                                      selectedCountryCode: notifier.countryCode,
                                      selectedCountryFlag: notifier.countryFlag,
                                      prefixIcon: Assets.icGender,
                                      controller: notifier.urlController,
                                      labelText: AppString.phoneNumber,
                                    ),
                                    10.verticalSpace,

                                    /**--------------------- CANCEL AND UPDATE  ---------------- **/
                                    Padding(
                                      padding: EdgeInsets.only(
                                          bottom: context.height * .02),
                                      child: Row(
                                        children: [
                                          //GO BACK
                                          Expanded(
                                            child: CommonAppBtn(
                                              textColor: AppColor.btnColor,
                                              backGroundColor: AppColor
                                                  .green00C56524
                                                  .withOpacity(.14),
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              title: AppString.cancel,
                                              width: context.width,
                                            ),
                                          ),
                                          10.horizontalSpace,

                                          //ADD/SAVE PLATFORM
                                          Expanded(
                                            child: CommonAppBtn(
                                              onTap: () {
                                                var isValid = notifier
                                                    .validateAddPlatform();

                                                if (isValid) {
                                                  printLog(
                                                      "update phone :-> ${"${notifier.countryCode} ${notifier.urlController.text}"}");

                                                  // Find index of existing item with the same platformId
                                                  int existingIndex = notifier
                                                      .addSocialList
                                                      .indexWhere(
                                                    (item) =>
                                                        item.platformId ==
                                                        socialMedia[pIndex].id,
                                                  );

                                                  if (existingIndex != -1) {
                                                    // ✅ Update the existing item
                                                    notifier.addSocialList[
                                                            existingIndex] =
                                                        AddSocialProfileModel(
                                                      platformId:
                                                          socialMedia[pIndex]
                                                              .id,
                                                      url:
                                                          "${notifier.countryCode} ${notifier.urlController.text}", // Updated URL

                                                      type: socialMedia[pIndex]
                                                              .type ??
                                                          '',
                                                    );
                                                    printLog(
                                                        "✅ Updated existing item: ${notifier.addSocialList[existingIndex].toJson()}");
                                                    back(context);
                                                  } else {
                                                    // 🚀 Add new item if it doesn't exist
                                                    notifier.addSocialList.add(
                                                      AddSocialProfileModel(
                                                        platformId:
                                                            socialMedia[pIndex]
                                                                .id,
                                                        url:
                                                            "${notifier.countryCode} ${notifier.urlController.text}", // Updated URL

                                                        type:
                                                            socialMedia[pIndex]
                                                                    .type ??
                                                                '',
                                                      ),
                                                    );
                                                    print(
                                                        "➕ Added new item: ${notifier.addSocialList.last.toJson()}");
                                                    back(context);
                                                  }

                                                  // If it doesn't exist, add a new item
//                                                   notifier.addSocialList.add(
//                                                     AddSocialProfileModel(
//                                                       platformId:
//                                                           socialMedia[pIndex]
//                                                               .id,
//                                                       url: notifier
//                                                           .urlController.text,
//                                                       type: socialMedia[pIndex]
//                                                               .type ??
//                                                           '',
//                                                     ),
//                                                   );
//                                                 }
// // Ensure uniqueness if needed
//                                                 notifier.addSocialList =
//                                                     notifier.addSocialList
//                                                         .toSet()
//                                                         .toList();

                                                  // printLog(
                                                  //     "update phone data is :-> ${notifier.addSocialList[0].url}");

                                                  // notifier.addPlatform(
                                                  //     isPhone: true,
                                                  //     platformId:
                                                  //         socialMedia[pIndex]
                                                  //             .id
                                                  //             .toString());
                                                }
                                              },
                                              title: AppString.update,
                                              width: context.width,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    10.verticalSpace,
                                  ],
                                ),
                              );
                            } else {
                              printLog("Item matched but no phone number");
                              showCustomBottomSheet(
                                context: context,
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        AppText(
                                          text: socialMedia[pIndex].name ?? '',
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        InkWell(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            onTap: () {
                                              back(context);
                                            },
                                            child: SvgPicture.asset(
                                                Assets.icCloseCircle))
                                      ],
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10.0),
                                      child: Divider(),
                                    ),
                                    // 10.verticalSpace,
                                    CustomLabelTextField(
                                      labelBckColor: AppColor.primary,
                                      labelText: "${socialMedia[pIndex].type}",
                                      controller: notifier.urlController,
                                      prefixWidget: CustomCacheNetworkImage(
                                          img: ApiConstants.socialIconBaseUrl +
                                              socialMedia[pIndex].icon!,
                                          width: 25,
                                          height: 25,
                                          imageRadius: 10),
                                    ),

                                    /**--------------------- CANCEL AND SAVE  ---------------- **/
                                    Padding(
                                      padding: EdgeInsets.only(
                                          bottom: context.height * .02),
                                      child: Row(
                                        children: [
                                          //GO BACK
                                          Expanded(
                                            child: CommonAppBtn(
                                              textColor: AppColor.btnColor,
                                              backGroundColor: AppColor
                                                  .green00C56524
                                                  .withOpacity(.14),
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              title: AppString.cancel,
                                              width: context.width,
                                            ),
                                          ),
                                          10.horizontalSpace,

                                          //UPDATE PLATFORM
                                          Expanded(
                                            child: CommonAppBtn(
                                              onTap: () {
                                                var isValid = notifier
                                                    .validateAddPlatform();

                                                int index = notifier
                                                    .addSocialList
                                                    .indexWhere((item) =>
                                                        item.platformId ==
                                                        socialMedia[pIndex].id);

                                                if (index != -1) {
                                                  // If the item exists, update its URL
                                                  notifier.addSocialList[index]
                                                          .url =
                                                      notifier
                                                          .urlController.text;
                                                } else {
                                                  // If it doesn't exist, add a new item
                                                  notifier.addSocialList.add(
                                                    AddSocialProfileModel(
                                                      platformId:
                                                          socialMedia[pIndex]
                                                              .id,
                                                      url: notifier
                                                          .urlController.text,
                                                      type: socialMedia[pIndex]
                                                              .type ??
                                                          '',
                                                    ),
                                                  );
                                                }
// Ensure uniqueness if needed
                                                notifier.addSocialList =
                                                    notifier.addSocialList
                                                        .toSet()
                                                        .toList();

                                                // notifier.updateSelectedPlatform(
                                                //     platformId:
                                                //         socialMedia[pIndex]
                                                //             .id
                                                //             .toString());

                                                printLog(
                                                    "added social list:-> ${notifier.addSocialList[0].url}");
                                                back(context);

                                                // if (isValid) {
                                                //   notifier.addPlatform(
                                                //       isPhone: false,
                                                //       platformId:
                                                //           socialMedia[pIndex]
                                                //               .id
                                                //               .toString());
                                                // }
                                              },
                                              title: AppString.update,
                                              width: context.width,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    10.verticalSpace,
                                  ],
                                ),
                              );
                            }
                          } else {
                            printLog("item doesn't matched");
                            printLog("item doesn't matched");
                            notifier.urlController.clear();
                            notifier.urlController.clear();
                            notifier.countryCode = "+1";
                            notifier.countryFlag = '🇺🇸';
                            notifier.countryNameCode = 'US';

                            final countryNotifier =
                                ref.read(countryPickerProvider.notifier);

                            countryNotifier.updateInitialCountry('+1');

                            if (socialMedia[pIndex].type ==
                                'Enter phone number') {
                              showCustomBottomSheet(
                                context: context,
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        AppText(
                                          text: socialMedia[pIndex].name ?? '',
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        InkWell(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            onTap: () {
                                              back(context);
                                            },
                                            child: SvgPicture.asset(
                                                Assets.icCloseCircle))
                                      ],
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10.0),
                                      child: Divider(),
                                    ),
                                    // 10.verticalSpace,

                                    CustomPhoneNumber(
                                      minLength: notifier.minLength,
                                      maxLength: notifier.maxLength,
                                      selectedCountryCode: notifier.countryCode,
                                      selectedCountryFlag: notifier.countryFlag,
                                      prefixIcon: Assets.icGender,
                                      controller: notifier.urlController,
                                      labelText: AppString.phoneNumber,
                                    ),
                                    10.verticalSpace,

                                    /**--------------------- CANCEL AND SAVE  ---------------- **/
                                    Padding(
                                      padding: EdgeInsets.only(
                                          bottom: context.height * .02),
                                      child: Row(
                                        children: [
                                          //GO BACK
                                          Expanded(
                                            child: CommonAppBtn(
                                              textColor: AppColor.btnColor,
                                              backGroundColor: AppColor
                                                  .green00C56524
                                                  .withOpacity(.14),
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              title: AppString.cancel,
                                              width: context.width,
                                            ),
                                          ),
                                          10.horizontalSpace,

                                          //ADD/SAVE PLATFORM
                                          Expanded(
                                            child: CommonAppBtn(
                                              onTap: () {
                                                if (!notifier.addSocialList.any(
                                                    (item) =>
                                                        item.platformId ==
                                                        socialMedia[pIndex]
                                                            .id)) {
                                                  notifier.addSocialList.add(
                                                    AddSocialProfileModel(
                                                        platformId:
                                                            socialMedia[pIndex]
                                                                .id,
                                                        url:
                                                            "${notifier.countryCode} ${notifier.urlController.text}",
                                                        type:
                                                            socialMedia[pIndex]
                                                                    .type ??
                                                                ''),
                                                  );
                                                }

// Ensure uniqueness if needed
                                                notifier.addSocialList =
                                                    notifier.addSocialList
                                                        .toSet()
                                                        .toList();
                                                back(context);
                                                // var isValid = notifier
                                                //     .validateAddPlatform();

                                                // if (isValid) {
                                                //   notifier.addPlatform(
                                                //       isPhone: true,
                                                //       platformId:
                                                //           socialMedia[pIndex]
                                                //               .id
                                                //               .toString());
                                                // }
                                              },
                                              title: AppString.save,
                                              width: context.width,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    10.verticalSpace,
                                  ],
                                ),
                              );
                            } else {
                              printLog('url called');

                              notifier.urlController.clear();
                              showCustomBottomSheet(
                                context: context,
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        AppText(
                                          text: socialMedia[pIndex].name ?? '',
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        InkWell(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            onTap: () {
                                              back(context);
                                            },
                                            child: SvgPicture.asset(
                                                Assets.icCloseCircle))
                                      ],
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10.0),
                                      child: Divider(),
                                    ),
                                    // 10.verticalSpace,
                                    CustomLabelTextField(
                                      labelBckColor: AppColor.primary,
                                      labelText: "${socialMedia[pIndex].type}",
                                      controller: notifier.urlController,
                                      prefixWidget: CustomCacheNetworkImage(
                                          img: ApiConstants.socialIconBaseUrl +
                                              socialMedia[pIndex].icon!,
                                          width: 25,
                                          height: 25,
                                          imageRadius: 10),
                                    ),

                                    /**--------------------- CANCEL AND SAVE  ---------------- **/
                                    Padding(
                                      padding: EdgeInsets.only(
                                          bottom: context.height * .02),
                                      child: Row(
                                        children: [
                                          //GO BACK
                                          Expanded(
                                            child: CommonAppBtn(
                                              textColor: AppColor.btnColor,
                                              backGroundColor: AppColor
                                                  .green00C56524
                                                  .withOpacity(.14),
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              title: AppString.cancel,
                                              width: context.width,
                                            ),
                                          ),
                                          10.horizontalSpace,

                                          //ADD PLATFORM
                                          Expanded(
                                            child: CommonAppBtn(
                                              onTap: () {
                                                var isValid = notifier
                                                    .validateAddPlatform();

                                                if (!notifier.addSocialList.any(
                                                    (item) =>
                                                        item.platformId ==
                                                        socialMedia[pIndex]
                                                            .id)) {
                                                  notifier.addSocialList.add(
                                                    AddSocialProfileModel(
                                                        platformId:
                                                            socialMedia[pIndex]
                                                                .id,
                                                        url: notifier
                                                            .urlController.text,
                                                        type:
                                                            socialMedia[pIndex]
                                                                    .type ??
                                                                ''),
                                                  );
                                                }

// Ensure uniqueness if needed
                                                notifier.addSocialList =
                                                    notifier.addSocialList
                                                        .toSet()
                                                        .toList();

                                                // notifier.updateSelectedPlatform(
                                                //     platformId:
                                                //         socialMedia[pIndex]
                                                //             .id
                                                //             .toString());

                                                printLog(
                                                    "added social list:-> ${notifier.addSocialList}");
                                                back(context);

                                                // if (isValid) {
                                                //   notifier.addPlatform(
                                                //       isPhone: false,
                                                //       platformId:
                                                //           socialMedia[pIndex]
                                                //               .id
                                                //               .toString());
                                                // }
                                              },
                                              title: AppString.save,
                                              width: context.width,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    10.verticalSpace,
                                  ],
                                ),
                              );
                            }
                          }

                          if (notifier.addSocialList
                              .contains(socialMedia[pIndex].id)) {
                            // toast(
                            //     msg: "This platform is already added",

                            //     isInfo: true);

                            // if (socialMedia[pIndex].type ==
                            //     'Enter phone number') {

                            //   showCustomBottomSheet(
                            //     context: context,
                            //     content: Column(
                            //       mainAxisSize: MainAxisSize.min,
                            //       children: [
                            //         Row(
                            //           mainAxisAlignment:
                            //               MainAxisAlignment.spaceBetween,
                            //           children: [
                            //             AppText(
                            //               text: socialMedia[pIndex].name ?? '',
                            //               fontSize: 18.sp,
                            //               fontWeight: FontWeight.w500,
                            //             ),
                            //             InkWell(
                            //                 borderRadius:
                            //                     BorderRadius.circular(50),
                            //                 onTap: () {
                            //                   back(context);
                            //                 },
                            //                 child: SvgPicture.asset(
                            //                     Assets.icCloseCircle))
                            //           ],
                            //         ),
                            //         const Padding(
                            //           padding:
                            //               EdgeInsets.symmetric(vertical: 10.0),
                            //           child: Divider(),
                            //         ),
                            //         // 10.verticalSpace,

                            //         CustomPhoneNumber(
                            //           maxLength: notifier.maxLength,
                            //           selectedCountryCode: notifier.countryCode,
                            //           selectedCountryFlag: notifier.countryFlag,
                            //           prefixIcon: Assets.icGender,
                            //           controller: notifier.urlController,
                            //           labelText: AppString.phoneNumber,
                            //         ),
                            //         10.verticalSpace,

                            //         /**--------------------- CANCEL AND SAVE  ---------------- **/
                            //         Padding(
                            //           padding: EdgeInsets.only(
                            //               bottom: context.height * .02),
                            //           child: Row(
                            //             children: [
                            //               //GO BACK
                            //               Expanded(
                            //                 child: CommonAppBtn(
                            //                   textColor: AppColor.btnColor,
                            //                   backGroundColor: AppColor
                            //                       .green00C56524
                            //                       .withOpacity(.14),
                            //                   onTap: () {
                            //                     Navigator.pop(context);
                            //                   },
                            //                   title: AppString.cancel,
                            //                   width: context.width,
                            //                 ),
                            //               ),
                            //               10.horizontalSpace,

                            //               //ADD/SAVE PLATFORM
                            //               Expanded(
                            //                 child: CommonAppBtn(
                            //                   onTap: () {
                            //                     var isValid = notifier
                            //                         .validateAddPlatform();

                            //                     if (isValid) {
                            //                       notifier.addPlatform(
                            //                           isPhone: true,
                            //                           platformId:
                            //                               socialMedia[pIndex]
                            //                                   .id
                            //                                   .toString());
                            //                     }
                            //                   },
                            //                   title: AppString.save,
                            //                   width: context.width,
                            //                 ),
                            //               ),
                            //             ],
                            //           ),
                            //         ),
                            //         10.verticalSpace,
                            //       ],
                            //     ),
                            //   );
                            // } else {
                            //   showCustomBottomSheet(
                            //     context: context,
                            //     content: Column(
                            //       mainAxisSize: MainAxisSize.min,
                            //       children: [
                            //         Row(
                            //           mainAxisAlignment:
                            //               MainAxisAlignment.spaceBetween,
                            //           children: [
                            //             AppText(
                            //               text: socialMedia[pIndex].name ?? '',
                            //               fontSize: 18.sp,
                            //               fontWeight: FontWeight.w500,
                            //             ),
                            //             InkWell(
                            //                 borderRadius:
                            //                     BorderRadius.circular(50),
                            //                 onTap: () {
                            //                   back(context);
                            //                 },
                            //                 child: SvgPicture.asset(
                            //                     Assets.icCloseCircle))
                            //           ],
                            //         ),
                            //         const Padding(
                            //           padding:
                            //               EdgeInsets.symmetric(vertical: 10.0),
                            //           child: Divider(),
                            //         ),
                            //         // 10.verticalSpace,
                            //         CustomLabelTextField(
                            //           labelBckColor: AppColor.primary,
                            //           labelText: "${socialMedia[pIndex].type}",
                            //           controller: notifier.urlController,
                            //           prefixWidget: CustomCacheNetworkImage(
                            //               img: ApiConstants.socialIconBaseUrl +
                            //                   socialMedia[pIndex].icon!,
                            //               width: 25,
                            //               height: 25,
                            //               imageRadius: 10),
                            //         ),

                            //         /**--------------------- CANCEL AND SAVE  ---------------- **/
                            //         Padding(
                            //           padding: EdgeInsets.only(
                            //               bottom: context.height * .02),
                            //           child: Row(
                            //             children: [
                            //               //GO BACK
                            //               Expanded(
                            //                 child: CommonAppBtn(
                            //                   textColor: AppColor.btnColor,
                            //                   backGroundColor: AppColor
                            //                       .green00C56524
                            //                       .withOpacity(.14),
                            //                   onTap: () {
                            //                     Navigator.pop(context);
                            //                   },
                            //                   title: AppString.cancel,
                            //                   width: context.width,
                            //                 ),
                            //               ),
                            //               10.horizontalSpace,

                            //               //ADD PLATFORM
                            //               Expanded(
                            //                 child: CommonAppBtn(
                            //                   onTap: () {
                            //                     var isValid = notifier
                            //                         .validateAddPlatform();

                            //                     notifier.addSocialList.add(
                            //                         AddSocialProfileModel(
                            //                             platformId:
                            //                                 socialMedia[pIndex]
                            //                                     .id,
                            //                             url: notifier
                            //                                 .urlController
                            //                                 .text));

                            //                     notifier.addSocialList
                            //                         .toSet()
                            //                         .toList();

                            //                     notifier.updateSelectedPlatform(
                            //                         platformId:
                            //                             socialMedia[pIndex]
                            //                                 .id
                            //                                 .toString());

                            //                     printLog(
                            //                         "added social list:-> ${notifier.addSocialList}");
                            //                     back(context);

                            //                     // if (isValid) {
                            //                     //   notifier.addPlatform(
                            //                     //       isPhone: false,
                            //                     //       platformId:
                            //                     //           socialMedia[pIndex]
                            //                     //               .id
                            //                     //               .toString());
                            //                     // }
                            //                   },
                            //                   title: AppString.save,
                            //                   width: context.width,
                            //                 ),
                            //               ),
                            //             ],
                            //           ),
                            //         ),
                            //         10.verticalSpace,
                            //       ],
                            //     ),
                            //   );
                            // }
                          } else {
//                             notifier.urlController.clear();
//                             notifier.countryCode = "+1";
//                             notifier.countryFlag = '🇺🇸';
//                             notifier.countryNameCode = 'US';

//                             final countryNotifier =
//                                 ref.read(countryPickerProvider.notifier);

//                             countryNotifier.updateInitialCountry('+1');

//                             // notifier.updateCountryData(
//                             //   dialCode: "+1",
//                             //   countryNmCode: 'US',
//                             // );

//                             if (socialMedia[pIndex].type ==
//                                 'Enter phone number') {
//                               showCustomBottomSheet(
//                                 context: context,
//                                 content: Column(
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: [
//                                     Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         AppText(
//                                           text: socialMedia[pIndex].name ?? '',
//                                           fontSize: 18.sp,
//                                           fontWeight: FontWeight.w500,
//                                         ),
//                                         InkWell(
//                                             borderRadius:
//                                                 BorderRadius.circular(50),
//                                             onTap: () {
//                                               back(context);
//                                             },
//                                             child: SvgPicture.asset(
//                                                 Assets.icCloseCircle))
//                                       ],
//                                     ),
//                                     const Padding(
//                                       padding:
//                                           EdgeInsets.symmetric(vertical: 10.0),
//                                       child: Divider(),
//                                     ),
//                                     // 10.verticalSpace,

//                                     CustomPhoneNumber(
//                                       maxLength: notifier.maxLength,
//                                       selectedCountryCode: notifier.countryCode,
//                                       selectedCountryFlag: notifier.countryFlag,
//                                       prefixIcon: Assets.icGender,
//                                       controller: notifier.urlController,
//                                       labelText: AppString.phoneNumber,
//                                     ),
//                                     10.verticalSpace,

//                                     /**--------------------- CANCEL AND SAVE  ---------------- **/
//                                     Padding(
//                                       padding: EdgeInsets.only(
//                                           bottom: context.height * .02),
//                                       child: Row(
//                                         children: [
//                                           //GO BACK
//                                           Expanded(
//                                             child: CommonAppBtn(
//                                               textColor: AppColor.btnColor,
//                                               backGroundColor: AppColor
//                                                   .green00C56524
//                                                   .withOpacity(.14),
//                                               onTap: () {
//                                                 Navigator.pop(context);
//                                               },
//                                               title: AppString.cancel,
//                                               width: context.width,
//                                             ),
//                                           ),
//                                           10.horizontalSpace,

//                                           //ADD/SAVE PLATFORM
//                                           Expanded(
//                                             child: CommonAppBtn(
//                                               onTap: () {
//                                                 var isValid = notifier
//                                                     .validateAddPlatform();

//                                                 if (isValid) {
//                                                   notifier.addPlatform(
//                                                       isPhone: true,
//                                                       platformId:
//                                                           socialMedia[pIndex]
//                                                               .id
//                                                               .toString());
//                                                 }
//                                               },
//                                               title: AppString.save,
//                                               width: context.width,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     10.verticalSpace,
//                                   ],
//                                 ),
//                               );
//                             } else {
//                               showCustomBottomSheet(
//                                 context: context,
//                                 content: Column(
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: [
//                                     Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         AppText(
//                                           text: socialMedia[pIndex].name ?? '',
//                                           fontSize: 18.sp,
//                                           fontWeight: FontWeight.w500,
//                                         ),
//                                         InkWell(
//                                             borderRadius:
//                                                 BorderRadius.circular(50),
//                                             onTap: () {
//                                               back(context);
//                                             },
//                                             child: SvgPicture.asset(
//                                                 Assets.icCloseCircle))
//                                       ],
//                                     ),
//                                     const Padding(
//                                       padding:
//                                           EdgeInsets.symmetric(vertical: 10.0),
//                                       child: Divider(),
//                                     ),
//                                     // 10.verticalSpace,
//                                     CustomLabelTextField(
//                                       labelBckColor: AppColor.primary,
//                                       labelText: "${socialMedia[pIndex].type}",
//                                       controller: notifier.urlController,
//                                       prefixWidget: CustomCacheNetworkImage(
//                                           img: ApiConstants.socialIconBaseUrl +
//                                               socialMedia[pIndex].icon!,
//                                           width: 25,
//                                           height: 25,
//                                           imageRadius: 10),
//                                     ),

//                                     /**--------------------- CANCEL AND SAVE  ---------------- **/
//                                     Padding(
//                                       padding: EdgeInsets.only(
//                                           bottom: context.height * .02),
//                                       child: Row(
//                                         children: [
//                                           //GO BACK
//                                           Expanded(
//                                             child: CommonAppBtn(
//                                               textColor: AppColor.btnColor,
//                                               backGroundColor: AppColor
//                                                   .green00C56524
//                                                   .withOpacity(.14),
//                                               onTap: () {
//                                                 Navigator.pop(context);
//                                               },
//                                               title: AppString.cancel,
//                                               width: context.width,
//                                             ),
//                                           ),
//                                           10.horizontalSpace,

//                                           //ADD PLATFORM
//                                           Expanded(
//                                             child: CommonAppBtn(
//                                               onTap: () {
//                                                 var isValid = notifier
//                                                     .validateAddPlatform();

//                                                 if (!notifier.addSocialList.any(
//                                                     (item) =>
//                                                         item.platformId ==
//                                                         socialMedia[pIndex]
//                                                             .id)) {
//                                                   notifier.addSocialList.add(
//                                                     AddSocialProfileModel(
//                                                         platformId:
//                                                             socialMedia[pIndex]
//                                                                 .id,
//                                                         url: notifier
//                                                             .urlController.text,
//                                                         type:
//                                                             socialMedia[pIndex]
//                                                                     .type ??
//                                                                 ''),
//                                                   );
//                                                 }

// // Ensure uniqueness if needed
//                                                 notifier.addSocialList =
//                                                     notifier.addSocialList
//                                                         .toSet()
//                                                         .toList();

//                                                 // notifier.updateSelectedPlatform(
//                                                 //     platformId:
//                                                 //         socialMedia[pIndex]
//                                                 //             .id
//                                                 //             .toString());

//                                                 printLog(
//                                                     "added social list:-> ${notifier.addSocialList}");
//                                                 back(context);

//                                                 // if (isValid) {
//                                                 //   notifier.addPlatform(
//                                                 //       isPhone: false,
//                                                 //       platformId:
//                                                 //           socialMedia[pIndex]
//                                                 //               .id
//                                                 //               .toString());
//                                                 // }
//                                               },
//                                               title: AppString.save,
//                                               width: context.width,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     10.verticalSpace,
//                                   ],
//                                 ),
//                               );
//                             }
                          }
                        },
                        child: SizedBox(
                          height: 150,
                          width: 150,
                          child: Stack(children: [
                            SocialMediaProfile(
                              index: pIndex,
                              icon: socialMedia[pIndex].icon ?? '',
                              name:
                                  socialMedia[pIndex].name?.split(' ').first ??
                                      '',
                            ),
                            Visibility(
                              visible: notifier.addSocialList.any((item) =>
                                  item.platformId == socialMedia[pIndex].id),
                              child: Positioned(
                                right: 0,
                                top: -2,
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                      color: AppColor.primary,
                                      borderRadius: BorderRadius.circular(100)),
                                  child: SvgPicture.asset(Assets.checkBox),
                                ),
                              ),
                            )
                          ]),
                        ));
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 1.15,
                      crossAxisSpacing: context.width * .12,
                      mainAxisExtent: 100,
                      mainAxisSpacing: 10,
                      crossAxisCount: 3),
                ))
          ],
        ),
      ),
    );
  }
}
