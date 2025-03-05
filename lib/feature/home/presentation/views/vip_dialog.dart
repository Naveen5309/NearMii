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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 50,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: SvgPicture.asset(
                    Assets.iconVip,
                    width: 58,
                    height: 58,
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: SvgPicture.asset(
                      Assets.icCloseCircle,
                      height: 30,
                      width: 30,
                      colorFilter: const ColorFilter.mode(
                        AppColor.primary,
                        BlendMode.srcIn,
                      ),
                    ),
                    onPressed: () => back(context),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),
            AppText(
              text: AppString.vipMembership,
              fontSize: 28.sp,
              fontWeight: FontWeight.w500,
              color: AppColor.whiteFFFFFF,
            ),
            10.verticalSpace,
            AppText(
              text: "Subscription Details",
              textAlign: TextAlign.center,
              lineHeight: 1.2,
              fontWeight: FontWeight.w400,
              color: AppColor.whiteFFFFFF,
              fontSize: 14.sp,
            ),

            10.verticalSpace,
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.2, vertical: 30),
              decoration: BoxDecoration(
                color: AppColor.green009E51,
                borderRadius: BorderRadius.circular(11),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      AppText(
                        text: "\$19.99",
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                      AppText(
                        text: "/month",
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: AppString.subscriptionDataList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 18,
                            ),
                            const SizedBox(width: 5),
                            AppText(
                                text: AppString.subscriptionDataList[index],
                                fontSize: 14.sp,
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.w400,
                                color: AppColor.whiteFFFFFF),
                          ],
                        ),
                      );
                    },
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
