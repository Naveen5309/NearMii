import 'package:NearMii/config/assets.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/feature/common_widgets/app_text.dart';
import 'package:NearMii/feature/common_widgets/custom_cache_network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomTile extends StatelessWidget {
  final String leadingIcon;
  final String title;
  final String subtitle;
  final String time;
  final bool isHistory;
  final VoidCallback? onTap;
  final String? type;

  const CustomTile({
    super.key,
    required this.leadingIcon,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.isHistory,
    this.onTap,
    this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: isHistory == true
            ? CustomCacheNetworkImage(
                img: leadingIcon,
                imageRadius: 50,
                height: 50,
                width: 50,
              )
            : SvgPicture.asset(type == "search"
                ? Assets.searchNotication
                : Assets.locationNotification),

//Name
        title: AppText(
          text: title,
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),

//DESIGNATION
        subtitle: AppText(
          text: subtitle,
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
          color: AppColor.black000000.withOpacity(.37),
        ),

        trailing: AppText(
          text: time,
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
          color: AppColor.black000000.withOpacity(.18),
        ),
        onTap: onTap,
      ),
    );
  }
}
