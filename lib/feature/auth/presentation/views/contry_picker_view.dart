import 'dart:developer';

import 'package:NearMii/config/helper.dart';
import 'package:NearMii/feature/auth/presentation/provider/signup_provider.dart';
import 'package:NearMii/feature/auth/presentation/provider/states/country_code_provider.dart';
import 'package:NearMii/feature/auth/presentation/provider/states/country_code_states.dart';
import 'package:NearMii/feature/common_widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CountryPickerView extends ConsumerStatefulWidget {
  const CountryPickerView({super.key});

  @override
  ConsumerState<CountryPickerView> createState() => _CountryPickerViewState();
}

class _CountryPickerViewState extends ConsumerState<CountryPickerView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        ref.read(countryPickerProvider.notifier).getCountries();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final county = ref.watch(countryPickerProvider);
    ref.watch(signupProvider.notifier);
    return Scaffold(
      appBar: AppBar(
          elevation: 1,
          backgroundColor: AppColor.appThemeColor,
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
          ),
          title: TextField(
            controller:
                ref.read(countryPickerProvider.notifier).searchController,
            onChanged: (val) {
              ref.read(countryPickerProvider.notifier).getCountries();
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide:
                    const BorderSide(color: AppColor.greyf9f9f9, width: 1.5),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide:
                    const BorderSide(color: AppColor.greyf9f9f9, width: 1.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: const BorderSide(
                    color: AppColor.primary, width: 2), // Highlight on focus
              ),
              fillColor: AppColor.greyf9f9f9,
              filled: true,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              hintText: "Search country...",
              hintStyle: TextStyle(color: Colors.grey[500]),
            ),
          )),
      body: Builder(
        builder: (context) {
          if (county is CountryPickerLoading) {
            return customLoader();
          } else if (county is CountryPickerLoaded) {
            return RawScrollbar(
              thumbColor: AppColor.grey21203F,
              radius: const Radius.circular(20),
              thickness: 5,
              child: ListView.builder(
                itemCount: county.countryList.length,
                itemBuilder: (_, index) {
                  var data = county.countryList[index];
                  return ListTile(
                    dense: true,
                    contentPadding: const EdgeInsets.only(left: 20, right: 20),
                    onTap: () {
                      log("selected country:-> ${data.dialCode}");

                      ref
                          .read(countryPickerProvider.notifier)
                          .makeInitialCountry(data);

                      Navigator.pop(context, data);
                    },
                    leading: AppText(
                      text: data.flag ?? "",
                      fontSize: 16.sp,
                    ),
                    title: AppText(
                      text: data.name ?? "",
                      fontSize: 13.sp,
                      fontFamily: AppString.fontFamily,
                    ),
                    subtitle: AppText(
                      text: data.dialCode ?? '',
                      fontSize: 13.sp,
                      color: Colors.blue,
                      fontFamily: AppString.fontFamily,
                    ),
                  );
                },
              ),
            );
          } else if (county is CountryPickerFailed) {
            return Text(county.error);
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
