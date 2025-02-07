import 'package:NearMii/config/assets.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/feature/common_widgets/app_text.dart';
import 'package:NearMii/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomAppbarWidget extends StatelessWidget {
  final String title;

  const CustomAppbarWidget({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(Assets.icHomePngBg),
        ),
      ),
      // height: MediaQuery.sizeOf(context).height * 0.2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: totalHeight -
                  MediaQuery.of(navigatorKey.currentState!.context).padding.top,
            ),
            10.verticalSpace,
            SizedBox(
              width: context.width,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    child: SvgPicture.asset(
                      Assets.icBackBtn,
                      colorFilter: const ColorFilter.mode(
                          AppColor.primary, BlendMode.srcIn),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: AppText(
                      text: title,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColor.primary,
                    ),
                  ),
                ],
              ),
            ),
            5.verticalSpace,
          ],
        ),
      ),
    );
  }
}
