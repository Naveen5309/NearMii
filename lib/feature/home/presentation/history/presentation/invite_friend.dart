import 'package:NearMii/config/assets.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/feature/common_widgets/app_text.dart';
import 'package:NearMii/feature/common_widgets/common_button.dart';
import 'package:NearMii/feature/common_widgets/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:share_plus/share_plus.dart';

class InviteFriendBottomSheet extends StatelessWidget {
  final String title;
  final String subtitle;
  final String _copy = "Copy Me";
  final String text = '';
  final String link = '';

  const InviteFriendBottomSheet(
      {super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                color: AppColor.black000000.withOpacity(.6)),
          ),
          const SizedBox(height: 20),
          customTextField(),
          // CustomTextFieldWidget(
          //   enableBorder: const OutlineInputBorder(
          //     borderRadius: BorderRadius.all(Radius.circular(50.0)),
          //     borderSide: BorderSide(color: AppColor.green42B002, width: 1.5),
          //   ),
          //   prefixIcon: SvgPicture.asset(Assets.shareIcon),
          //   suffixIcon: SvgPicture.asset(Assets.copy),
          // ),
          20.verticalSpace,
          CommonAppBtn(
            backGroundColor: AppColor.appThemeColor,
            onTap: () {
              _onShare(
                context,
              );
            },
            title: AppString.copyReferralCode,
            textSize: 16.sp,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

Widget customTextField() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
    decoration: BoxDecoration(
      color: AppColor.primary,
      borderRadius: BorderRadius.circular(50),
      border: Border.all(color: AppColor.green42B002, width: 2),
    ),
    child: Row(
      children: [
        SvgPicture.asset(Assets.shareIcon),
        const SizedBox(width: 8),
        const Expanded(
          child: TextField(
            readOnly: true,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintStyle: TextStyle(color: AppColor.black000000),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Clipboard.setData(const ClipboardData(text: "fff"));
            toast(msg: "Text Copied to clipboard", isError: false);
          },
          child: SvgPicture.asset(Assets.copy),
        )
      ],
    ),
  );
}

void _onShare(BuildContext context) async {
  final box = context.findRenderObject() as RenderBox?;
  await Share.share("text",
      subject: "link",
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
}
