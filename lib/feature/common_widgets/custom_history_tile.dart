import 'package:NearMii/config/assets.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/core/network/http_service.dart';
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
    return InkWell(
        borderRadius: BorderRadius.circular(10.0),
        onTap: onTap,
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: isHistory == true
              ? CustomCacheNetworkImage(
                  img: leadingIcon.isNotEmpty
                      ? ApiConstants.profileBaseUrl + leadingIcon
                      : '',
                  imageRadius: 50,
                  height: 50,
                  width: 50,
                )
              : SvgPicture.asset(
                  type == "1"
                      ? Assets.searchNotication
                      : Assets.locationNotification,
                ),
          title: Column(
            mainAxisAlignment: subtitle.isNotEmpty
                ? MainAxisAlignment.start
                : MainAxisAlignment.center, // Center if no subtitle
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                text: title,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
              if (subtitle.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: AppText(
                    text: subtitle,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColor.black000000.withOpacity(.37),
                  ),
                ),
            ],
          ),
          trailing: AppText(
            text: time,
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: AppColor.black000000.withOpacity(.18),
          ),
          onTap: onTap,
        ));
  }
}
