import 'package:NearMii/config/constants.dart';
import 'package:NearMii/config/helper.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomRichTextThreeWidget extends StatelessWidget {
  final String text;
  final String clickableText;
  final String clickableText2;

  final TextStyle? clickableTextStyle;
  final VoidCallback onTap;
  final VoidCallback onTap2;

  const CustomRichTextThreeWidget({
    super.key,
    required this.text,
    required this.clickableText,
    required this.clickableText2,
    this.clickableTextStyle,
    required this.onTap,
    required this.onTap2,
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
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: AppColor.black000000.withOpacity(.44),
            ),
          ),
          TextSpan(
            text: " $clickableText",
            style: TextStyle(
              fontFamily: Constants.fontFamily,
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: AppColor.black000000.withOpacity(.74),
            ),
            recognizer: TapGestureRecognizer()..onTap = onTap,
          ),
          TextSpan(
            text: AppString.and,
            style: TextStyle(
              fontFamily: Constants.fontFamily,
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: AppColor.black000000.withOpacity(.44),
            ),
          ),
          TextSpan(
            text: " $clickableText2",
            style: TextStyle(
              fontFamily: Constants.fontFamily,
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: AppColor.black000000.withOpacity(.74),
            ),
            recognizer: TapGestureRecognizer()..onTap = onTap2,
          ),
        ],
      ),
    );
  }
}
