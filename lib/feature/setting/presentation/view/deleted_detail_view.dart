import 'dart:developer';

import 'package:NearMii/config/assets.dart';
import 'package:NearMii/config/constants.dart';
import 'package:NearMii/config/enums.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/core/helpers/all_getter.dart';
import 'package:NearMii/core/utils/routing/routes.dart';
import 'package:NearMii/feature/common_widgets/app_text.dart';
import 'package:NearMii/feature/common_widgets/common_button.dart';
import 'package:NearMii/feature/common_widgets/common_text_field.dart';
import 'package:NearMii/feature/common_widgets/custom_appbar.dart';
import 'package:NearMii/feature/common_widgets/custom_bottom_sheet.dart';
import 'package:NearMii/feature/common_widgets/custom_label_text_field.dart';
import 'package:NearMii/feature/common_widgets/custom_report_tile.dart';
import 'package:NearMii/feature/common_widgets/custom_toast.dart';
import 'package:NearMii/feature/other_user_profile/presentation/provider/report_provider.dart';
import 'package:NearMii/feature/setting/presentation/provider/delete_account_provider.dart';
import 'package:NearMii/feature/setting/presentation/provider/states/setting_states.dart';
import 'package:NearMii/feature/setting/presentation/view/delete_account_confirmation_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class DeletedDetailView extends ConsumerWidget {
  const DeletedDetailView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final deleteAccountNotifier = ref.read(deleteAccountProvider.notifier);

    ref.listen(
      deleteAccountProvider,
      (previous, next) async {
        if (next is SettingApiLoading &&
            next.settingType == Setting.deleteAccount) {
          showDialog(
            context: context,
            builder: (context) {
              return Center(
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.0),
                      color: AppColor.primary,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(28.0),
                      child: CircularProgressIndicator.adaptive(),
                    )),
              );
            },
          );
        } else if (next is SettingApiSuccess &&
            next.settingType == Setting.deleteAccount) {
          back(context);
          await Getters.getLocalStorage.clearLoginData();
          toast(msg: AppString.accountDeleted);
          if (context.mounted) {
            offAllNamed(context, Routes.login);
          }
        } else if (next is SettingApiFailed &&
            next.settingType == Setting.deleteAccount) {
          back(context);
          toast(msg: next.error);
        }
      },
    );

    return Scaffold(
      appBar: const CustomAppBar(title: AppString.deleteAccount),
      backgroundColor: AppColor.greyf9f9f9,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 130),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(Assets.deleteAccount),
              const SizedBox(height: 20),
              AppText(
                  text: AppString.deleteAccount,
                  fontFamily: Constants.fontFamily,
                  fontSize: 14.sp,
                  color: AppColor.black000000,
                  fontWeight: FontWeight.w500),
              const SizedBox(height: 10),
              AppText(
                text: AppString.enterYourCurrentPswd,
                fontFamily: Constants.fontFamily,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: AppColor.black000000.withOpacity(0.6),
              ),
              const SizedBox(height: 20),

              Column(
                children: [
                  Consumer(builder: (context, ref, child) {
                    var deleteAccountNotifier =
                        ref.watch(deleteAccountProvider.notifier);

                    int selected = ref.read(selectedReportIndex);
                    final reportNotifier = ref.read(reportProvider.notifier);
                    final somethingTextController = TextEditingController();

                    return CustomLabelTextField(
                      onChanged: (value) {
                        // ref.read(reasonTextProvider.notifier).state = value;

                        log("delete reason:-> ${value}");
                      },
                      // isObscure: isVisible,
                      prefixIcon: Assets.icLock,

                      controller: deleteAccountNotifier.reasonController,
                      labelText: AppString.reason,
                      onTap: () {
                        showCustomBottomSheet(
                            context: context,
                            content: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset(Assets.reportNavClose),
                                  15.verticalSpace,
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 4,
                                        vertical: context.height * .02),
                                    child: AppText(
                                        text: AppString.reason,
                                        fontSize: 20.sp,
                                        color: AppColor.black1A1C1E,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  CustomReportTile(
                                    title: AppString.theyArePretending,
                                    check: selected == 0,
                                    ontap: () {
                                      ref
                                          .read(selectedReportIndex.notifier)
                                          .state = 0;
                                    },
                                  ),
                                  CustomReportTile(
                                    title: AppString.theyAreUnderTheAge,
                                    check: selected == 1,
                                    ontap: () {
                                      ref
                                          .read(selectedReportIndex.notifier)
                                          .state = 1;
                                    },
                                  ),
                                  CustomReportTile(
                                    title: AppString.violenceAndDangerous,
                                    check: selected == 2,
                                    ontap: () {
                                      ref
                                          .read(selectedReportIndex.notifier)
                                          .state = 2;
                                    },
                                  ),
                                  CustomReportTile(
                                    title: AppString.hateSpeech,
                                    check: selected == 3,
                                    ontap: () {
                                      ref
                                          .read(selectedReportIndex.notifier)
                                          .state = 3;
                                    },
                                  ),
                                  CustomReportTile(
                                    title: AppString.nudity,
                                    check: selected == 4,
                                    ontap: () {
                                      ref
                                          .read(selectedReportIndex.notifier)
                                          .state = 4;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Row(
                                    children: [
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      AppText(
                                          text: "Something Else",
                                          fontSize: 14.sp,
                                          color: AppColor.black1A1C1E,
                                          fontWeight: FontWeight.w700),
                                    ],
                                  ),
                                  CustomTextFieldWidget(
                                      controller: somethingTextController,
                                      // enableBorder: OutlineInputBorder(
                                      //   borderRadius: BorderRadius.circular(20),
                                      // ),
                                      minLines: 2,
                                      fillColor: AppColor.whiteF0F5FE,
                                      hintText: "Lorem ipsum dolor sit......",
                                      onChanged: (value) {
                                        if (value!.isNotEmpty) {
                                          reportNotifier.clearAllChecks();
                                        }
                                      }),
                                  5.verticalSpace,
                                  CommonAppBtn(
                                    title: AppString.submit,
                                    onTap: () {
                                      back(context);
                                      toast(
                                          msg: "Reason Submitted successfully",
                                          isError: false);
                                    },
                                  ),
                                  10.verticalSpace
                                ],
                              ),
                            ));
                      },
                      // suffixIcon: isVisible ? Assets.icEye : Assets.icEyeOff,
                    );
                  }),
                  Consumer(builder: (context, ref, child) {
                    var isVisible = ref.watch(isCurrentPasswordVisible);

                    var deleteAccountNotifier =
                        ref.watch(deleteAccountProvider.notifier);
                    ref.watch(deleteAccountProvider);
                    return Visibility(
                      visible: deleteAccountNotifier
                          .reasonController.text.isNotEmpty,
                      child: CustomLabelTextField(
                        onTapOnSuffixIcon: () {
                          ref.read(isCurrentPasswordVisible.notifier).state =
                              !ref
                                  .read(isCurrentPasswordVisible.notifier)
                                  .state;
                        },
                        isObscure: isVisible,
                        prefixIcon: Assets.icLock,
                        controller:
                            deleteAccountNotifier.currentPasswordController,
                        labelText: AppString.currentPassword,
                        suffixIcon: isVisible ? Assets.icEye : Assets.icEyeOff,
                      ),
                    );
                  }),
                ],
              ),
              // CustomLabelTextField(
              //   labelBckColor: AppColor.greyf9f9f9,
              //   prefixIcon: Assets.icLock,
              //   controller: deleteAccountNotifier.currentPasswordController,
              //   labelText: AppString.currentPassword,
              // ),
              const SizedBox(height: 20),
              CommonAppBtn(
                onTap: () {
                  showCustomBottomSheet(
                      context: context,
                      content: DeleteAccountConfirmationView(delete: () {
                        // final isDeleteAccount =
                        //     deleteAccountNotifier.validateDeleteAccount();
                        // if (isDeleteAccount) {
                        //   deleteAccountNotifier.deleteAccountApi();
                        // }
                      }, onCancel: () {
                        back(context);
                      }));

                  // final isDeleteAccount =
                  //     deleteAccountNotifier.validateDeleteAccount();

                  // if (isDeleteAccount) {
                  //   deleteAccountNotifier.deleteAccountApi();
                  // }
                },
                title: AppString.done,
              )
            ],
          ),
        ),
      ),
    );
  }
}
