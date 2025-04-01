import 'dart:developer';

import 'package:NearMii/config/app_utils.dart';
import 'package:NearMii/config/assets.dart';
import 'package:NearMii/config/enums.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/core/helpers/all_getter.dart';
import 'package:NearMii/feature/common_widgets/app_text.dart';
import 'package:NearMii/feature/common_widgets/common_button.dart';
import 'package:NearMii/feature/common_widgets/custom_toast.dart';
import 'package:NearMii/feature/common_widgets/custum_thumb.dart';
import 'package:NearMii/feature/home/presentation/provider/home_provider.dart';
import 'package:NearMii/feature/home/presentation/provider/states/home_states.dart';
import 'package:NearMii/feature/setting/presentation/provider/get_profile_provider.dart';
import 'package:NearMii/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class RadiusScreen extends ConsumerStatefulWidget {
  const RadiusScreen({super.key});

  @override
  _RadiusScreenState createState() => _RadiusScreenState();
}

class _RadiusScreenState extends ConsumerState<RadiusScreen> {
  double _currentRadius = 20;
  final List<double> _customIntervals = [20, 40, 60, 80, 100];
  @override
  void initState() {
    super.initState();
    var radiusNotifier = ref.read(getProfileProvider.notifier);
    double savedRadius =
        double.tryParse(radiusNotifier.userProfileModel?.radius ?? '50') ??
            0.05;
    _currentRadius = savedRadius * 1000;
  }

  @override
  Widget build(BuildContext context) {
    // var radiusNotifier = ref.watch(getProfileProvider.notifier);

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
      body: Column(children: [
        Container(
          width: context.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(Assets.icHomePngBg),
            ),
          ),
// height: MediaQuery.sizeOf(context).height * 0.2,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: totalHeight -
                      MediaQuery.of(navigatorKey.currentState!.context)
                          .padding
                          .top,
                ),
                10.verticalSpace,
                SizedBox(
                  width: context.width,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        child: InkWell(
                          onTap: () => back(context),
                          child: Container(
                            alignment: Alignment.centerLeft,
                            width: context.width * .2,
                            child: SvgPicture.asset(
                              Assets.icBackBtn,
                              colorFilter: const ColorFilter.mode(
                                AppColor.primary,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: AppText(
                          text: "Radius",
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColor.primary,
                        ),
                      ),
                    ],
                  ),
                ),
                5.verticalSpace,
              ],
            ),
          ),
        ),

        // const CustomAppbarWidget(
        //   title: AppString.radius,
        //   backButton: true,
        // ),
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
                  color: Colors.white.withValues(
                    alpha: .5,
                  ),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColor.appThemeColor,
                    width: 2,
                  ),
                ),
              ),
            ),
            AppText(
              text: "${_currentRadius.toStringAsFixed(2)} m",
              // "${(double.tryParse(radiusNotifier.userProfileModel?.radius ?? '50')?.toStringAsFixed(2)) ?? '50'} m",

              //  "${_currentRadius.toStringAsFixed(2)} m",
              color: AppColor.btnColor,
            ),
          ],
        ),

        30.verticalSpace,

        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 5, vertical: context.height * .01),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                text: "   20 m",
                fontSize: 12.sp,
                color: (_currentRadius - 20).abs() < 10
                    ? AppColor.green00C56524
                    : AppColor.black000000.withValues(alpha: 0.3),
              ),
              AppText(
                text: "         50 m",
                fontSize: 12.sp,
                color: (_currentRadius - 50).abs() < 3
                    ? AppColor.green00C56524
                    : AppColor.black000000.withValues(alpha: 0.3),
              ),
              // AppText(
              //   text: "   60 m",
              //   fontSize: 12.sp,
              //   color: (_currentRadius - 60).abs() < 1
              //       ? AppColor.green00C56524
              //       : AppColor.black000000.withValues(alpha:0.3),
              // ),
              AppText(
                text: "           80 m",
                fontSize: 12.sp,
                color: (_currentRadius - 80).abs() < 3
                    ? AppColor.green00C56524
                    : AppColor.black000000.withValues(alpha: 0.3),
              ),
              AppText(
                text: "100 m",
                fontSize: 12.sp,
                color: (_currentRadius - 100).abs() < 1
                    ? AppColor.green00C56524
                    : AppColor.black000000.withValues(alpha: 0.3),
              ),
            ],
          ),
        ),

        // Syncfusion Slider
        SfSlider(
          min: 20,
          max: 100,
          value: _currentRadius,
          thumbShape: CustomThumbShape(),
          interval: 20,
          onChangeStart: (value) {
            print(value);
          },
          onChangeEnd: (value) {
            print(value);
          },
          activeColor: AppColor.green00C56524,
          inactiveColor: Colors.grey.shade300,
          minorTicksPerInterval: 0,
          labelFormatterCallback: (dynamic value, String formattedText) {
            return _customIntervals.contains(value) ? "${value.toInt()} m" : "";
          },
          onChanged: (dynamic value) {
            setState(() {
              _currentRadius = _getNearestValue(value);

              // _currentRadius = value;
              // _getNearestValue(value);
            });
          },
        ),
        const Spacer(),

        // Save Button
        CommonAppBtn(
          title: AppString.saveText,
          width: context.width * 0.9,
          onTap: () {
            double lat = Getters.getLocalStorage.getLat() ?? 0.0;
            double lang = Getters.getLocalStorage.getLang() ?? 0.0;

            notifier.updateCoordinates(
                radius: (_currentRadius / 1000).toString(),
                lang: lang,
                lat: lat);
          },
          borderRadius: 50,
          backGroundColor: AppColor.green00C56524,
        ),
        10.verticalSpace,
      ]),
    );
  }

  double _getNearestValue(double value) {
    if (value <= 35) return 20;
    if (value > 35 && value <= 65) return 50;
    if (value > 65 && value <= 90) return 80;
    return 100;
  }
}
