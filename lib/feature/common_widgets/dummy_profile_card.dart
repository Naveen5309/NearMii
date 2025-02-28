import 'package:NearMii/config/helper.dart';
import 'package:NearMii/feature/common_widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DummyProfileCard extends StatelessWidget {
  const DummyProfileCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin:
          EdgeInsets.symmetric(horizontal: context.width * .05, vertical: 8),
      decoration: BoxDecoration(
        // color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          // Profile Image

          SizedBox(
            height: 50.w,
            width: 50.w,
          ),

          const SizedBox(width: 12),

          // Name, Designation & Distance
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //NAME
                    AppText(
                      text: '',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColor.whiteFFFFFF,
                    ),

                    //DESIGNATION
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                      child: AppText(
                        text: '',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColor.whiteFFFFFF,
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 18,
                      color: AppColor.whiteFFFFFF,
                    ),
                    SizedBox(width: 3.sp),
                    AppText(
                      text: '',
                      fontSize: 12.sp,
                      color: AppColor.whiteFFFFFF,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Unlock Button
          Row(
            children: [
              const SizedBox(width: 4),
              AppText(
                text: '',
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: AppColor.whiteFFFFFF,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
