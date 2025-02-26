import 'package:NearMii/config/helper.dart';
import 'package:NearMii/feature/auth/presentation/provider/states/country_code_provider.dart';
import 'package:NearMii/feature/auth/presentation/provider/states/country_code_states.dart';
import 'package:NearMii/feature/common_widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CountryPickerView extends ConsumerWidget {
  const CountryPickerView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final county = ref.watch(countryPickerProvider);
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
                    borderRadius: BorderRadius.circular(15.0)),
                fillColor: AppColor.primary,
                filled: true),
          )),
      body: Builder(
        builder: (context) {
          if (county is CountryPickerLoading) {
            return customLoader();
          } else if (county is CountryPickerLoaded) {
            return RawScrollbar(
              thumbColor: AppColor.primary,
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
