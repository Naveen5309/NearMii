import 'package:NearMii/config/assets.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/feature/common_widgets/app_text.dart';
import 'package:NearMii/feature/common_widgets/common_button.dart';
import 'package:NearMii/feature/common_widgets/custom_appbar_widget.dart';
import 'package:NearMii/feature/common_widgets/custum_thumb.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class RadiusScreen extends StatefulWidget {
  const RadiusScreen({super.key});

  @override
  _RadiusScreenState createState() => _RadiusScreenState();
}

class _RadiusScreenState extends State<RadiusScreen> {
  double _currentRadius = 50.0;
  final List<double> _customIntervals = [0, 50, 80, 100];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: CustomAppbarWidget(
      //   toolbarHeight: 30,
      //   leadingWidth: 50,
      //   title: AppString.radius,
      //   centerTitle: true,
      //   // leading: Icon(Icons.arrow_back_outlined),
      // ),
      body: Column(
        children: [
          const CustomAppbarWidget(
            title: AppString.radius,
            backButton: true,
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: context.height * 0.65,
                width: context.width,
                child: Image.asset(
                  Assets.imsMap,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                child: Container(
                  width: _currentRadius * 3,
                  height: _currentRadius * 3,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(
                      .5,
                    ),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.green,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ],
          ),

          13.verticalSpace,
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 22,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  text: "0 m",
                  fontSize: 12.sp,
                  color: (_currentRadius - 0).abs() < 10
                      ? AppColor.green00C56524
                      : AppColor.black000000.withOpacity(0.3),
                ),
                AppText(
                  text: "50 m",
                  fontSize: 12.sp,
                  color: (_currentRadius - 32).abs() < 10
                      ? AppColor.green00C56524
                      : AppColor.black000000.withOpacity(0.3),
                ),
                AppText(
                  text: "80 m",
                  fontSize: 12.sp,
                  color: (_currentRadius - 63).abs() < 10
                      ? AppColor.green00C56524
                      : AppColor.black000000.withOpacity(0.3),
                ),
                AppText(
                  text: "100 m",
                  fontSize: 12.sp,
                  color: (_currentRadius - 100).abs() < 10
                      ? AppColor.green00C56524
                      : AppColor.black000000.withOpacity(0.3),
                ),
              ],
            ),
            // child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       AppText(
            //         text: '0 m',
            //         textSize: 12.sp,
            //         color: _currentRadius == 0
            //             ? AppColor.green00C565
            //             : AppColor.black000000,
            //       ),
            //       ...List.generate(
            //         5,
            //         (index) {
            //           int value = ((index + 1) * 20);
            //           return AppText(
            //             text: '$value m',
            //             textSize: 12.sp,
            //             color: (_currentRadius - value).abs() < 10
            //                 ? AppColor.green00C565
            //                 : AppColor.black000000,
            //           );
            //         },
            //       ),
            //     ]),
          ),

          // Syncfusion Slider
          SfSlider(
            min: 0,
            max: 100,
            value: _currentRadius,
            thumbShape: CustomThumbShape(),
            interval: 50,
            onChangeStart: (value) {
              print(value);
            },
            onChangeEnd: (value) {
              print(value);
            },
            activeColor: AppColor.green00C56524,
            inactiveColor: Colors.grey.shade300,
            minorTicksPerInterval: 50,
            labelFormatterCallback: (dynamic value, String formattedText) {
              return _customIntervals.contains(value)
                  ? "${value.toInt()} m"
                  : "";
            },
            onChanged: (dynamic value) {
              setState(() {
                _currentRadius = _getNearestValue(value);
              });
            },
          ),
          const Spacer(),

          // Save Button
          CommonAppBtn(
            title: AppString.saveText,
            width: context.width * 0.9,
            borderRadius: 50,
            backGroundColor: AppColor.green00C56524,
          ),
          4.verticalSpace,
        ],
      ),
    );
  }

  double _getNearestValue(double value) {
    if (value <= 30) return 0;
    if (value > 30 && value <= 60) return 32;
    if (value > 60 && value <= 90) return 63;
    return 100;
  }
}
