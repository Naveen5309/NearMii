import 'package:NearMii/config/helper.dart';
import 'package:NearMii/feature/common_widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonBtn extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CommonBtn({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.appThemeColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
      ),
      child: AppText(
        text: text,
        color: AppColor.whiteFFFFFF,
        fontSize: 13.sp,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
