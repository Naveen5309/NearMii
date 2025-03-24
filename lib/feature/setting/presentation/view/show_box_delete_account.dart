import 'package:NearMii/config/app_utils.dart';
import 'package:NearMii/config/assets.dart';
import 'package:NearMii/config/enums.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/core/helpers/all_getter.dart';
import 'package:NearMii/feature/common_widgets/app_text.dart';
import 'package:NearMii/feature/common_widgets/common_button.dart';
import 'package:NearMii/feature/common_widgets/custom_bottom_sheet.dart';
import 'package:NearMii/feature/common_widgets/custom_label_text_field.dart';
import 'package:NearMii/feature/common_widgets/custom_toast.dart';
import 'package:NearMii/feature/setting/presentation/provider/delete_account_provider.dart';
import 'package:NearMii/feature/setting/presentation/provider/states/setting_states.dart';
import 'package:NearMii/feature/setting/presentation/view/delete_account_confirmation_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class DeleteAccountBottomSheet extends ConsumerStatefulWidget {
  final String? title;
  final String? btnText;

  const DeleteAccountBottomSheet({
    super.key,
    this.title,
    this.btnText,
  });

  @override
  ConsumerState<DeleteAccountBottomSheet> createState() =>
      _DeleteAccountBottomSheetState();
}

class _DeleteAccountBottomSheetState
    extends ConsumerState<DeleteAccountBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final deleteAccountNotifier = ref.read(deleteAccountProvider.notifier);

    ref.listen(
      deleteAccountProvider,
      (previous, next) async {
        if (next is SettingApiLoading &&
            next.settingType == Setting.verifyDeleteAccount) {
          Utils.showLoader();
        } else if (next is SettingApiSuccess &&
            next.settingType == Setting.verifyDeleteAccount) {
          Utils.hideLoader();
          showCustomBottomSheet(
              context: context,
              content: DeleteAccountConfirmationView(delete: () {
                deleteAccountNotifier.deleteAccountApi();
              }, onCancel: () {
                back(context);
              }));
          // await Getters.getLocalStorage.clearLoginData();
          // toast(msg: AppString.accountDeleted);
          // if (context.mounted) {
          //   offAllNamed(context, Routes.login);
          // }
        } else if (next is SettingApiFailed &&
            next.settingType == Setting.verifyDeleteAccount) {
          Utils.hideLoader();

          toast(msg: next.error);
        }
      },
    );

    return Container(
      decoration: const BoxDecoration(
        color: AppColor.primary,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: SvgPicture.asset(Assets.icCloseCircle),
              onPressed: () => back(context),
            ),
          ),
          AppText(
              text: widget.title ?? AppString.deleteAccount,
              fontSize: 20.sp,
              lineHeight: 1.5,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w500),
          5.verticalSpace,
          AppText(
              text: widget.title ?? AppString.enterYourCurrentPswd,
              fontSize: 12.sp,
              lineHeight: 1.5,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w400),
          10.verticalSpace,
          Consumer(builder: (context, ref, child) {
            var isVisible = ref.watch(isCurrentPasswordVisible);

            var deleteAccountNotifier =
                ref.watch(deleteAccountProvider.notifier);
            ref.watch(deleteAccountProvider);
            return CustomLabelTextField(
              onTapOnSuffixIcon: () {
                ref.read(isCurrentPasswordVisible.notifier).state =
                    !ref.read(isCurrentPasswordVisible.notifier).state;
              },
              isObscure: !isVisible,
              prefixIcon: Assets.icLock,
              controller: deleteAccountNotifier.currentPasswordController,
              labelText: AppString.currentPassword,
              suffixIcon: isVisible ? Assets.icEyeOff : Assets.icEye,
            );
          }),
          20.verticalSpace,
          Padding(
              padding: EdgeInsets.only(bottom: context.height * .02),
              child: CommonAppBtn(
                onTap: () {
                  // back(context);

                  // final isDeleteAccount =
                  //     deleteAccountNotifier.validateDeleteAccountSocial();
                  // final isDeleteAccountt =
                  //     deleteAccountNotifier.validateDeleteAccount();
                  // if (isDeleteAccount) {
                  //   showCustomBottomSheet(
                  //       context: context,
                  //       content: DeleteAccountConfirmationView(delete: () {
                  //         deleteAccountNotifier.deleteAccountApi();
                  //       }, onCancel: () {
                  //         back(context);
                  //       }));
                  // }

                  // if (isDeleteAccountt) {
                  //   showCustomBottomSheet(
                  //       context: context,
                  //       content: DeleteAccountConfirmationView(delete: () {
                  //         deleteAccountNotifier.deleteAccountApi();
                  //       }, onCancel: () {
                  //         back(context);
                  //       }));
                  // }

                  // if (socialId!.isEmpty) {
                  final isValid = deleteAccountNotifier.validateDeleteAccount();

                  if (isValid) {
                    deleteAccountNotifier.verifyDeleteAccountApi(
                        // socialId: widget.socialId
                        );
                    // showCustomBottomSheet(
                    //   context: context,
                    //   content: DeleteAccountConfirmationView(delete: () {
                    //     deleteAccountNotifier.verifyDeleteAccountApi(
                    //         // socialId: widget.socialId
                    //         );
                    //   }, onCancel: () {
                    //     back(context);
                    //   }),
                    // );
                  } else {
                    // final isDeleteAccount =
                    //     deleteAccountNotifier.validateDeleteAccount();

                    // if (isDeleteAccount) {
                    //   showCustomBottomSheet(
                    //       context: context,
                    //       content: DeleteAccountConfirmationView(delete: () {
                    //         deleteAccountNotifier.deleteAccountApi();
                    //       }, onCancel: () {
                    //         back(context);
                    //       }));
                    // }
                  }
                },
                // },
                title: AppString.done,
              )),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
