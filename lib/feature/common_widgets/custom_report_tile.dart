import 'package:NearMii/config/assets.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/feature/common_widgets/app_text.dart';
import 'package:NearMii/feature/other_user_profile/presentation/provider/report_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomReportTile extends ConsumerWidget {
  final String title;
  final bool check;
  final VoidCallback? ontap;

  const CustomReportTile({
    super.key,
    required this.title,
    required this.check,
    this.ontap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(selectedReportIndex);
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
              GestureDetector(
                onTap: ontap,
                child: check
                    ? SvgPicture.asset(Assets.checkTrue,
                        key: ValueKey("checked_$title"))
                    : SvgPicture.asset(Assets.checkFalse,
                        key: ValueKey("unchecked_$title")),
              )
            ],
          ),
        ],
      ),
    );
  }

  CustomReportTile copyWith({String? title, bool? check}) {
    return CustomReportTile(
      title: title ?? this.title,
      check: check ?? this.check,
    );
  }
}
