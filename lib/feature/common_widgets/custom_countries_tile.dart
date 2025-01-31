import 'package:NearMii/config/helper.dart';
import 'package:NearMii/feature/common_widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CountryTile extends StatelessWidget {
  final String flag; // URL or asset for the flag
  final String countryName;
  final String countryDialCode;

  final bool isSelected;
  final VoidCallback onTap;

  const CountryTile({
    super.key,
    required this.flag,
    required this.countryName,
    required this.isSelected,
    required this.onTap,
    required this.countryDialCode,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          // Flag Image
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(500)),
            child: Container(
              height: 50,
              width: 50,
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  color: AppColor.greenc3e4cc,
                  borderRadius: BorderRadius.circular(500),
                  border: Border.all(
                      width: 1, color: AppColor.primary.withOpacity(.24))),
              alignment: Alignment.center,
              child: Text(
                textAlign: TextAlign.center,
                flag, // The flag emoji as a string
                style: TextStyle(
                  fontSize: 30.sp,
                  // Adjust the size as needed
                ),
              ),
            ),
          ),
          SizedBox(width: context.width * .01),

          // Country Name
          Expanded(
            child: AppText(
              text: countryName,
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
          ),
          //DAIL CODE
          AppText(text: countryDialCode),
          SizedBox(width: context.width * .02),
        ],
      ),
    );
  }
}
