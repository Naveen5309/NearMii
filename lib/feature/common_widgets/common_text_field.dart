import 'package:NearMii/config/constants.dart';
import 'package:NearMii/config/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFieldWidget extends StatelessWidget {
  final String? labelText, hintText;
  final EdgeInsets? padding;
  final EdgeInsets? contentPadding;
  final String? initialValue, prefixText, suffixText;
  final Widget? prefixIcon, suffixIcon;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final ValueChanged<String?>? onChanged, onSaved;
  final int? maxLength, maxLines;
  final int minLines;
  final bool? readOnly;
  final List<TextInputFormatter>? inputFormatters;

  final bool addHint, enabled;
  final bool? isDense;
  final bool? isObscure;

  final VoidCallback? onTapOnSuffixIcon;

  final Function()? onTap;
  final InputBorder? border;
  final InputBorder? enableBorder;
  final InputBorder? focusBorder;
  final AutovalidateMode autovalidateMode;
  final BoxConstraints? suffixIconConstraints;
  final EdgeInsets? prefixIconPadding;
  final Color? fillColor;
  final Color? textColor;
  final TextStyle? hintStyle;
  final TextAlign? textAlign;
  final bool isDisable;

  const CustomTextFieldWidget({
    super.key,
    this.labelText,
    this.enableBorder,
    this.focusBorder,
    this.contentPadding,
    this.padding,
    this.hintText,
    this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.isDisable = false,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.onSaved,
    this.maxLength,
    this.maxLines,
    this.minLines = 1,
    this.initialValue,
    this.readOnly,
    this.onTap,
    this.border,
    this.enabled = true,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.addHint = false,
    this.suffixIconConstraints,
    this.prefixText,
    this.suffixText,
    this.isDense,
    this.prefixIconPadding,
    this.fillColor,
    this.textColor,
    this.hintStyle,
    this.inputFormatters,
    this.onTapOnSuffixIcon,
    this.isObscure,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      fontFamily: Constants.fontFamily,
      color: AppColor.primary,
      fontSize: 15,
    );

    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(vertical: 10.0),
      child: Opacity(
        opacity: isDisable ? 0.3 : 1.0,
        child: TextFormField(
          textAlign: textAlign ?? TextAlign.start,
          obscureText: isObscure ?? false,
          onTapOutside: (event) {
            FocusScope.of(context).unfocus();
          },
          onTap: onTap,
          readOnly: readOnly ?? false,
          autofocus: false,
          initialValue: initialValue,
          keyboardType: keyboardType,
          autovalidateMode: autovalidateMode,
          controller: controller,
          onChanged: onChanged,
          minLines: minLines,
          maxLines: maxLines,
          onSaved: onSaved,
          enabled: enabled,
          inputFormatters: inputFormatters ??
              (maxLength == null
                  ? null
                  : [
                      LengthLimitingTextInputFormatter(maxLength),
                      if (keyboardType == TextInputType.number)
                        FilteringTextInputFormatter.digitsOnly,
                    ]),
          decoration: InputDecoration(
            contentPadding: contentPadding ??
                const EdgeInsets.symmetric(
                    vertical: 18.0,
                    horizontal: 20.0), // Adjust the vertical padding as needed
            fillColor: fillColor ?? AppColor.primary,
            filled: true,
            isDense: isDense,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            // border: border ??
            //     const OutlineInputBorder(
            //       gapPadding: 0,
            //       borderSide: BorderSide(color: AppColor.appThemeColor),
            //       borderRadius: BorderRadius.all(Radius.circular(50.0)),
            //     ),
            // enabledBorder: enableBorder ??
            //     const OutlineInputBorder(
            //       borderSide: BorderSide(color: AppColor.appThemeColor),
            //       borderRadius: BorderRadius.all(Radius.circular(50.0)),
            //     ),
            // focusedBorder: focusBorder ??
            //     const OutlineInputBorder(
            //       borderSide:
            //           BorderSide(color: AppColor.appThemeColor, width: 1.5),
            //       borderRadius: BorderRadius.all(Radius.circular(50.0)),
            //     ),
            enabledBorder: InputBorder.none,
            border: InputBorder.none, // Removes the default underline
            focusedBorder: InputBorder.none,
            floatingLabelStyle: TextStyle(
                color: AppColor.appThemeColor,
                fontSize: 12.sp,
                fontWeight: FontWeight.w400),
            // alignLabelWithHint: maxLines == null,
            labelText: addHint
                ? null
                : ((controller?.text != null || !false) ? labelText : null),
            hintText: hintText,
            hintStyle: hintStyle ??
                TextStyle(
                    color: AppColor.green173E01.withOpacity(.4),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400),
            prefixIconConstraints: const BoxConstraints(
              maxHeight: 80,
              maxWidth: 80,
            ),
            prefixIconColor: AppColor.green173E01,
            floatingLabelAlignment: FloatingLabelAlignment.start,

            prefixIcon: prefixIcon == null
                ? null
                : Padding(
                    padding: prefixIconPadding ??
                        const EdgeInsets.symmetric(horizontal: 12),
                    child: prefixIcon,
                  ),
            prefixText: prefixText,
            suffixText: suffixText,
            prefixStyle: textStyle,
            suffixStyle: textStyle,
            suffixIcon: suffixIcon == null
                ? null
                : GestureDetector(
                    onTap: onTapOnSuffixIcon ?? () {},
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15.w, vertical: 10),
                      child: suffixIcon,
                    ),
                  ),
            suffixIconConstraints: suffixIconConstraints ??
                const BoxConstraints(
                  maxHeight: 60,
                  maxWidth: 60,
                ),
          ),
          style: TextStyle(color: textColor ?? AppColor.black000000),
        ),
      ),
    );
  }
}
