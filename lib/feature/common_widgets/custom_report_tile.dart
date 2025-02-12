import 'package:NearMii/config/assets.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/feature/common_widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomReportTile extends StatelessWidget {
  final String title;
  final bool check;

  const CustomReportTile({
    super.key,
    required this.title,
    required this.check,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      padding: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // First option
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                text: title,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: AppColor.black272727.withOpacity(.9),
              ),
              check
                  ? SvgPicture.asset(Assets.checkTrue)
                  : SvgPicture.asset(Assets.checkFalse)
            ],
          ),
        ],
      ),
    );
  }
}
