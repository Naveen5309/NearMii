import 'package:NearMii/config/helper.dart';
import 'package:NearMii/core/network/http_service.dart';
import 'package:NearMii/feature/common_widgets/app_text.dart';
import 'package:NearMii/feature/common_widgets/custom_cache_network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SocialMediaProfile extends StatelessWidget {
  final String icon;
  final String name;

  const SocialMediaProfile({
    super.key,
    required this.icon,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 5,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: CustomCacheNetworkImage(
            img: ApiConstants.socialIconBaseUrl + icon,
            imageRadius: 14,
            height: 80,
            width: 80,
          ),
        ),
        5.verticalSpace,
        AppText(
          text: name,
          fontSize: 10.sp,
          fontWeight: FontWeight.w500,
          color: AppColor.black000000.withOpacity(.64),
        )
      ],
    );
  }
}
