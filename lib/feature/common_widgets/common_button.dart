import 'package:NearMii/config/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonAppBtn extends StatefulWidget {
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

  const CommonAppBtn(
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
  State<CommonAppBtn> createState() => CommonAppBtnState();
}

class CommonAppBtnState extends State<CommonAppBtn> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: null,
      onTap: (widget.loading ?? false) ? null : widget.onTap,
      child: Container(
        width: widget.width ?? context.width,
        height: widget.height ?? 60,
        margin: widget.margin,
        decoration: BoxDecoration(
          color: widget.backGroundColor ?? AppColor.appThemeColor,
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 50.0),
          boxShadow: widget.boxShadow,
          border: Border.all(
            color: widget.borderColor ?? AppColor.appThemeColor,
            width: widget.borderWidth ?? 0,
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
                            fontSize: widget.textSize ?? 16.sp,
                            color: widget.textColor ?? AppColor.primary,
                            fontWeight: FontWeight.w500,
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
                          fontSize: widget.textSize ?? 16.sp,
                          color: widget.textColor ?? AppColor.primary,
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
