import 'package:NearMii/config/constants.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/feature/common_widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomTile extends StatelessWidget {
  final String leadingIcon;
  final String title;
  final String subtitle;
  final String trailingIcon;
  final VoidCallback? onTap;

  const CustomTile({
    super.key,
    required this.leadingIcon,
    required this.title,
    required this.subtitle,
    required this.trailingIcon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.whiteFFFFFF,
        borderRadius: BorderRadius.circular(25),
      ),
      // margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      // padding: EdgeInsets.symmetric(vertical: 1),
      child: ListTile(
        leading: SvgPicture.asset(leadingIcon),
        title: AppText(
          text: title,
          fontSize: 14.sp,
          fontFamily: Constants.fontFamily,
          fontWeight: FontWeight.w500,
          color: AppColor.black000000,
        ),
        subtitle: AppText(
          fontFamily: Constants.fontFamily,

          text: subtitle,
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          color: AppColor.grey21203F.withOpacity(0.5), // Fixed opacity
        ),
        trailing: Image.asset(trailingIcon),
        onTap: onTap,
      ),
    );
  }
}
