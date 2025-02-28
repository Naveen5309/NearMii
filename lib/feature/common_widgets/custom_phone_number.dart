import 'dart:developer';

import 'package:NearMii/config/countries.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/feature/auth/presentation/provider/signup_provider.dart';
import 'package:NearMii/feature/auth/presentation/views/contry_picker_view.dart';
import 'package:NearMii/feature/common_widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../auth/presentation/provider/states/country_code_provider.dart';

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
  final Function(String, String)? onCountryCodeChanged;
  final String selectedCountryCode; // Country Code from parameter
  final String selectedCountryFlag; // Country Flag from parameter

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
    this.onCountryCodeChanged,
    required this.selectedCountryCode, // Required parameter
    required this.selectedCountryFlag, // Required parameter
  });

  @override
  _CustomPhoneNumberState createState() => _CustomPhoneNumberState();
}

class _CustomPhoneNumberState extends State<CustomPhoneNumber> {
  final FocusNode _focusNode = FocusNode();
  bool textEditHasFocus = false;
  bool isTextFieldEmpty = true;
  // late String selectedCountryCode;
  // late String selectedCountryFlag;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onTextChanged);
    _focusNode.addListener(() {
      setState(() {
        textEditHasFocus = _focusNode.hasFocus;
      });
    });

    // Initialize from widget parameters
    // selectedCountryCode = widget.selectedCountryCode;
    // selectedCountryFlag = widget.selectedCountryFlag;
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

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        ref.watch(countryPickerProvider);
        ref.watch(signupProvider);

        final countryNotifier = ref.read(countryPickerProvider.notifier);
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
                  onTap: () async {
                    Country? result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CountryPickerView(),
                      ),
                    );

                    if (result != null) {
                      log("data s :-. ${result.dialCode}");
                      ref.read(signupProvider.notifier).updateCountryData(
                          dialCode: result.dialCode ?? "+1",
                          countryNmCode: result.code ?? "US");
                    }
                  },
                  child: Row(
                    children: [
                      const SizedBox(width: 5),
                      AppText(
                        text: countryNotifier.country.flag ?? "",
                        fontSize: 20.sp,
                      ),
                      const SizedBox(width: 5),
                      AppText(
                        text: countryNotifier.country.dialCode ?? "",
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
                      style: TextStyle(
                          fontSize: 14.sp, fontWeight: FontWeight.w500),
                      decoration: InputDecoration(
                        counterText: '',
                        fillColor: AppColor.greyFAFAFA,
                        border: InputBorder.none,
                        hintText: widget.labelText,
                        hintStyle: TextStyle(
                          color: AppColor.green173E01.withOpacity(.4),
                          fontSize: 12.sp,
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 15),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
