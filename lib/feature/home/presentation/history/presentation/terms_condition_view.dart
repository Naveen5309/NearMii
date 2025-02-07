import 'package:NearMii/config/constants.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/feature/common_widgets/app_text.dart';
import 'package:NearMii/feature/common_widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TermsConditionView extends StatelessWidget {
  const TermsConditionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: AppString.termsAndConditions),
      backgroundColor: AppColor.primary,
      body: SingleChildScrollView(
        child: Column(
          children: [
            textSection(context),
            textSection(context),
          ],
        ),
      ),
    );
  }
}

Widget textSection(BuildContext context) {
  return Padding(
    padding: EdgeInsets.symmetric(
        horizontal: context.width * 0.06, vertical: context.width * 0.05),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        AppText(
          text: 'Lorem ipsum dolor sit amet',
          fontFamily: Constants.fontFamily,
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
        11.verticalSpace,

        // Paragraphs
        AppText(
            fontFamily: Constants.fontFamily,
            text:
                'Lorem ipsum dolor sit amet consectetur. Dui etiam tempus scelerisque donec nisl vitae. Amet nulla etiam arcu aliquam. Velit eleifend in varius dignissim. Et et donec elit nec. Hac ullamcorper enim diam nunc mattis. At sagittis consequat viverra sit amet consectetur. Urna id commodo quisque semper feugiat. At sagittis et quis porta eget sit sem molestie. Quam praesent a id diam nec a vitae. Nisi donec elit dictum aliquet facilisi. Sodales feugiat odio nibh duis nec. Lobortis sed tellus eget a diam ultricies amet. Turpis arcu massa turpis nunc metus placerat ipsum. Viverra aenean cursus diam ut facilisi lobortis semper eget scelerisque. Et sed elit auctor nibh sed suscipit turpis. Praesent facilisis pellentesque viverra mollis pharetra mollis quam. Massa felis faucibus sed blandit gravida. Id sem orci eget nisi nunc leo enim nec augue. Diam pulvinar ipsum nam malesuada amet aliquam diam. Feugiat egestas commodo maecenas dictumst molestie egestas.',
            fontSize: 12.sp,
            color: AppColor.black000000.withValues(alpha: 0.6),
            fontWeight: FontWeight.w500),
      ],
    ),
  );
}
