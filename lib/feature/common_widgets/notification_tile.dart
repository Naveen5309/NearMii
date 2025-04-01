import 'package:NearMii/config/assets.dart';
import 'package:NearMii/config/helper.dart';

import 'package:NearMii/feature/common_widgets/app_text.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class NotificationTile extends StatelessWidget {
  final String leadingIcon;
  final String title;
  final String subtitle;
  final String time;
  final VoidCallback? onTap;
  final String? type;

  const NotificationTile({
    super.key,
    required this.leadingIcon,
    required this.title,
    required this.subtitle,
    required this.time,
    this.onTap,
    this.type,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10.0),
      onTap: onTap,
      child: ListTile(
        contentPadding: EdgeInsets.zero,

        leading: SvgPicture.asset(type == "1"
            ? Assets.searchNotication
            : Assets.locationNotification),

        //Name
        title: AppText(
          text: title,
          fontSize: 13.sp,
          fontWeight: FontWeight.w500,
        ),

        //DESIGNATION
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6.0),
          child: AppText(
            text: subtitle,
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: AppColor.black000000.withValues(alpha: .37),
          ),
        ),

        trailing: AppText(
          text: time,
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
          color: AppColor.black000000.withValues(alpha: .18),
        ),
        onTap: onTap,
      ),
    );
  }
}
