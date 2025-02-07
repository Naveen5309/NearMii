import 'package:NearMii/config/helper.dart';
import 'package:NearMii/feature/common_widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomTextformFeild extends StatefulWidget {
  final TextEditingController controller;
  final InputBorder? border;
  final InputBorder? enableBorder;
  final InputBorder? focusBorder;
  final String? labelText;
  final String? prefixIcon;

  final Widget? prefixWidget;

  final String? suffixIcon;
  final bool? readOnly;
  final VoidCallback? onTapOnSuffixIcon;
  final VoidCallback? onTapOnPrefixIcon;
  final int? maxLines;
  final double? radius;
  const CustomTextformFeild(
      {super.key,
      required this.controller,
      this.border,
      this.enableBorder,
      this.focusBorder,
      this.labelText,
      this.readOnly,
      this.prefixWidget,
      this.suffixIcon,
      this.onTapOnPrefixIcon,
      this.onTapOnSuffixIcon,
      this.prefixIcon,
      this.maxLines,
      this.radius});

  @override
  _CustomLabelTextFieldState createState() => _CustomLabelTextFieldState();
}

class _CustomLabelTextFieldState extends State<CustomTextformFeild> {
  final FocusNode _focusNode = FocusNode();
  bool textEditHasFocus = false;
  bool isTextFieldEmpty = true; // To track if the text field is empty

  @override
  void initState() {
    super.initState();
    // Listen to the text field controller for changes
    widget.controller.addListener(_onTextChanged);
    _focusNode.addListener(() {
      setState(() {
        textEditHasFocus = _focusNode.hasFocus;
      });
    });
  }

  void _onTextChanged() {
    setState(() {
      isTextFieldEmpty = widget.controller.text.isEmpty;
    });
  }

  @override
  void dispose() {
    // Don't forget to remove the listener to avoid memory leaks
    widget.controller.removeListener(_onTextChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusNode.unfocus();
      },
      child: Container(
        decoration: const BoxDecoration(color: Colors.white),
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            TextField(
              maxLines: widget.maxLines,
              readOnly: widget.readOnly ?? false,
              textAlign: TextAlign.start, // Ensures text aligns on the left
              cursorColor: AppColor.appThemeColor, // Set cursor color here

              style: TextStyle(
                color: AppColor.green173E01,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
              focusNode: _focusNode,
              controller: widget.controller,
              decoration: InputDecoration(
                suffixIconConstraints: const BoxConstraints(
                    maxWidth: 50, maxHeight: 50, minHeight: 25, minWidth: 25),
                suffixIcon: widget.suffixIcon != null
                    ? InkWell(
                        onTap: widget.onTapOnSuffixIcon,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 18.0),
                          child: SvgPicture.asset(
                            widget.suffixIcon!,
                            height: 24,
                            width: 24,
                          ),
                        ),
                      )
                    : const SizedBox(),
                border: widget.border ??
                    OutlineInputBorder(
                      gapPadding: 0,
                      borderSide:
                          const BorderSide(color: AppColor.appThemeColor),
                      borderRadius: BorderRadius.all(
                        Radius.circular(widget.radius ?? 50),
                      ),
                    ),
                enabledBorder: widget.enableBorder ??
                    OutlineInputBorder(
                      borderSide: BorderSide(
                          color: AppColor.green173E01.withOpacity(.4)),
                      borderRadius: BorderRadius.all(
                        Radius.circular(widget.radius ?? 50),
                      ),
                    ),
                focusedBorder: widget.focusBorder ??
                    const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColor.appThemeColor, width: 1.5),
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),

                contentPadding: const EdgeInsets.only(
                    left: 45, right: 20, top: 20, bottom: 20), // Adjust padding
                // hintText: isTextFieldEmpty
                //     ? widget.labelText
                //     : null, // Hide hint when text is entered
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              left: textEditHasFocus || !isTextFieldEmpty ? 14 : 40,
              top: textEditHasFocus || !isTextFieldEmpty ? -8 : 22,
              child: InkWell(
                onTap: () {
                  _focusNode.requestFocus();
                },
                child: Container(
                  padding: const EdgeInsets.only(left: 3, right: 3),
                  color: AppColor.primary,
                  child: AppText(
                    text: widget.labelText ?? '',
                    color: textEditHasFocus
                        ? AppColor.btnColor
                        : AppColor.green173E01.withOpacity(.4),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: widget.onTapOnPrefixIcon,
                  child: Container(
                    // padding: const EdgeInsets.only(top: 10), // Moves the icon up child: Align( alignment: Alignment.topCenter, child: Icon(Icons.mail, color: _isFocused ? Colors.blue : Colors.grey), ), ),
                    padding: const EdgeInsets.only(left: 15, bottom: 72),
                    alignment: Alignment.centerLeft,
                    child: widget.prefixWidget ??
                        SvgPicture.asset(
                          widget.prefixIcon!,
                          colorFilter: ColorFilter.mode(
                            textEditHasFocus
                                ? AppColor.green173E01
                                : AppColor.green173E01.withOpacity(.4),
                            BlendMode.srcIn,
                          ),
                        ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
