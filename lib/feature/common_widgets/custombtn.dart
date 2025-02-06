import 'package:NearMii/config/constants.dart';
import 'package:NearMii/config/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatefulWidget {
  final String? title;
  final double? borderRadius;
  final Widget? child;
  final double? textPadding;
  final EdgeInsetsGeometry? customPadding;
  final bool? loading;
  final double? width;
  final double? loaderWidth;
  final double? loaderHeight;
  final double? height;
  final VoidCallback? onTap;
  final Color? backGroundColor;
  final Color? loaderColor;
  final Color? borderColor;
  final Color? textColor;
  final double? textSize;
  final double? borderWidth;
  final TextStyle? titleStyle;
  final List<BoxShadow>? boxShadow;
  final Widget? prefixWidget;
  final TextStyle? testStyle;

  final EdgeInsetsGeometry? margin;

  const CustomButton(
      {super.key,
      this.title,
      this.onTap,
      this.backGroundColor,
      this.titleStyle,
      this.textColor,
      this.child,
      this.borderColor,
      this.borderWidth,
      this.loaderWidth,
      this.loaderHeight,
      this.loading,
      this.borderRadius,
      this.loaderColor,
      this.width,
      this.height,
      this.textPadding,
      this.customPadding,
      this.boxShadow,
      this.textSize,
      this.margin,
      this.testStyle,
      this.prefixWidget});

  @override
  State<CustomButton> createState() => CustomButtonState();
}

class CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: null,
      onTap: (widget.loading ?? false) ? null : widget.onTap,
      child: Container(
        width: widget.width ?? context.width,
        height: widget.height ?? 50,
        margin: widget.margin,
        decoration: BoxDecoration(
          color: widget.backGroundColor ?? AppColor.redF8E2E2,
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 88.0),
          boxShadow: widget.boxShadow,
          border: Border.all(
            color: widget.borderColor ?? AppColor.redE40505,
            width: widget.borderWidth ?? 1,
          ),
        ),
        child: widget.prefixWidget != null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  widget.prefixWidget!,
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      (widget.title ?? "Button Text"),
                      style: widget.titleStyle ??
                          TextStyle(
                            fontSize: 16.sp,
                            color: widget.textColor ?? AppColor.primary,
                            fontWeight: FontWeight.w600,
                          ),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              )
            : Padding(
                padding: widget.customPadding ??
                    EdgeInsets.all(widget.textPadding ?? 0),
                child: Center(
                  child: Text(
                    (widget.title ?? "Button Text"),
                    style: widget.titleStyle ??
                        TextStyle(
                          fontFamily: Constants.fontFamily,
                          fontSize: 16.sp,
                          color: widget.textColor ?? AppColor.redE40505,
                          fontWeight: FontWeight.w600,
                        ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
      ),
    );
  }
}
