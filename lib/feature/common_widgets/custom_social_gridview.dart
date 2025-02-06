import 'package:NearMii/config/helper.dart';
import 'package:NearMii/feature/auth/data/models/get_platform_model.dart';
import 'package:NearMii/feature/common_widgets/app_text.dart';
import 'package:NearMii/feature/common_widgets/social_media_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    return Column(
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
            padding: EdgeInsets.only(top: context.height * .03),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
              ),
            ),
            // margin: const EdgeInsets.all(10.0),
            child: GridView.builder(
              // physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(0.0),
              itemCount: socialMedia.length,
              shrinkWrap: true,
              itemBuilder: (context, pIndex) {
                return GestureDetector(
                    onTap: () {},
                    child: SocialMediaProfile(
                      icon: socialMedia[pIndex].icon ?? '',
                      name: socialMedia[pIndex].name ?? '',
                    ));
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 1.15,
                  crossAxisSpacing: 10,
                  mainAxisExtent: 130,
                  mainAxisSpacing: 10,
                  crossAxisCount: 3),
            ))
      ],
    );
  }
}
