import 'package:NearMii/config/helper.dart';
import 'package:flutter/material.dart';

class BgImageContainer extends StatelessWidget {
  final String bgImage;
  final Widget child;

  const BgImageContainer({
    super.key,
    required this.bgImage,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height,
      width: context.width,
      child: Stack(
        children: [
          // Background Image
          Image.asset(
            bgImage,
            fit: BoxFit.cover,
            height: context.height,
            width: context.width,
          ),
          // Your child widget over the image
          Positioned.fill(child: child),
        ],
      ),
    );
  }
}
