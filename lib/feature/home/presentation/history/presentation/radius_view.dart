import 'dart:developer';

import 'package:NearMii/config/app_utils.dart';
import 'package:NearMii/config/assets.dart';
import 'package:NearMii/config/enums.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/feature/common_widgets/app_text.dart';
import 'package:NearMii/feature/common_widgets/common_button.dart';
import 'package:NearMii/feature/common_widgets/custom_appbar_widget.dart';
import 'package:NearMii/feature/common_widgets/custom_toast.dart';
import 'package:NearMii/feature/common_widgets/custum_thumb.dart';
import 'package:NearMii/feature/home/presentation/provider/home_provider.dart';
import 'package:NearMii/feature/home/presentation/provider/states/home_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class RadiusScreen extends ConsumerStatefulWidget {
  const RadiusScreen({super.key});

  @override
  _RadiusScreenState createState() => _RadiusScreenState();
}

class _RadiusScreenState extends ConsumerState<RadiusScreen> {
  double _currentRadius = 32.0;
  final List<double> _customIntervals = [0, 50, 80, 100];

  @override
  Widget build(BuildContext context) {
    ref.watch(homeProvider);
    var notifier = ref.watch(homeProvider.notifier);

    ref.listen(
      homeProvider,
      (previous, next) {
        if (next is HomeApiLoading && next.homeType == HomeType.coordinates) {
          log("home loader called");
          Utils.showLoader();
        } else if (next is HomeApiSuccess &&
            next.homeType == HomeType.coordinates) {
          toast(msg: AppString.radiusUpdateSuccess, isError: false);

          Utils.hideLoader();
          back(context);

          // toNamed(context, Routes.bottomNavBar);
        } else if (next is HomeApiFailed &&
            next.homeType == HomeType.coordinates) {
          if (context.mounted) {
            Utils.hideLoader();
          }

          toast(msg: next.error);
        }
      },
    );

    return Scaffold(
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
                height: context.height * 0.6,
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
                      color: AppColor.appThemeColor,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ],
          ),

          30.verticalSpace,

          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 22, vertical: context.height * .01),
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
            onTap: () {
              notifier.updateCoordinates(radius: _currentRadius.toString());
            },
            borderRadius: 50,
            backGroundColor: AppColor.green00C56524,
          ),
          10.verticalSpace,
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
