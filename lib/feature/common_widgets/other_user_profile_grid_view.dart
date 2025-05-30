import 'package:NearMii/config/app_utils.dart';
import 'package:NearMii/feature/other_user_profile/presentation/states_notifier/other_user_profile_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/feature/auth/data/models/get_my_platform_model.dart';
import 'package:NearMii/feature/common_widgets/app_text.dart';
import 'package:NearMii/feature/common_widgets/profile_social_media.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:url_launcher/url_launcher.dart';

class OtherUserProfileGridView extends ConsumerWidget {
  final String title;
  final List<SelfPlatformData> socialMedia;
  final TextEditingController controller;
  final OtherUserProfileNotifier notifier;

  const OtherUserProfileGridView({
    super.key,
    required this.title,
    required this.socialMedia,
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
            color: AppColor.black000000.withValues(alpha: 0.03),
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
                        onTap: () async {
                          String? url = socialMedia[pIndex].url;
                          printLog(
                              "Click on url is :-> ${socialMedia[pIndex].platform?.name}");
                          printLog(
                              "Click on url is :-> ${socialMedia[pIndex].url}");

                          if ((socialMedia[pIndex].platform?.name ==
                                  "Whatsapp") &&
                              (socialMedia[pIndex].platform?.type ==
                                  "Enter phone number")) {
                            await launchUrl(Uri.parse(
                                "https://wa.me/${socialMedia[pIndex].url}"));
                          } else if (socialMedia[pIndex].platform?.type ==
                              "Enter phone number") {
                            CallUtils.openDialer(url!.trim());
                          } else if (socialMedia[pIndex].platform?.type ==
                              "Enter email address") {
                            final Uri emailLaunchUri = Uri(
                              scheme: 'mailto',
                              path: '$url',
                              query: encodeQueryParameters(<String, String>{
                                'subject': 'Join me in NearMii',
                              }),
                            );
                            await launchUrl(emailLaunchUri);
                          } else {
                            // Ensure the URL is not null and formatted correctly
                            if (url != null && url.isNotEmpty) {
                              if (!url.startsWith("http://") &&
                                  !url.startsWith("https://")) {
                                url = "https://www.$url";
                              }

                              await launchUrl(Uri.parse(url));
                            } else {
                              printLog("Invalid URL");
                            }
                          }
                        },
                        child: AnimationConfiguration.staggeredGrid(
                          position: pIndex,
                          duration: const Duration(milliseconds: 300),
                          columnCount: socialMedia.length,
                          child: ScaleAnimation(
                            child: FadeInAnimation(
                              child: ProfileSocialMedia(
                                onToggleChanged: (p0) {},
                                isToggled:
                                    socialMedia[pIndex].platform?.status == 1
                                        ? true
                                        : false,
                                isMyProfile: false,
                                index: pIndex,
                                icon: socialMedia[pIndex].platform?.icon ?? '',
                                name: socialMedia[pIndex]
                                        .platform
                                        ?.name
                                        ?.split(' ')
                                        .first ??
                                    '',
                              ),
                            ),
                          ),
                        ));
                  },
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // 3 columns
                    crossAxisSpacing: 50,
                    mainAxisSpacing: 20,
                    childAspectRatio: .7,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
