import 'dart:ui';

import 'package:NearMii/config/assets.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/feature/common_widgets/app_text.dart';
import 'package:NearMii/feature/common_widgets/custom_cache_network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomProfileCard extends StatelessWidget {
  final String profileImage;
  final String name;
  final String designation;
  final String distance;
  final bool isSubscription;

  final VoidCallback onUnlockTap;

  const CustomProfileCard({
    super.key,
    required this.profileImage,
    required this.name,
    required this.designation,
    required this.distance,
    required this.isSubscription,
    required this.onUnlockTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onUnlockTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        margin:
            EdgeInsets.symmetric(horizontal: context.width * .05, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: AppColor.green173E01.withValues(alpha: 0.06),
              blurRadius: 3,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          children: [
            // Profile Image

            CustomCacheNetworkImage(
              img: profileImage,
              imageRadius: 10,
              height: 50.w,
              width: 50.w,
            ),

            const SizedBox(width: 12),

            // Name, Designation & Distance
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ImageFiltered(
                    enabled: !isSubscription,
                    imageFilter: ImageFilter.blur(sigmaX: 3, sigmaY: 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //NAME
                        AppText(
                          text: name,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColor.black000000,
                        ),

                        //DESIGNATION
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6.0),
                          child: AppText(
                            text: designation,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColor.black000000.withValues(alpha: .34),
                          ),
                        )
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 18,
                        color: AppColor.orangeE57300,
                      ),
                      SizedBox(width: 3.sp),
                      AppText(
                        text: distance,
                        fontSize: 12.sp,
                        color: AppColor.orangeE57300,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Unlock Button
            Row(
              children: [
                SvgPicture.asset(Assets.icStar),
                const SizedBox(width: 4),
                AppText(
                  text: AppString.unlockNow,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColor.btnColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
