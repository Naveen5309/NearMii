import 'package:NearMii/config/constants.dart';
import 'package:NearMii/config/helper.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomRichText extends StatelessWidget {
  final String text;
  final String clickableText;
  final TextStyle? clickableTextStyle;
  final VoidCallback onTap;

  const CustomRichText({
    super.key,
    required this.text,
    required this.clickableText,
    this.clickableTextStyle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: text,
            style: TextStyle(
              fontFamily: Constants.fontFamily,
              fontSize: 15.sp,
              fontWeight: FontWeight.w400,
              color: AppColor.black000000.withOpacity(.4),
            ),
          ),
          TextSpan(
            text: " $clickableText",
            style: TextStyle(
              fontFamily: Constants.fontFamily,
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
              color: AppColor.btnColor,
            ),
            recognizer: TapGestureRecognizer()..onTap = onTap,
          ),
        ],
      ),
    );
  }
}
