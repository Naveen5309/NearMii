import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:NearMii/config/assets.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/core/network/http_service.dart';
import 'package:NearMii/feature/auth/data/models/get_my_platform_model.dart';
import 'package:NearMii/feature/common_widgets/app_text.dart';
import 'package:NearMii/feature/common_widgets/common_button.dart';
import 'package:NearMii/feature/common_widgets/custom_bottom_sheet.dart';
import 'package:NearMii/feature/common_widgets/custom_cache_network.dart';
import 'package:NearMii/feature/common_widgets/custom_label_text_field.dart';
import 'package:NearMii/feature/common_widgets/profile_social_media.dart';
import 'package:NearMii/feature/self_user_profile/presentation/provider/state_notifier/self_user_profile_notifier.dart';
import 'package:NearMii/feature/setting/presentation/view/delete_account_confirmation_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ProfileGridView extends ConsumerWidget {
  final String title;
  final List<SelfPlatformData> socialMedia;
  final bool isMyProfile;
  final TextEditingController controller;
  final SelfUserProfileNotifier notifier;

  const ProfileGridView({
    super.key,
    required this.title,
    required this.socialMedia,
    required this.isMyProfile,
    required this.controller,
    required this.notifier,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: socialMedia.length,
                  shrinkWrap: true,
                  itemBuilder: (context, pIndex) {
                    return GestureDetector(
                        onTap: () {
                          notifier.platformTextController.text =
                              socialMedia[pIndex].url ?? '';
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
                                            text: socialMedia[pIndex]
                                                    .platform
                                                    ?.name ??
                                                '',
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
                                      const Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10.0),
                                        child: Divider(),
                                      ),
                                      // 10.verticalSpace,
                                      CustomLabelTextField(
                                          labelBckColor: AppColor.primary,
                                          labelText:
                                              "${socialMedia[pIndex].platform?.type}",
                                          controller: controller,
                                          prefixWidget: CustomCacheNetworkImage(
                                              img: socialMedia[pIndex]
                                                          .platform
                                                          ?.icon !=
                                                      null
                                                  ? ApiConstants
                                                          .socialIconBaseUrl +
                                                      socialMedia[pIndex]
                                                          .platform!
                                                          .icon!
                                                  : '',
                                              width: 25,
                                              height: 25,
                                              imageRadius: 10)),

                                      /**--------------------- DELETE AND UPDATE  ---------------- **/
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
                                                  showCustomBottomSheet(
                                                      context: context,
                                                      content:
                                                          DeleteAccountConfirmationView(
                                                              btnText: AppString
                                                                  .delete,
                                                              title: AppString
                                                                  .areYouSurePlatformDelete,
                                                              delete: () {
                                                                back(context);
                                                                notifier.deletePlatformApi(
                                                                    id: socialMedia[
                                                                            pIndex]
                                                                        .id
                                                                        .toString());
                                                              },
                                                              onCancel: () {
                                                                back(context);
                                                              }));
                                                },
                                                title: AppString.delete,
                                                width: context.width,
                                              ),
                                            ),
                                            10.horizontalSpace,

                                            //SEND INVITE
                                            Expanded(
                                              child: CommonAppBtn(
                                                onTap: () {
                                                  var isValid = notifier
                                                      .validateAddPlatform();

                                                  if (isValid) {
                                                    notifier
                                                        .updateSocialLinksApi(
                                                      id: socialMedia[pIndex]
                                                          .id
                                                          .toString(),
                                                    );
                                                  }
                                                },
                                                title: AppString.update,
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
                        child: ProfileSocialMedia(
                          onToggleChanged: (val) {
                            log("p0 :-> $val");
                            notifier.hidePlatformApi(
                                platformId: socialMedia[pIndex].id.toString());
                          },
                          isToggled:
                              socialMedia[pIndex].status == 1 ? true : false,
                          isMyProfile: isMyProfile,
                          index: pIndex,
                          icon: socialMedia[pIndex].platform?.icon ?? '',
                          name: socialMedia[pIndex].platform?.name ?? '',
                        ));
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
