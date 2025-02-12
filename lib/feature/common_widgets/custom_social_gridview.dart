import 'package:NearMii/config/assets.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/core/network/http_service.dart';
import 'package:NearMii/feature/auth/data/models/get_platform_model.dart';
import 'package:NearMii/feature/common_widgets/app_text.dart';
import 'package:NearMii/feature/common_widgets/common_button.dart';
import 'package:NearMii/feature/common_widgets/custom_bottom_sheet.dart';
import 'package:NearMii/feature/common_widgets/custom_cache_network.dart';
import 'package:NearMii/feature/common_widgets/custom_label_text_field.dart';
import 'package:NearMii/feature/common_widgets/social_media_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomSocialGridview extends StatelessWidget {
  final String title;
  final List<PlatformData> socialMedia;

  const CustomSocialGridview({
    super.key,
    required this.title,
    required this.socialMedia,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: AppColor.primary,
        borderRadius: BorderRadius.circular(12), // Smooth rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03), // Adjust opacity as needed
            blurRadius: 2,
            spreadRadius: 0, // No spreading to the sides
            offset: const Offset(0, 5), // Move shadow downwards
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: context.height * .02, horizontal: context.width * .06),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //TITLE

            AppText(
              text: title,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
            //SOCIAL MEDIA

            Container(
                padding: EdgeInsets.only(top: context.height * .025),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                  ),
                ),
                // margin: const EdgeInsets.all(10.0),
                child: GridView.builder(
                  padding: EdgeInsets.zero,
                  // physics: const NeverScrollableScrollPhysics(),

                  itemCount: socialMedia.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, pIndex) {
                    return GestureDetector(
                        onTap: () {
                          showCustomBottomSheet(
                            context: context,
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    AppText(
                                      text: socialMedia[pIndex].name ?? '',
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    InkWell(
                                        borderRadius: BorderRadius.circular(50),
                                        onTap: () {
                                          back(context);
                                        },
                                        child: SvgPicture.asset(
                                            Assets.icCloseCircle))
                                  ],
                                ),
                                // 10.verticalSpace,
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: context.height * .04),
                                  child: CustomLabelTextField(
                                      labelBckColor: AppColor.primary,
                                      labelText:
                                          " https://${socialMedia[pIndex].name}/username",
                                      controller: TextEditingController(),
                                      prefixWidget: CustomCacheNetworkImage(
                                          img: ApiConstants.socialIconBaseUrl +
                                              socialMedia[pIndex].icon!,
                                          width: 25,
                                          height: 25,
                                          imageRadius: 10)),
                                ),

                                /**--------------------- CANCEL AND SAVE  ---------------- **/
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom: context.height * .02),
                                  child: Row(
                                    children: [
                                      //GO BACK
                                      Expanded(
                                        child: CommonAppBtn(
                                          textColor: AppColor.btnColor,
                                          backGroundColor: AppColor
                                              .green00C56524
                                              .withOpacity(.14),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          title: AppString.cancel,
                                          width: context.width,
                                        ),
                                      ),
                                      10.horizontalSpace,

                                      //SEND INVITE
                                      Expanded(
                                        child: CommonAppBtn(
                                          onTap: () {
                                            // Navigator.pop(context);
                                            // Navigator.push(
                                            //     context,
                                            //     MaterialPageRoute(
                                            //       builder: (context) =>
                                            //           const TravellersListView(),
                                            //     ));
                                          },
                                          title: AppString.save,
                                          width: context.width,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                10.verticalSpace,
                              ],
                            ),
                          );
                        },
                        child: SocialMediaProfile(
                          index: pIndex,
                          icon: socialMedia[pIndex].icon ?? '',
                          name: socialMedia[pIndex].name ?? '',
                        ));
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 1.15,
                      crossAxisSpacing: context.width * .15,
                      mainAxisExtent: 100,
                      mainAxisSpacing: 10,
                      crossAxisCount: 3),
                ))
          ],
        ),
      ),
    );
  }
}
