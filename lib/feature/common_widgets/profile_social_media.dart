import 'package:NearMii/config/helper.dart';
import 'package:NearMii/core/network/http_service.dart';
import 'package:NearMii/feature/common_widgets/app_text.dart';
import 'package:NearMii/feature/common_widgets/custom_cache_network.dart';
import 'package:NearMii/feature/common_widgets/custom_switch_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileSocialMedia extends StatelessWidget {
  final String icon;
  final String name;
  final int index;
  final bool isMyProfile;

  const ProfileSocialMedia(
      {super.key,
      required this.icon,
      required this.name,
      required this.index,
      required this.isMyProfile});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: getCrossAxisAlignment(index),
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 3,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: CustomCacheNetworkImage(
            img: ApiConstants.socialIconBaseUrl + icon,
            imageRadius: 14,
            height: context.width * .16,
            width: context.width * .16,
            fit: BoxFit.cover,
          ),
        ),
        // 5.verticalSpace,
        Align(
          // alignment: getAlignment(index),
          alignment: Alignment.center,
          child: AppText(
            text: name,
            fontSize: 10.sp,
            fontWeight: FontWeight.w500,
            color: AppColor.black000000.withOpacity(.64),
          ),
        ),
        10.verticalSpace,
        isMyProfile
            ? Align(
                alignment: Alignment.center,
                child: ToggleSwitchBtn(
                  onToggled: (bool isToggled) {},
                ),
              )
            : const SizedBox()
      ],
    );
  }
}
