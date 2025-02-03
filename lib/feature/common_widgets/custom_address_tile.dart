import 'package:NearMii/config/assets.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/feature/common_widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class LocationCard extends StatelessWidget {
  final String location;
  final String address;

  const LocationCard({
    super.key,
    required this.location,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 65.h,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: AppColor.primary,
        borderRadius: BorderRadius.circular(110), // Smooth rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
              height: 45,
              width: 45,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: const Color(0xff00C565),
                  borderRadius: BorderRadius.circular(200)),
              child: SvgPicture.asset(Assets.icLocation)),
          const SizedBox(width: 8),

          // Location Text
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //location
              AppText(
                text: location,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: AppColor.black000000,
              ),
              5.verticalSpace,

              //address

              AppText(
                text: address,
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: AppColor.black000000.withOpacity(.4),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
