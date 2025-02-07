import 'package:NearMii/config/assets.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/feature/common_widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomMapViewIcon extends StatelessWidget {
  const CustomMapViewIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100.0),
              color: AppColor.btnColor),
          child: Row(
            children: [
              SvgPicture.asset(Assets.icMap),
              5.horizontalSpace,
              AppText(
                text: AppString.mapView,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: AppColor.primary,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
