import 'package:NearMii/config/assets.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/feature/common_widgets/app_text.dart';
import 'package:NearMii/feature/common_widgets/common_button.dart';
import 'package:NearMii/feature/common_widgets/common_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class InviteFriendBottomSheet extends StatelessWidget {
  final String title;
  final String subtitle;

  const InviteFriendBottomSheet(
      {super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: AppColor.primary,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: SvgPicture.asset(Assets.icCloseCircle),
              onPressed: () => back(context),
            ),
          ),
          AppText(text: title, fontSize: 20.sp, fontWeight: FontWeight.w500),
          10.verticalSpace,
          SizedBox(
            width: 300.sp,
            child: AppText(
                text: subtitle,
                textAlign: TextAlign.center,
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: AppColor.black000000.withValues(alpha: .6)),
          ),
          const SizedBox(height: 20),
          CustomTextFieldWidget(
            enableBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(50.0)),
              borderSide: BorderSide(color: AppColor.green42B002, width: 1.5),
            ),
            prefixIcon: SvgPicture.asset(Assets.shareIcon),
          ),
          20.verticalSpace,
          CommonAppBtn(
            backGroundColor: AppColor.appThemeColor,
            onTap: () {},
            title: AppString.copyReferralCode,
            textSize: 16.sp,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
