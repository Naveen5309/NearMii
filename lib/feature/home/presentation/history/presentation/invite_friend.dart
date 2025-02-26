import 'package:NearMii/config/assets.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/feature/common_widgets/app_text.dart';
import 'package:NearMii/feature/common_widgets/common_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:share_plus/share_plus.dart';

class InviteFriendBottomSheet extends StatelessWidget {
  final String title;
  final String subtitle;
  final String text;
  // final String link;

  const InviteFriendBottomSheet({
    super.key,
    required this.title,
    required this.subtitle,
    required this.text,
  });

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
          customTextField(text: text),
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
              _onShare(context: context, text: text);
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

Widget customTextField({required String text}) {
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
        Expanded(
          child: TextField(
            controller: TextEditingController(text: text),
            readOnly: true,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintStyle: TextStyle(color: AppColor.black000000),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Clipboard.setData(ClipboardData(text: text));
            // toast(msg: "Text Copied to clipboard", isError: false);
          },
          child: SvgPicture.asset(Assets.copy),
        )
      ],
    ),
  );
}

void _onShare({required BuildContext context, required String text}) async {
  final box = context.findRenderObject() as RenderBox?;
  await Share.share(
      "Hi!\n\nJoin me on the NearMii App and earn credits! Use the referral code below when you sign up.\n\nReferral code: $text\n\nI look forward to seeing you on the NearMii App!\n",
      subject: text,
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
}
