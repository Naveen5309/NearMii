import 'package:NearMii/config/assets.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/feature/common_widgets/app_text.dart';
import 'package:NearMii/feature/common_widgets/common_button.dart';
import 'package:NearMii/feature/common_widgets/common_text_field.dart';
import 'package:NearMii/feature/common_widgets/custom_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Custom Bottom Sheet',
        home: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bottom Sheet Example")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showCustomBottomSheet(
                context: context,
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AppText(
                          text: "Report",
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700),
                    ),
                    CustomBottomSheet(
                      title: AppString.theyArePretending,
                      check: true,
                    ),
                    CustomBottomSheet(
                      title: AppString.theyAreUnderTheAge,
                      check: false,
                    ),
                    CustomBottomSheet(
                      title: AppString.violenceAndDangerous,
                      check: false,
                    ),
                    CustomBottomSheet(
                      title: AppString.hateSpeech,
                      check: false,
                    ),
                    CustomBottomSheet(
                      title: AppString.nudity,
                      check: false,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 15,
                        ),
                        AppText(
                            text: "Something Else",
                            fontSize: 14.sp,
                            color: AppColor.black1A1C1E,
                            fontWeight: FontWeight.w700),
                      ],
                    ),
                    CustomTextFieldWidget(
                      enableBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      maxLines: 4,
                      fillColor: AppColor.whiteF0F5FE,
                      hintText: "Lorem ipsum dolor sit......",
                    ),
                    const CommonAppBtn(
                      title: AppString.submit,
                    )
                  ],
                ));
          },
          child: const AppText(text: "Show Bottom Sheet"),
        ),
      ),
    );
  }
}

class CustomBottomSheet extends StatelessWidget {
  final String title;
  final bool check;

  CustomBottomSheet({
    required this.title,
    required this.check,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(7),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // First option
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                text: title,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
              check
                  ? SvgPicture.asset(Assets.checkTrue)
                  : SvgPicture.asset(Assets.checkFalse)
            ],
          ),
        ],
      ),
    );
  }
}
