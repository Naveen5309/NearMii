import 'package:NearMii/config/assets.dart';
import 'package:NearMii/config/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomSearchBarWidget extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const CustomSearchBarWidget({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 16,
        bottom: 16,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(88),
        boxShadow: [
          BoxShadow(
            color: AppColor.grey999.withOpacity(.16),
            spreadRadius: 0, // No spread
            blurRadius: 7, // Soft blur
            offset: const Offset(0, 5), // Shadow only at the bottom
          ),
        ],
        color: AppColor.primary,
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        autofocus: false,
        decoration: InputDecoration(
          hintText: AppString.searchHere,
          hintStyle: TextStyle(
            color: AppColor.green173E01.withOpacity(.3),
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(11.0),
            child: SvgPicture.asset(
              Assets.icSearch,
              colorFilter: const ColorFilter.mode(
                AppColor.greenB9c5b3,
                BlendMode.srcIn,
              ),
            ),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
        ),
      ),
    );
  }
}
