import 'package:NearMii/config/helper.dart';
import 'package:NearMii/feature/common_widgets/app_text.dart';
import 'package:NearMii/feature/common_widgets/common_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<bool> showExitConfirmationDialog(BuildContext context) async {
  return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            title: AppText(
              text: "Exit App?",
              textAlign: TextAlign.center,
              fontSize: 18.sp,
            ),
            content: const AppText(
              text: "Are you sure you want to exit?",
              textAlign: TextAlign.center,
            ),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              CommonAppBtn(
                height: 45,
                width: context.width * .3,
                textColor: AppColor.btnColor,
                backGroundColor: AppColor.green00C56524.withOpacity(.14),
                title: "No",
                onTap: () => Navigator.of(context).pop(false),
              ),
              50.verticalSpace,
              CommonAppBtn(
                height: 45,
                width: context.width * .3,
                title: "Yes",
                onTap: () {
                  exit();
                },
              ),
            ],
          );
        },
      ) ??
      false; // Default to false if dialog is dismissed
}
