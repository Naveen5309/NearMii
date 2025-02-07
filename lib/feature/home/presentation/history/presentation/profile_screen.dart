import 'package:NearMii/config/assets.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/feature/common_widgets/app_text.dart';
import 'package:NearMii/feature/common_widgets/common_back_btn.dart';
import 'package:NearMii/feature/home/data/models/subscription_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ProfileModel {
  final String name;
  final String designation;
  final String imageUrl;
  final String description;
  final String social;
  final String contact;
  final String portfolio;
  final String finance;
  final String business;

  ProfileModel({
    required this.name,
    required this.designation,
    required this.imageUrl,
    required this.description,
    required this.social,
    required this.contact,
    required this.portfolio,
    required this.finance,
    required this.business,
  });
}

class ProfileCard extends StatefulWidget {
  const ProfileCard({super.key});

  @override
  _ProfileCardState createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  ProfileModel? profile;

  @override
  void initState() {
    super.initState();
    fetchProfileData();
  }

  void fetchProfileData() {
    // Simulating data fetch from an API or database
    setState(() {
      profile = ProfileModel(
        name: 'Brooklyn Simmons',
        designation: 'Designation',
        imageUrl: 'https://picsum.photos/250?image=9',
        description:
            'Lorem ipsum dolor sit amet consectetur. Tempus cursus et tincidunt sollicitudin a eu feugiat sagittis.',
        social: '10',
        contact: '04',
        portfolio: '10',
        finance: '06',
        business: '06',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: profile == null
            ? const CircularProgressIndicator()
            : Container(
                width: MediaQuery.of(context).size.width,
                // height: context.height / .2,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 65),
                decoration: BoxDecoration(
                  // color: Colors.green,
                  image: const DecorationImage(
                      image: AssetImage(Assets.background), fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Row(
                      children: [
                        CommonBackBtn(
                          color: AppColor.primary,
                        ),
                      ],
                    ),
                    15.verticalSpace,
                    Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xff69DDA5),
                      ),
                      padding: const EdgeInsets.all(5),
                      child: Container(
                        width: 80.w,
                        height: 80.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(profile!.imageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    AppText(
                      color: AppColor.whiteFFFFFF,
                      text: profile!.name,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    AppText(
                      text: profile!.designation,
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                      color: AppColor.whiteFFFFFF.withOpacity(.8),
                    ),
                    const SizedBox(height: 20),
                    AppText(
                        text: profile!.description,
                        textAlign: TextAlign.center,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColor.whiteFFFFFF.withOpacity(.8)),
                    const SizedBox(height: 20),
                    Wrap(
                      spacing: 8,
                      children: [
                        InfoChip(label: 'Social', value: profile!.social),
                        InfoChip(label: 'Contact', value: profile!.contact),
                        InfoChip(label: 'Portfolio', value: profile!.portfolio),
                        InfoChip(label: 'Finance', value: profile!.finance),
                        InfoChip(label: 'Business', value: profile!.business),
                      ],
                    ),
                  ],
                ),
              ));
  }
}

class InfoChip extends StatelessWidget {
  final String label;
  final String value;

  const InfoChip({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: AppColor.green34D185,
        // border: BorderSide.none,
      ),
      child: AppText(
        color: AppColor.whiteFFFFFF,
        text: '$label: $value',
        fontSize: 13.sp,
      ),
    );
  }
}

Widget profileWidget({
  required String imageUrl,
  required String name,
  required int points,
  required bool isVip,
  required SubscriptionModel model,
}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Stack(
        children: [
          CircleAvatar(
            radius: 30.r,
            backgroundImage: NetworkImage(imageUrl),
          ),
          if (isVip)
            Positioned(
              right: 0,
              bottom: -1,
              child: SvgPicture.asset(
                Assets.imgVip,
              ),
            ),
        ],
      ),
      SizedBox(height: 10.h),
      AppText(
        text: name,
        fontSize: 24.sp,
        color: AppColor.black000000,
        fontWeight: FontWeight.w700,
      ),
      SizedBox(height: 10.h),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: const Color(0xff01C27D).withOpacity(0.1),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: AppText(
          text: "${model.Points} Points",
          color: const Color(0xff01C27D),
          fontSize: 15.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    ],
  );
}
