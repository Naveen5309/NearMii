import 'package:NearMii/config/assets.dart';
import 'package:NearMii/config/constants.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/feature/common_widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBackPress;
  final Color? backgroundColor;

  const CustomAppBar({
    super.key,
    required this.title,
    this.onBackPress,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      leadingWidth: 55,
      backgroundColor: backgroundColor ?? AppColor.whiteFFFFFF,
      elevation: 0,
      centerTitle: true,
      leading: GestureDetector(
          onTap: onBackPress ?? () => Navigator.pop(context),
          child: Padding(
            padding: const EdgeInsets.only(left: 18),
            child: SvgPicture.asset(Assets.iconBackBtn),
          )),
      title: AppText(
        text: title,
        color: AppColor.black000000,
        fontSize: 20.sp,
        fontFamily: Constants.fontFamily,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
