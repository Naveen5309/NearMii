import 'package:NearMii/config/assets.dart';
import 'package:NearMii/config/constants.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/feature/common_widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ChooseImageWidget extends StatelessWidget {
  final VoidCallback onClickOnGallery;
  final VoidCallback onClickOnCamera;

  const ChooseImageWidget(
      {super.key,
      required this.onClickOnGallery,
      required this.onClickOnCamera});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          color: AppColor.primary,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          10.verticalSpace,
          SvgPicture.asset(Assets.lineBar),
          10.verticalSpace,
          AppText(
            text: AppString.chooseImage,
            fontFamily: Constants.fontFamilyHankenGrotesk,
            fontWeight: FontWeight.w900,
            fontSize: 24.sp,
            lineHeight: 1.5,
            textAlign: TextAlign.center,
          ),
          // const SizedBox(height: 20),
          20.verticalSpace,
          Padding(
            padding: EdgeInsets.only(bottom: context.height * .02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    onClickOnCamera();
                  },
                  child: Row(
                    children: [
                      SizedBox(
                          width: 40,
                          height: 40,
                          child: SvgPicture.asset(
                            Assets.cameraImage,
                          )),
                      const SizedBox(width: 10),
                      Expanded(
                        child: AppText(
                          text: AppString.takeAPhoto,
                          fontSize: 16.sp,
                          fontFamily: Constants.fontFamilyHankenGrotesk,
                          fontWeight: FontWeight.w600,
                          color: AppColor.grey212121.withValues(alpha: 0.5),
                        ),
                      ),
                      Image.asset(Assets.iconArrowRight)
                    ],
                  ),
                ),
                10.verticalSpace,
                InkWell(
                  onTap: () {
                    onClickOnGallery();
                  },

                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                          width: 40,
                          height: 40,
                          child: SvgPicture.asset(
                            Assets.gallery,
                          )),
                      const SizedBox(width: 10),
                      Expanded(
                        child: AppText(
                          fontSize: 16.sp,
                          text: AppString.uploadfromGallery,
                          fontFamily: Constants.fontFamilyHankenGrotesk,
                          fontWeight: FontWeight.w600,
                          color: AppColor.grey212121.withValues(alpha: 0.5),
                        ),
                      ),
                      Image.asset(Assets.iconArrowRight)
                    ],
                  ),
                  // child: Row(
                  //   children: [
                  //     //CAMERA
                  //     Expanded(
                  //       child: Container(
                  //         decoration: BoxDecoration(
                  //             color: AppColor.green00C56524.withOpacity(.14),
                  //             borderRadius: BorderRadius.circular(30),
                  //             border: Border.all(
                  //                 color: AppColor.green00C56524.withOpacity(.14))),
                  //         child: Column(
                  //           children: [
                  //             Padding(
                  //               padding: EdgeInsets.symmetric(
                  //                   vertical: context.width * .05),
                  //               child: const Icon(
                  //                 Icons.camera_alt_outlined,
                  //                 size: 50,
                  //                 color: AppColor.appThemeColor,
                  //               ),
                  //             ),
                  //             CommonAppBtn(
                  //               textColor: AppColor.btnColor,
                  //               backGroundColor:
                  //                   AppColor.green00C56524.withOpacity(.14),
                  //               onTap: onClickOnCamera,
                  //               title: AppString.camera,
                  //               width: context.width,
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //     10.horizontalSpace,

                  //     //GALLERY
                  //     Expanded(
                  //       child: Container(
                  //         decoration: BoxDecoration(
                  //             color: AppColor.green00C56524.withOpacity(.14),
                  //             borderRadius: BorderRadius.circular(30),
                  //             border: Border.all(
                  //                 color: AppColor.green00C56524.withOpacity(.14))),
                  //         child: Column(
                  //           children: [
                  //             Padding(
                  //               padding: EdgeInsets.symmetric(
                  //                   vertical: context.width * .05),
                  //               child: const Icon(
                  //                 Icons.photo_library_sharp,
                  //                 color: AppColor.appThemeColor,
                  //                 size: 50,
                  //               ),
                  //             ),
                  //             CommonAppBtn(
                  //               onTap: onClickOnGallery,
                  //               title: AppString.gallery,
                  //               width: context.width,
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ),
                // const SizedBox(height: 20),
              ],
            ),
          )
        ]));
  }
}
