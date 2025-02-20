import 'package:NearMii/config/assets.dart';
import 'package:NearMii/config/constants.dart';
import 'package:NearMii/config/enums.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/core/helpers/all_getter.dart';
import 'package:NearMii/core/utils/routing/routes.dart';
import 'package:NearMii/feature/common_widgets/app_text.dart';
import 'package:NearMii/feature/common_widgets/common_button.dart';
import 'package:NearMii/feature/common_widgets/custom_appbar.dart';
import 'package:NearMii/feature/common_widgets/custom_label_text_field.dart';
import 'package:NearMii/feature/common_widgets/custom_toast.dart';
import 'package:NearMii/feature/setting/presentation/provider/delete_account.dart';
import 'package:NearMii/feature/setting/presentation/provider/states/setting_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class DeletedDetailView extends ConsumerWidget {
  const DeletedDetailView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deleteAccountNotifier = ref.watch(deleteAccountProvider.notifier);

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

              Consumer(builder:
                  (BuildContext context, WidgetRef ref, Widget? child) {
                var isVisible = ref.watch(isCurrentPasswordVisible);

                return CustomLabelTextField(
                  onTapOnSuffixIcon: () {
                    ref.read(isCurrentPasswordVisible.notifier).state =
                        !ref.read(isCurrentPasswordVisible.notifier).state;
                  },
                  isObscure: isVisible,
                  prefixIcon: Assets.icLock,
                  controller: deleteAccountNotifier.currentPasswordController,
                  labelText: AppString.currentPassword,
                  suffixIcon: isVisible ? Assets.icEye : Assets.icEyeOff,
                );
              }),
              // CustomLabelTextField(
              //   labelBckColor: AppColor.greyf9f9f9,
              //   prefixIcon: Assets.icLock,
              //   controller: deleteAccountNotifier.currentPasswordController,
              //   labelText: AppString.currentPassword,
              // ),
              const SizedBox(height: 20),
              CommonAppBtn(
                onTap: () {
                  final isDeleteAccount =
                      deleteAccountNotifier.validateDeleteAccount();

                  if (isDeleteAccount) {
                    deleteAccountNotifier.deleteAccountApi();
                  }
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
