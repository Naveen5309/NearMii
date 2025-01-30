import 'package:NearMii/config/constants.dart';
import 'package:flutter/material.dart';
import '../../config/helper.dart';

enum AppTextStyle { title, medium, regular, small }

class AppText extends StatelessWidget {
  final String text;
  final dynamic color;
  final dynamic underlineColor;
  final AppTextStyle? style;
  final bool? underline;
  final bool? strikeThrough;
  final double? fontSize;
  final bool? capitalise;
  final int? maxlines;
  final TextAlign? textAlign;
  final String? fontFamily;
  final FontWeight? fontWeight;
  final double? lineHeight;
  final FontStyle? fontStyle;
  final double? letterSpacing;
  final TextOverflow? overflow;

  const AppText(
      {super.key,
      required this.text,
      this.color,
      this.style,
      this.maxlines,
      this.textAlign,
      this.underline,
      this.fontSize,
      this.fontFamily,
      this.fontWeight,
      this.lineHeight,
      this.fontStyle,
      this.underlineColor,
      this.strikeThrough,
      this.capitalise,
      this.letterSpacing,
      this.overflow});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Text(
      capitalise != null && capitalise!
          ? text.toString().toUpperCase()
          : text.toString(),
      maxLines: maxlines,
      overflow: maxlines != null ? TextOverflow.ellipsis : null,
      textAlign: textAlign,
      style: getStyle(color ?? AppColor.black000000, fontSize ?? 16),
    );
  }

  TextStyle getStyle(
    Color color,
    double fontSize,
  ) {
    return TextStyle(
        overflow: overflow,
        color: color,
        letterSpacing: letterSpacing,
        fontWeight: fontWeight ?? FontWeight.w500,
        fontSize: fontSize,
        fontStyle: fontStyle ?? FontStyle.normal,
        height: lineHeight ?? 1.0,
        fontFamily: fontFamily ?? Constants.fontFamily,
        decorationColor: underlineColor ?? AppColor.transparent,
        decorationThickness: 1,
        decoration: strikeThrough != null && strikeThrough!
            ? TextDecoration.lineThrough
            : underline != null
                ? TextDecoration.underline
                : null);
  }
}
