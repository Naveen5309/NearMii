import 'package:NearMii/config/assets.dart';
import 'package:NearMii/config/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CommonBackBtn extends StatelessWidget {
  final GestureTapCallback? onTap;
  const CommonBackBtn({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ??
          () {
            back(context);
          },
      child: SvgPicture.asset(Assets.icBackBtn),
    );
  }
}
