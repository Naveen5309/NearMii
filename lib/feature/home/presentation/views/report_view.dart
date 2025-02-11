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
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScreenUtilInit(
      designSize: Size(375, 812),
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
  const HomeScreen({super.key});

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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 5),
                      child: AppText(
                          text: "Report",
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700),
                    ),
                    const CustomBottomSheet(
                      title: AppString.theyArePretending,
                      check: true,
                    ),
                    const CustomBottomSheet(
                      title: AppString.theyAreUnderTheAge,
                      check: false,
                    ),
                    const CustomBottomSheet(
                      title: AppString.violenceAndDangerous,
                      check: false,
                    ),
                    const CustomBottomSheet(
                      title: AppString.hateSpeech,
                      check: false,
                    ),
                    const CustomBottomSheet(
                      title: AppString.nudity,
                      check: false,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 5,
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
                      minLines: 2,
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

  const CustomBottomSheet({
    super.key,
    required this.title,
    required this.check,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
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
