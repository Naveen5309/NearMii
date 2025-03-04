import 'package:NearMii/config/assets.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/feature/common_widgets/app_text.dart';
import 'package:NearMii/feature/common_widgets/common_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class DeleteAccountConfirmationView extends StatelessWidget {
  final VoidCallback delete;
  final VoidCallback onCancel;
  final String? title;
  final String? btnText;

  const DeleteAccountConfirmationView(
      {super.key,
      required this.delete,
      required this.onCancel,
      this.title,
      this.btnText});

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
          AppText(
              text: title ?? AppString.areYouSureDelete,
              fontSize: 20.sp,
              lineHeight: 1.5,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w500),
          10.verticalSpace,
          const SizedBox(height: 20),
          20.verticalSpace,
          Padding(
            padding: EdgeInsets.only(bottom: context.height * .02),
            child: Row(
              children: [
                //CANCEL
                Expanded(
                  child: CommonAppBtn(
                    textColor: AppColor.btnColor,
                    backGroundColor: AppColor.green00C56524.withOpacity(.14),
                    onTap: () {
                      Navigator.pop(context);
                    },
                    title: AppString.cancel,
                    width: context.width,
                  ),
                ),
                10.horizontalSpace,

                //CONFIRM
                Expanded(
                  child: CommonAppBtn(
                    onTap: delete,
                    title: btnText ?? AppString.deleteAccount,
                    width: context.width,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
