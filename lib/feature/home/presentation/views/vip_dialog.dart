import 'package:NearMii/config/assets.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/feature/common_widgets/app_text.dart';
import 'package:NearMii/feature/common_widgets/common_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class VIPMembershipDialog extends StatelessWidget {
  const VIPMembershipDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(
          color: AppColor.appThemeColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: SvgPicture.asset(
                  Assets.icCloseCircle,
                  colorFilter: const ColorFilter.mode(
                    AppColor.primary,
                    BlendMode.srcIn,
                  ),
                ),
                onPressed: () => back(context),
              ),
            ),
            SvgPicture.asset(
              Assets.iconVip,
              width: 58,
              height: 58,
            ),
            const SizedBox(height: 10),
            AppText(
              text: "VIP Membership",
              fontSize: 28.sp,
              fontWeight: FontWeight.w500,
              color: AppColor.whiteFFFFFF,
            ),
            const SizedBox(height: 15),
            AppText(
              text:
                  "Lorem ipsum dolor sit amet consectetur. Dui etiam tempus scelerisque donec.",
              textAlign: TextAlign.center,
              color: AppColor.whiteFFFFFF,
              fontSize: 12.sp,
            ),
            const SizedBox(height: 35),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 11),
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.2, vertical: 15),
              decoration: BoxDecoration(
                color: AppColor.green009E51,
                borderRadius: BorderRadius.circular(11),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      AppText(
                        text: "\$120",
                        fontSize: 34.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                      AppText(
                        text: " /month",
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Column(
                    children: List.generate(
                      4,
                      (index) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 18,
                            ),
                            const SizedBox(width: 5),
                            AppText(
                                text: "Lorem ipsum dolor sit amet consectetur.",
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColor.whiteFFFFFF),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            CommonAppBtn(
              width: context.width * 0.7,
              height: 48,
              backGroundColor: AppColor.whiteFFFFFF,
              title: AppString.buyNow,
              textColor: AppColor.black000000,
            ),
            const SizedBox(height: 10),

            // ElevatedButton(
            //   style: ElevatedButton.styleFrom(
            //     backgroundColor: Colors.white,
            //     foregroundColor: Colors.black,
            //     padding:
            //         const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(30),
            //     ),
            //   ),
            //   onPressed: () => Navigator.pop(context),
            //   child: const Text("Buy Now"),
            // ),
          ],
        ),
      ),
    );
  }
}
