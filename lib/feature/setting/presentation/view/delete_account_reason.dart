import 'dart:developer';

import 'package:NearMii/config/app_utils.dart';
import 'package:NearMii/config/assets.dart';
import 'package:NearMii/config/enums.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/core/helpers/all_getter.dart';
import 'package:NearMii/core/utils/routing/routes.dart';
import 'package:NearMii/feature/common_widgets/app_text.dart';
import 'package:NearMii/feature/common_widgets/common_button.dart';
import 'package:NearMii/feature/common_widgets/common_text_field.dart';
import 'package:NearMii/feature/common_widgets/custom_appbar.dart';
import 'package:NearMii/feature/common_widgets/custom_bottom_sheet.dart';
import 'package:NearMii/feature/common_widgets/custom_report_tile.dart';
import 'package:NearMii/feature/common_widgets/custom_toast.dart';
import 'package:NearMii/feature/other_user_profile/presentation/provider/report_provider.dart';
import 'package:NearMii/feature/setting/presentation/provider/delete_account_provider.dart';
import 'package:NearMii/feature/setting/presentation/provider/states/setting_states.dart';
import 'package:NearMii/feature/setting/presentation/view/delete_account_confirmation_view.dart';
import 'package:NearMii/feature/setting/presentation/view/show_box_delete_account.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class DeleteReasonView extends ConsumerStatefulWidget {
  final String socialId;
  const DeleteReasonView({super.key, required this.socialId});

  @override
  ConsumerState<DeleteReasonView> createState() => _DeleteReasonViewState();
}

class _DeleteReasonViewState extends ConsumerState<DeleteReasonView> {
  @override
  Widget build(BuildContext context) {
    final deleteAccountNotifier = ref.read(deleteAccountProvider.notifier);

    ref.listen(
      deleteAccountProvider,
      (previous, next) async {
        if (next is SettingApiLoading &&
            next.settingType == Setting.deleteAccount) {
          Utils.showLoader();
        } else if (next is SettingApiSuccess &&
            next.settingType == Setting.deleteAccount) {
          Utils.hideLoader();

          await Getters.getLocalStorage.clearLoginData().then(
            (value) {
              toast(msg: AppString.accountDeleted);

              if (context.mounted) {
                offAllNamed(context, Routes.login);
              }
            },
          );
        } else if (next is SettingApiFailed &&
            next.settingType == Setting.deleteAccount) {
          Utils.hideLoader();

          toast(msg: next.error);
        }
      },
    );

    return Scaffold(
      appBar: const CustomAppBar(
        title: AppString.deleteAccount,
      ),
      backgroundColor: AppColor.greyf9f9f9,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(Assets.deleteAccount),
              // const SizedBox(height: 20),
              // AppText(
              //     text: AppString.deleteAccount,
              //     fontFamily: Constants.fontFamily,
              //     fontSize: 14.sp,
              //     color: AppColor.black000000,
              //     fontWeight: FontWeight.w500),
              // const SizedBox(height: 10),
              // AppText(
              //   text: AppString.enterYourCurrentPswd,
              //   fontFamily: Constants.fontFamily,
              //   fontSize: 12.sp,
              //   fontWeight: FontWeight.w500,
              //   color: AppColor.black000000.withOpacity(0.6),
              // ),
              // const SizedBox(height: 20),
              Consumer(builder: (context, ref, child) {
                int selected = ref.watch(selectedDeleteIndex);

                return SingleChildScrollView(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // SvgPicture.asset(Assets.reportNavClose),
                    15.verticalSpace,
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: context.height * .01),
                      child: AppText(
                          text: AppString.giveReason,
                          fontSize: 18.5.sp,
                          color: AppColor.black1A1C1E,
                          fontWeight: FontWeight.w500),
                    ),
                    AppText(
                        text: AppString.tellReason,
                        fontSize: 14.5.sp,
                        color: AppColor.black1A1C1E,
                        fontWeight: FontWeight.w400),
                    20.verticalSpace,
                    CustomReportTile(
                      title: AppString.noLongerNeed,
                      check: selected == 0,
                      ontap: () {
                        ref.read(selectedDeleteIndex.notifier).state = 0;

                        deleteAccountNotifier.reasonController.text =
                            AppString.noLongerNeed;
                        // back(context);
                      },
                    ),
                    CustomReportTile(
                      title: AppString.notUsingAppAnymore,
                      check: selected == 1,
                      ontap: () {
                        ref.read(selectedDeleteIndex.notifier).state = 1;

                        deleteAccountNotifier.reasonController.text =
                            AppString.notUsingAppAnymore;
                        // back(context);
                      },
                    ),
                    CustomReportTile(
                      maxlines: 2,
                      title: AppString.multipleAccountsSoNeedToRemove,
                      check: selected == 2,
                      ontap: () {
                        ref.read(selectedDeleteIndex.notifier).state = 2;
                        deleteAccountNotifier.reasonController.text =
                            AppString.multipleAccountsSoNeedToRemove;
                        // back(context);
                      },
                    ),
                    CustomReportTile(
                      maxlines: 2,
                      title: AppString.createNewAccount,
                      check: selected == 3,
                      ontap: () {
                        ref.read(selectedDeleteIndex.notifier).state = 3;
                        deleteAccountNotifier.reasonController.text =
                            AppString.createNewAccount;
                        // back(context);
                      },
                    ),
                    const SizedBox(height: 12),
                    5.verticalSpace,
                    // CommonAppBtn(
                    //   title: AppString.addReason,
                    //   onTap: () {
                    //     back(context);
                    //   },
                    // ),
                    Row(
                      children: [
                        AppText(
                            text: AppString.somethingElse,
                            fontSize: 14.sp,
                            color: AppColor.black1A1C1E,
                            fontWeight: FontWeight.w400),
                      ],
                    ),
                    4.verticalSpace,
                    CustomTextFieldWidget(
                        controller:
                            deleteAccountNotifier.somethingElseController,
                        enableBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: AppColor.greyEEEEEE,
                            width: 0,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        focusBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: AppColor.greyEEEEEE,
                            width: 0,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        minLines: 3,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        fillColor: AppColor.greyEEEEEE,
                        hintText: "Enter custom reason...",
                        onChanged: (value) {
                          if (value!.isNotEmpty) {
                            ref.read(selectedDeleteIndex.notifier).state = -1;
                          }
                        }),
                  ],
                ));
              }),

              const SizedBox(height: 20),
              CommonAppBtn(
                // onTap: () => toNamed(context, Routes.deleteAccount,
                //     args:
                //         deleteAccountNotifier.userProfileModel?.socialId ?? ''),
                onTap: () {
                  int selected = ref.watch(selectedDeleteIndex);
                  log("social profile is :-. $selected");
                  log("social profile is :-. ${deleteAccountNotifier.somethingElseController.text}");
                  log("social profile is :-. ${widget.socialId}");

                  if (widget.socialId.isEmpty) {
                    if ((selected == -1) &&
                        (deleteAccountNotifier.somethingElseController.text
                            .trim()
                            .isEmpty)) {
                      toast(msg: "Select reason for delete account");
                      return;
                    } else {
                      deleteAccountNotifier.currentPasswordController.clear();
                      showCustomBottomSheet(
                          context: context,
                          content: const DeleteAccountBottomSheet());
                    }
                  } else {
                    showCustomBottomSheet(
                        context: context,
                        content: DeleteAccountConfirmationView(delete: () {
                          deleteAccountNotifier.deleteAccountApi(
                              socialId: widget.socialId);
                        }, onCancel: () {
                          back(context);
                        }));
                  }
                  // log("social profile is :-. ${widget.socialId}");
                  // log("social profile is :-. ${deleteAccountNotifier.somethingElseController.text}");

                  // if (widget.socialId.isEmpty) {
                  //   log("delete show 1");
                  //   deleteAccountNotifier.currentPasswordController.clear();
                  //   int selected = ref.watch(selectedDeleteIndex);

                  //   if ((selected == -1) &&
                  //       (deleteAccountNotifier.somethingElseController.text
                  //           .trim()
                  //           .isEmpty)) {
                  //     toast(msg: "Select reason for delete account");
                  //     return;
                  //   }

                  //   showCustomBottomSheet(
                  //       context: context,
                  //       content: const DeleteAccountBottomSheet());
                  // } else {
                  //   printLog("Normal user");
                  //   showCustomBottomSheet(
                  //       context: context,
                  //       content: DeleteAccountConfirmationView(delete: () {
                  //         deleteAccountNotifier.deleteAccountApi(
                  //             socialId: widget.socialId);
                  //       }, onCancel: () {
                  //         back(context);
                  //       }));
                  // }
                },
                title: AppString.next,
              )
            ],
          ),
        ),
      ),
    );
  }
}
