import 'package:NearMii/config/assets.dart';
import 'package:NearMii/config/enums.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/feature/auth/presentation/provider/login_provider.dart';
import 'package:NearMii/feature/auth/presentation/provider/states/auth_states.dart';
import 'package:NearMii/feature/common_widgets/app_text.dart';
import 'package:NearMii/feature/common_widgets/custom_cache_network.dart';
import 'package:NearMii/feature/common_widgets/custom_search_bar_widget.dart';
import 'package:NearMii/feature/common_widgets/custom_switch_btn.dart';
import 'package:NearMii/feature/common_widgets/profile_grid_view.dart';
import 'package:NearMii/feature/home/data/models/subscription_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

class ProfileCard extends ConsumerStatefulWidget {
  const ProfileCard({super.key});

  @override
  ConsumerState<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends ConsumerState<ProfileCard> {
  ProfileModel? profile;

  @override
  void initState() {
    super.initState();
    fetchProfileData();
    Future.microtask(() {
      final notifier = ref.read(loginProvider.notifier);
      notifier.getSocialPlatform();
    });
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
    ref.watch(loginProvider);
    final loginNotifier = ref.watch(loginProvider.notifier);

    ref.listen(
      loginProvider,
      (previous, next) {
        if (next is AuthApiLoading && next.authType == AuthType.socialMedia) {
          showDialog(
            context: context,
            builder: (context) {
              return Center(
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.0),
                      color: AppColor.primary,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(28.0),
                      child: CircularProgressIndicator.adaptive(),
                    )),
              );
            },
          );
        } else if (next is AuthApiSuccess &&
            next.authType == AuthType.socialMedia) {
          // toast(msg: AppString.loginSuccess, isError: false);
          back(context);
          // toNamed(context, Routes.bottomNavBar);
        } else if (next is AuthApiFailed &&
            next.authType == AuthType.socialMedia) {
          back(context);
          // toast(msg: next.error);
        }
      },
    );

    return Scaffold(
        body: NestedScrollView(
      floatHeaderSlivers: true,
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          SliverAppBar(
            backgroundColor: AppColor.btnColor,
            snap: true,
            pinned: true,
            floating: true,
            title: Visibility(
              visible: innerBoxIsScrolled,
              child: Row(
                children: [
                  // PROFILE SECTION
                  Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xff69DDA5),
                    ),
                    padding: const EdgeInsets.all(5),

                    //profile pic
                    child: CustomCacheNetworkImage(
                      img: '',
                      imageRadius: 150,
                      height: 20.w,
                      width: 20.w,
                    ),
                  ),
                  5.horizontalSpace,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        text: "Brooklyn Simmons",
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColor.whiteFFFFFF,
                      ),
                      AppText(
                        text: "Designation",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColor.whiteFFFFFF.withOpacity(.8),
                      ),
                    ],
                  )
                ],
              ),
            ),
            expandedHeight: context.height * .5,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const [StretchMode.zoomBackground],
              expandedTitleScale: 1,
              collapseMode: CollapseMode.none,
              centerTitle: true,
              title: Column(
                mainAxisSize: MainAxisSize
                    .min, // Ensures column takes only necessary space
                children: [
                  SizedBox(height: context.height * .14),
                  Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xff69DDA5),
                    ),
                    padding: const EdgeInsets.all(5),
                    child: CustomCacheNetworkImage(
                      img: '',
                      imageRadius: 150,
                      height: 95.w,
                      width: 95.w,
                    ),
                  ),
                  10.verticalSpace,
                  AppText(
                    color: AppColor.whiteFFFFFF,
                    text: profile!.name,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  5.verticalSpace,
                  AppText(
                    text: profile!.designation,
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                    color: AppColor.whiteFFFFFF.withOpacity(.8),
                  ),
                  25.verticalSpace,
                  AppText(
                    text: profile!.description,
                    textAlign: TextAlign.center,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColor.whiteFFFFFF.withOpacity(.8),
                  ),
                  20.verticalSpace,
                  Wrap(
                    alignment: WrapAlignment.center,
                    runSpacing: 8,
                    spacing: 6,
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
              background: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(
                  left: 12.w,
                  right: 12.w,
                  top: context.height * .1,
                  bottom: context.height * .025,
                ),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(Assets.background),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, int index) {
                return Column(
                  children: [
                    //SEARCH FIELD
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: context.width * .05,
                          vertical: context.height * .02),
                      child: const CustomSearchBarWidget(),
                    ),

                    //HIDE ALL

                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: context.width * .05,
                          vertical: context.height * .02),
                      child: hideAllSection(),
                    ),

                    //SOCIAL MEDIA

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ProfileGridView(
                        title: AppString.socialMedia,
                        socialMedia: loginNotifier.socialMediaList,
                      ),
                    ),
                  ],
                );

                // ListTile(
                //   leading: Container(
                //       padding: const EdgeInsets.all(8),
                //       width: 100,
                //       child: const Placeholder()),
                //   title: Text('Place ${index + 1}', textScaleFactor: 2),
                // );
              },
              childCount: 1,
            ),
          ),
        ];
      },
      body: const SizedBox(),
    ));
  }
}

// HIDE ALL SECTION

Widget hideAllSection() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            text: AppString.hideAll,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
          AppText(
            text: "Lorem ipsum dolor sit amet consectetur.",
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: AppColor.grey999,
          ),
        ],
      ),

      //SWITCH BUTTON

      ToggleSwitchBtn(
        onToggled: (isToggled) {},
      ),
    ],
  );
}

class InfoChip extends StatelessWidget {
  final String label;
  final String value;

  const InfoChip({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: AppColor.whiteFFFFFF.withOpacity(.2),
        // border: BorderSide.none,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          //LABEL
          AppText(
            color: AppColor.whiteFFFFFF,
            text: '$label: ',
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
          ),

          //VALUE

          AppText(
            color: AppColor.whiteFFFFFF,
            text: value,
            fontSize: 12.sp,
            fontWeight: FontWeight.w700,
          ),
        ],
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
