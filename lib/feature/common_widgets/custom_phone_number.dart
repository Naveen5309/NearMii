import 'package:NearMii/config/countries.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/feature/common_widgets/app_text.dart';
import 'package:NearMii/feature/common_widgets/custom_countries_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomPhoneNumber extends StatefulWidget {
  final TextEditingController controller;
  final InputBorder? border;
  final InputBorder? enableBorder;
  final InputBorder? focusBorder;
  final String? labelText;
  final String prefixIcon;
  final String? suffixIcon;
  final bool? readOnly;
  final VoidCallback? onTapOnSuffixIcon;
  final VoidCallback? onTapOnPrefixIcon;
  final Function(String, String)? onCountryCodeChanged; // Added Callback

  const CustomPhoneNumber({
    super.key,
    required this.controller,
    this.border,
    this.enableBorder,
    this.focusBorder,
    this.labelText,
    this.readOnly,
    this.suffixIcon,
    this.onTapOnPrefixIcon,
    this.onTapOnSuffixIcon,
    required this.prefixIcon,
    this.onCountryCodeChanged, // Added Callback
  });

  @override
  _CustomPhoneNumberState createState() => _CustomPhoneNumberState();
}

class _CustomPhoneNumberState extends State<CustomPhoneNumber> {
  final FocusNode _focusNode = FocusNode();
  bool textEditHasFocus = false;
  bool isTextFieldEmpty = true;
  String selectedCountryCode = "+1"; // Default Country Code
  String selectedCountryFlag = "🇺🇸"; // Default Country Flag

  @override
  void initState() {
    super.initState();
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
    widget.controller.removeListener(_onTextChanged);
    _focusNode.dispose();
    super.dispose();
  }

  void _showCountryPicker() {
    showModalBottomSheet(
      shape:
          ContinuousRectangleBorder(borderRadius: BorderRadius.circular(60.0)),
      enableDrag: true,
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(12),
          height: MediaQuery.of(context).size.height * 0.8,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: context.width * .02),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                      text: AppString.selectCountry,
                      fontSize: 20.sp,
                    ),
                    IconButton(
                      onPressed: () {
                        back(context);
                      },
                      icon: Icon(
                        Icons.cancel,
                        size: 30.sp,
                        color: Colors.red,
                      ),
                    ).align(alignment: Alignment.centerRight),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: allCountries.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var data = allCountries[index];
                      return CountryTile(
                        flag: data.flag!,
                        countryDialCode: data.dialCode!,
                        countryName: data.name!,
                        isSelected: data.code == selectedCountryCode,
                        onTap: () {
                          setState(() {
                            selectedCountryCode = data.dialCode!;
                            selectedCountryFlag = data.flag!;
                          });

                          // Trigger Callback when country code changes
                          if (widget.onCountryCodeChanged != null) {
                            widget.onCountryCodeChanged!(
                                selectedCountryCode, selectedCountryFlag);
                          }

                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusNode.unfocus();
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.greyFAFAFA,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            color: textEditHasFocus
                ? AppColor.appThemeColor
                : AppColor.green173E01.withOpacity(.4),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Row(
          children: [
            GestureDetector(
              onTap: _showCountryPicker,
              child: Row(
                children: [
                  const SizedBox(width: 5),
                  AppText(
                    text: selectedCountryFlag,
                    fontSize: 20.sp,
                  ),
                  const SizedBox(width: 5),
                  AppText(
                    text: selectedCountryCode,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColor.green173E01,
                  ),
                  Icon(
                    Icons.keyboard_arrow_down,
                    size: 18.sp,
                    color: AppColor.green173E01,
                  ),
                  const ColoredBox(
                    color: AppColor.grey9EAE95,
                    child: VerticalDivider(
                      endIndent: 20,
                      indent: 10,
                      width: 1,
                      thickness: 5,
                      color: AppColor.black000000,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: TextField(
                  keyboardType: TextInputType.phone,
                  maxLength: 15,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  readOnly: widget.readOnly ?? false,
                  focusNode: _focusNode,
                  controller: widget.controller,
                  cursorColor: Colors.green,
                  style:
                      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    counterText: '',
                    fillColor: AppColor.greyFAFAFA,
                    border: InputBorder.none,
                    hintText: widget.labelText,
                    hintStyle: TextStyle(
                      color: AppColor.green173E01.withOpacity(.4),
                      fontSize: 12.sp,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 15),
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
