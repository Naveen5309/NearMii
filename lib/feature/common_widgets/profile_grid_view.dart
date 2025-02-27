import 'package:NearMii/config/assets.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/core/network/http_service.dart';
import 'package:NearMii/feature/auth/data/models/get_platform_model.dart';
import 'package:NearMii/feature/common_widgets/app_text.dart';
import 'package:NearMii/feature/common_widgets/common_button.dart';
import 'package:NearMii/feature/common_widgets/custom_bottom_sheet.dart';
import 'package:NearMii/feature/common_widgets/custom_cache_network.dart';
import 'package:NearMii/feature/common_widgets/custom_label_text_field.dart';
import 'package:NearMii/feature/common_widgets/profile_social_media.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ProfileGridView extends StatelessWidget {
  final String title;
  final List<PlatformData> socialMedia;
  final bool isMyProfile;

  const ProfileGridView({
    super.key,
    required this.title,
    required this.socialMedia,
    required this.isMyProfile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: AppColor.primary,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 2,
            spreadRadius: 0,
            offset: const Offset(0, 5),
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
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,

                  // physics: const NeverScrollableScrollPhysics(),

                  itemCount: socialMedia.length,
                  shrinkWrap: true,
                  itemBuilder: (context, pIndex) {
                    return GestureDetector(
                        onTap: () {
                          isMyProfile
                              ? showCustomBottomSheet(
                                  context: context,
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          AppText(
                                            text:
                                                socialMedia[pIndex].name ?? '',
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          InkWell(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              onTap: () {
                                                back(context);
                                              },
                                              child: SvgPicture.asset(
                                                  Assets.icCloseCircle))
                                        ],
                                      ),
                                      // 10.verticalSpace,

                                      Text("==${socialMedia[pIndex].icon}"),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: context.height * .03),
                                        child: CustomLabelTextField(
                                            labelText: socialMedia[pIndex]
                                                    .type ??
                                                '',
                                            controller: TextEditingController(),
                                            prefixWidget:
                                                CustomCacheNetworkImage(
                                                    img: ApiConstants
                                                            .socialIconBaseUrl +
                                                        socialMedia[pIndex]
                                                            .icon!,
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
                                                onTap: () {},
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
                                )
                              : null;
                        },
                        child: Text("asdf :${socialMedia[pIndex].name}")

                        //  ProfileSocialMedia(
                        //   isMyProfile: isMyProfile,
                        //   index: pIndex,
                        //   icon: socialMedia[pIndex].icon ?? 'asdf',
                        //   name: socialMedia[pIndex].name ?? '',
                        // )
                        );
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // 3 columns
                    crossAxisSpacing: isMyProfile ? 50 : 56,
                    mainAxisSpacing: 20,
                    childAspectRatio: isMyProfile ? .6 : .7,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
