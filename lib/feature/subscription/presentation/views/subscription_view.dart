import 'package:NearMii/config/assets.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/feature/common_widgets/app_text.dart';
import 'package:NearMii/feature/common_widgets/common_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SubscriptionView extends StatelessWidget {
  const SubscriptionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.appThemeColor,
        elevation: 0.0,
        leading: InkWell(
          onTap: () {
            back(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: SvgPicture.asset(
              Assets.icBackBtn,
              colorFilter:
                  const ColorFilter.mode(AppColor.primary, BlendMode.srcIn),
            ),
          ),
        ),
        title: AppText(
          text: AppString.subscription,
          color: AppColor.primary,
          fontSize: 23.sp,
        ),
        centerTitle: true,
      ),

      //  const CustomAppBar(
      //   backgroundColor: AppColor.appThemeColor,
      //   title: AppString.subscription,
      // ),
      body: Container(
        padding: const EdgeInsets.all(7),
        decoration: const BoxDecoration(
          color: AppColor.appThemeColor,
          // borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: SvgPicture.asset(
                  Assets.iconVip,
                  width: 100.sp,
                  height: 100.sp,
                ),
              ),
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
            20.verticalSpace,
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
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
                  10.verticalSpace,
                  ListView.builder(
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: AppString.subscriptionDataList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
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
            SizedBox(
              height: context.height * .05,
            ),
            CommonAppBtn(
              width: context.width * .9,
              height: 48,
              backGroundColor: AppColor.whiteFFFFFF,
              title: AppString.buyNow,
              textColor: AppColor.black000000,
            ),
            SizedBox(
              height: context.height * .1,
            )
          ],
        ),
      ),
    );
  }
}
