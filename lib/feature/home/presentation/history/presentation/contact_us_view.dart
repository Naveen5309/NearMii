import 'package:NearMii/config/assets.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/feature/common_widgets/common_button.dart';
import 'package:NearMii/feature/common_widgets/custom_appbar.dart';
import 'package:NearMii/feature/common_widgets/custom_label_text_field.dart';
import 'package:NearMii/feature/common_widgets/custom_textform_feild.dart';
import 'package:NearMii/feature/setting/presentation/provider/contact_us_provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContactUsView extends ConsumerWidget {
  const ContactUsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contactUsNotifier = ref.watch(contactUsProvider.notifier);

    return Scaffold(
      backgroundColor: AppColor.primary,
      appBar: const CustomAppBar(title: AppString.contactUs),
      body: Container(
        color: AppColor.greyFAFAFA,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 28),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomLabelTextField(
                prefixIcon: Assets.icUser,
                controller: contactUsNotifier.nameController,
                labelText: AppString.name,
              ),
              CustomLabelTextField(
                prefixIcon: Assets.icSms,
                controller: contactUsNotifier.emailController,
                labelText: AppString.email,
              ),
              CustomLabelTextField(
                prefixIcon: Assets.icSubject,
                controller: contactUsNotifier.subjectController,
                labelText: AppString.subject,
              ),
              CustomTextformFeild(
                radius: 19,
                prefixIcon: Assets.icCheck,
                controller: contactUsNotifier.messageController,
                labelText: AppString.message,
                maxLines: 5,
              ),
              SizedBox(
                height: 130.h,
              ),
              CommonAppBtn(
                onTap: () {
                  // final isContactUs = contactUsNotifier.validateContactUs();
                  // print(isContactUs);
                  // if (isContactUs) {
                  back(context);
                  // }
                },
                title: AppString.submit,
                textColor: AppColor.whiteFFFFFF,
                borderColor: AppColor.appThemeColor,
                backGroundColor: AppColor.appThemeColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
