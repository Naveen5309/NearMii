import 'package:NearMii/config/assets.dart';
import 'package:NearMii/config/enums.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/feature/common_widgets/common_button.dart';
import 'package:NearMii/feature/common_widgets/custom_appbar.dart';
import 'package:NearMii/feature/common_widgets/custom_label_text_field.dart';
import 'package:NearMii/feature/common_widgets/custom_textform_feild.dart';
import 'package:NearMii/feature/common_widgets/custom_toast.dart';
import 'package:NearMii/feature/setting/presentation/provider/contact_us_provider.dart';
import 'package:NearMii/feature/setting/presentation/provider/states/setting_states.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContactUsView extends ConsumerWidget {
  const ContactUsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contactUsNotifier = ref.watch(contactUsProvider.notifier);
    ref.listen(contactUsProvider, (previous, next) {
      if (next is SettingApiLoading && next.settingType == Setting.contactUs) {
      } else if (next is SettingApiSuccess &&
          next.settingType == Setting.contactUs) {
        toast(msg: AppString.loginSuccess, isError: false);
        back(context);
        // toNamed(context, Routes.bottomNavBar);
      } else if (next is SettingApiFailed && next.error == Setting.contactUs) {
        back(context);
        toast(msg: next.error);
      }
    });

    return Scaffold(
        backgroundColor: AppColor.primary,
        appBar: const CustomAppBar(title: AppString.contactUs),
        body: Container(
            color: AppColor.greyFAFAFA,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 28),
            child: SingleChildScrollView(
                child: Column(
              children: [
                Consumer(builder:
                    (BuildContext context, WidgetRef ref, Widget? child) {
                  return CustomLabelTextField(
                    prefixIcon: Assets.icUser,
                    controller: contactUsNotifier.nameController,
                    labelText: AppString.name,
                  );
                }),
                Consumer(builder:
                    (BuildContext context, WidgetRef ref, Widget? child) {
                  return CustomLabelTextField(
                    prefixIcon: Assets.icSms,
                    controller: contactUsNotifier.emailController,
                    labelText: AppString.email,
                  );
                }),
                Consumer(builder:
                    (BuildContext context, WidgetRef ref, Widget? child) {
                  return CustomLabelTextField(
                    prefixIcon: Assets.icSubject,
                    controller: contactUsNotifier.subjectController,
                    labelText: AppString.subject,
                  );
                }),
                Consumer(builder:
                    (BuildContext context, WidgetRef ref, Widget? child) {
                  return CustomTextformFeild(
                    radius: 19,
                    prefixIcon: Assets.icCheck,
                    controller: contactUsNotifier.messageController,
                    labelText: AppString.message,
                    maxLines: 5,
                  );
                }),
                SizedBox(
                  height: 130.h,
                ),
                CommonAppBtn(
                  onTap: () {
                    final isContactUs = contactUsNotifier.validateContactUs();
                    print(isContactUs);
                    if (isContactUs) {
                      contactUsNotifier.contactUSApi();
                    }
                  },
                  title: AppString.submit,
                  textColor: AppColor.whiteFFFFFF,
                  borderColor: AppColor.appThemeColor,
                  backGroundColor: AppColor.appThemeColor,
                ),
              ],
            ))));
  }
}
