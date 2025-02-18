import 'package:NearMii/config/assets.dart';
import 'package:NearMii/config/enums.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/core/network/http_service.dart';
import 'package:NearMii/feature/auth/data/models/get_platform_model.dart';
import 'package:NearMii/feature/auth/presentation/provider/signup_provider.dart';
import 'package:NearMii/feature/auth/presentation/provider/state_notifiers/signup_notifiers.dart';
import 'package:NearMii/feature/auth/presentation/provider/states/auth_states.dart';
import 'package:NearMii/feature/common_widgets/app_text.dart';
import 'package:NearMii/feature/common_widgets/common_button.dart';
import 'package:NearMii/feature/common_widgets/custom_bottom_sheet.dart';
import 'package:NearMii/feature/common_widgets/custom_cache_network.dart';
import 'package:NearMii/feature/common_widgets/custom_label_text_field.dart';
import 'package:NearMii/feature/common_widgets/custom_toast.dart';
import 'package:NearMii/feature/common_widgets/social_media_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomSocialGridview extends ConsumerWidget {
  final String title;
  final List<PlatformData> socialMedia;
  final SignupNotifiers notifier;

  const CustomSocialGridview({
    super.key,
    required this.title,
    required this.socialMedia,
    required this.notifier,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(signupProvider);
    final notifier = ref.watch(signupProvider.notifier);
    ref.listen(
      signupProvider,
      (previous, next) {
        if (next is AuthApiLoading && next.authType == AuthType.addPlatform) {
          showDialog(
            context: context,
            builder: (context) {
              return Center(
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.0),
                      color: AppColor.primary,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(28.0),
                      child: CircularProgressIndicator.adaptive(),
                    )),
              );
            },
          );
        } else if (next is AuthApiSuccess &&
            next.authType == AuthType.addPlatform) {
          back(context);

          toast(msg: AppString.platformUpdateSuccess, isError: false);

          // toNamed(context, Routes.bottomNavBar);
        } else if (next is AuthApiFailed &&
            next.authType == AuthType.addPlatform) {
          back(context);
          toast(msg: next.error);
        }
      },
    );

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
                          notifier.urlController.clear();
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
                                      controller: notifier.urlController,
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
                                            var isValid =
                                                notifier.validateAddPlatform();

                                            if (isValid) {
                                              notifier.addPlatform(
                                                  platformId:
                                                      socialMedia[pIndex]
                                                          .id
                                                          .toString());
                                            }
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
                        child: SizedBox(
                          height: 150,
                          width: 150,
                          child: Stack(children: [
                            SocialMediaProfile(
                              index: pIndex,
                              icon: socialMedia[pIndex].icon ?? '',
                              name: socialMedia[pIndex].name ?? '',
                            ),
                            Visibility(
                              visible: notifier.selectedPlatform
                                  .contains(socialMedia[pIndex].id),
                              child: Positioned(
                                right: 0,
                                top: -2,
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                      color: AppColor.primary,
                                      borderRadius: BorderRadius.circular(100)),
                                  child: SvgPicture.asset(Assets.checkBox),
                                ),
                              ),
                            )
                          ]),
                        ));
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 1.15,
                      crossAxisSpacing: context.width * .12,
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
