import 'package:NearMii/config/assets.dart';
import 'package:NearMii/config/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomProfileWidget extends StatelessWidget {
  const CustomProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColor.btnColor, borderRadius: BorderRadius.circular(100)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SvgPicture.asset(Assets.icUserWhite),
      ),
    );
  }
}
