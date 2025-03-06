import 'package:NearMii/config/helper.dart';
import 'package:flutter/material.dart';

class CustomBottomSheet extends StatelessWidget {
  final Widget content;
  final Color? color;
  final EdgeInsetsGeometry? contentPadding;

  const CustomBottomSheet(
      {super.key, required this.content, this.color, this.contentPadding});

  @override
  Widget build(BuildContext context) {
    return color != null
        ? Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20), // Top left and right radius
              ),
              // border: Border(
              //   top: BorderSide(
              //     color: AppColor.primary, // Border color
              //     width: 1.0, // Border width
              //   ),
              //   left: BorderSide(
              //     color: AppColor.primary, // Border color
              //     width: 1.0, // Border width
              //   ),
              //   right: BorderSide(
              //     color: AppColor.primary, // Border color
              //     width: 1.0, // Border width
              //   ),
              // ),
            ),
            padding: contentPadding ??
                EdgeInsets.symmetric(
                    vertical: context.height * .01,
                    horizontal: context.width * .05),
            child: content,
          )
        : Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20), // Top left and right radius
              ),
              // border: Border(
              //   top: BorderSide(
              //     color: AppColor.primary, // Border color
              //     width: 1.0, // Border width
              //   ),
              //   left: BorderSide(
              //     color: AppColor.primary, // Border color
              //     width: 1.0, // Border width
              //   ),
              //   right: BorderSide(
              //     color: AppColor.primary, // Border color
              //     width: 1.0, // Border width
              //   ),
              // ),
            ),
            padding: contentPadding ??
                EdgeInsets.symmetric(
                    vertical: context.height * .02,
                    horizontal: context.width * .05),
            child: content,
          );
  }
}

void showCustomBottomSheet(
    {required BuildContext context,
    required Widget content,
    Color? color,
    final EdgeInsetsGeometry? contentPadding,
    double? radius}) {
  showModalBottomSheet(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    context: context,
    isScrollControlled: true,
    builder: (
      BuildContext context,
    ) {
      return Container(
          decoration: color != null
              ? BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(radius ?? 20),
                    topRight: Radius.circular(radius ?? 20),
                  ),
                  color: color)
              : const BoxDecoration(
                  color: AppColor.primary,

                  // gradient: LinearGradient(
                  //   colors: AppColor.splashGradientColor,
                  //   begin: Alignment.topCenter,
                  //   end: Alignment.bottomCenter,
                  // ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context)
                  .viewInsets
                  .bottom, // Adjusts for the keyboard
            ),
            child: CustomBottomSheet(
              content: content,
              color: color,
              contentPadding: contentPadding,
            ),
          ));
    },
  );
}
