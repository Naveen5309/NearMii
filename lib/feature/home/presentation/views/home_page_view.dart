import 'package:NearMii/config/assets.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/feature/common_widgets/app_text.dart';
import 'package:NearMii/feature/common_widgets/custom_address_tile.dart';
import 'package:NearMii/feature/common_widgets/custom_cache_network.dart';
import 'package:NearMii/feature/common_widgets/custom_profile_card.dart';
import 'package:NearMii/feature/home/data/models/preferance_model.dart';
import 'package:NearMii/feature/home/presentation/provider/home_provider.dart';
import 'package:NearMii/feature/home/presentation/views/vip_dialog.dart';
import 'package:NearMii/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePageView extends ConsumerStatefulWidget {
  const HomePageView({super.key});

  @override
  ConsumerState<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends ConsumerState<HomePageView> {
  // late AnimationController _controller;
  // late Animation _animation;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        showDialog(
          context: context,
          builder: (context) => const VIPMembershipDialog(),
        );
      },
    );
  }

  @override
  void dispose() {
    // _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(Assets.icHomePngBg),
              ),
            ),

            height: context.height * 0.29,

// color: Colors.green,

            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: context.width * 0.05,
                  vertical: context.height * 0.01),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: totalHeight -
                        MediaQuery.of(navigatorKey.currentState!.context)
                            .padding
                            .top,
                  ),
                  15.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
//WELCOME BACK TEXT

                          AppText(
                            text: AppString.welcomeBack,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColor.primary.withOpacity(.8),
                          ),

                          5.verticalSpace,

//NAME

                          AppText(
                            text: "Brooklyn Simmons",
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColor.primary,
                          ),
                        ],
                      ),
                      Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: AppColor.primary.withOpacity(.16),
                            shape: BoxShape.circle,
                          ),
                          child: const CustomCacheNetworkImage(
                              height: 45,
                              width: 45,
                              img: "https://picsum.photos/250?image=9",
                              imageRadius: 40)),
                    ],
                  ),
                  SizedBox(
                    height: context.height * .04,
                  ),
                  const LocationCard(
                    location: "Philadelphia",
                    address: "Preston Rd. Inglewood, Maine",
                  ),
                ],
              ),
            ),
          ),

          ref.watch(isMapView)
              ? Image.asset(
                  Assets.map,
                  height: context.height * .62,
                  width: context.width,
                  fit: BoxFit.cover,
                )
              : SizedBox(
                  height: context.height * .69,
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: 15,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return CustomProfileCard(
                        profileImage:
                            'https://picsum.photos/250?image=9', // Replace with actual image

                        name: "Robert Fox",

                        designation: "Senior Developer",

                        distance: "50 meters away",

                        onUnlockTap: () {
                          print("Unlock Now Clicked!");
                        },
                      );
                    },
                  ),
                ),

// Image.asset(Assets.map)
        ],
      ),
    );
  }
}

class PreferenceList extends ConsumerWidget {
  final List<PreferencesModel> list;
  const PreferenceList({super.key, required this.list});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        var data = list[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: ListTile(
            tileColor: Colors.cyan.withOpacity(0.5),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            title: AppText(
              text: data.title ?? "",
              fontSize: 18,
            ),
            subtitle: AppText(text: data.createdAt ?? ""),
          ),
        );
      },
    );
  }
}
