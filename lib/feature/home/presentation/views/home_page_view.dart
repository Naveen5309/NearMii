import 'dart:io';
import 'package:NearMii/config/assets.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/core/helpers/all_getter.dart';
import 'package:NearMii/core/network/http_service.dart';
import 'package:NearMii/core/utils/routing/routes.dart';
import 'package:NearMii/feature/common_widgets/app_text.dart';
import 'package:NearMii/feature/common_widgets/custom_address_tile.dart';
import 'package:NearMii/feature/common_widgets/custom_cache_network.dart';
import 'package:NearMii/feature/common_widgets/custom_profile_card.dart';
import 'package:NearMii/feature/common_widgets/dummy_profile_card.dart';
import 'package:NearMii/feature/common_widgets/home_shimmer.dart';
import 'package:NearMii/feature/home/data/models/preferance_model.dart';
import 'package:NearMii/feature/home/presentation/provider/home_provider.dart';
import 'package:NearMii/feature/home/presentation/views/vip_dialog.dart';
import 'package:NearMii/feature/location/location_provider.dart';
import 'package:NearMii/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lottie/lottie.dart';

class HomePageView extends ConsumerStatefulWidget {
  final bool isFromAuth;
  const HomePageView({super.key, required this.isFromAuth});

  @override
  ConsumerState<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends ConsumerState<HomePageView> {
  RewardedAd? _rewardedAd;
  int rewardedCount = 0;

  @override
  void initState() {
    super.initState();
    _loadRewardedAd();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var notifier = ref.watch(homeProvider.notifier);
      notifier.getFromLocalStorage();

      // notifier.fetchLocation(context: context);
      // if (notifier.homeUserDataList.isEmpty) {

      // notifier.updateCoordinates(radius: '');
      bool? isTrue = Getters.getLocalStorage.getIsSaveVip();

      if (isTrue != null) {
        if (isTrue) {
          // notifier.checkAddress();
          showDialog(
            context: context,
            builder: (context) => const VIPMembershipDialog(),
          ).then(
            (value) {
              Getters.getLocalStorage.saveIShowVip(false);
            },
          );
        }
      }

      // homeDataNotifier.getHomeDataApi();

      // }
      // ref.watch(getProfileProvider.notifier).getProfileApi();

      // if ((notifier.addressName == "No address found") ||
      //     (notifier.addressName == "Fetching location")) {

      // }
    });
  }

  @override
  void dispose() {
    _rewardedAd?.dispose();
    super.dispose();
  }

  void _loadRewardedAd() {
    RewardedAd.load(
      adUnitId: AdHelper.rewardedAdUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          printLog("add load :-> $ad");
          _rewardedAd = ad;
        },
        onAdFailedToLoad: (err) {
          printLog("add load :-> $err");
        },
      ),
    );
  }

  void _showRewardedAd({required String id}) {
    if (_rewardedAd != null) {
      _rewardedAd?.show(onUserEarnedReward: (ad, reward) {
        toNamed(context, Routes.otherUserProfile, args: id.toString()).then(
          (value) {
            var notifier = ref.watch(homeProvider.notifier);
            double lat = Getters.getLocalStorage.getLat() ?? 0.0;
            double lang = Getters.getLocalStorage.getLang() ?? 0.0;
            notifier.getHomeDataApi(lat: lat, lang: lang);
          },
        );
        // toNamed(context, rou);
      }
          // setState(() {
          //   rewardedCount++;
          // }),
          );
      _rewardedAd!.fullScreenContentCallback =
          FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        _loadRewardedAd();
      }, onAdFailedToShowFullScreenContent: ((ad, error) {
        ad.dispose();
        _loadRewardedAd();
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    printLog("home build called");
    return Consumer(builder: (context, ref, child) {
      ref.watch(homeProvider);
      var notifier = ref.watch(homeProvider.notifier);
      notifier.getFromLocalStorage();

      int credit = Getters.getLocalStorage.getCredits() ?? 2;

      // ✅ Listen for live location updates
      ref.listen<AsyncValue<Position>>(locationProvider, (previous, next) {
        next.when(
          data: (position) {
            print(
                "🚀 Location Updated: Lat ${position.latitude}, Lng ${position.longitude}");

            notifier.updateCoordinates(
                radius: '', lang: position.longitude, lat: position.latitude);

            Getters.getLocalStorage.saveLat(position.latitude);
            Getters.getLocalStorage.saveLang(position.longitude);
          },
          loading: () => print("⏳ Fetching Location..."),
          error: (e, _) => print("❌ Error: $e"),
        );
      });

      ref.watch(locationProvider);

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
                            overflow: TextOverflow.ellipsis,
                            color: AppColor.primary.withOpacity(.8),
                          ),
                          5.verticalSpace,
                          //NAME
                          SizedBox(
                            width: context.width * .7,
                            child: Wrap(
                              children: [
                                AppText(
                                  maxlines: 1,
                                  text: notifier.name,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.primary,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: AppColor.primary.withOpacity(.16),
                            shape: BoxShape.circle,
                          ),
                          child: CustomCacheNetworkImage(
                              height: context.width * .15,
                              width: context.width * .15,
                              img: notifier.profilePic.isNotEmpty
                                  ? ApiConstants.profileBaseUrl +
                                      notifier.profilePic
                                  : notifier.socialImg.isNotEmpty
                                      ? notifier.socialImg
                                      : '',
                              imageRadius: 40)),
                    ],
                  ),
                  SizedBox(
                    height: context.height * .025,
                  ),
                  LocationCard(
                    location: notifier.location,
                    address: notifier.addressName,
                  ),
                  10.verticalSpace
                ],
              ),
            ),
          ),
          // ref.watch(isMapView)
          //     ? Image.asset(
          //         Assets.map,
          //         height: context.height * .62,
          //         width: context.width,
          //         fit: BoxFit.cover,
          //       )
          //     :

          // notifier.homeUserDataList.isEmpty
          //     ? SizedBox(
          //         height: context.height * .6,
          //         child: const Center(child: AppText(text: "No user found")),
          //       )
          //     : Column(
          //         children: [
          //           SizedBox(
          //             height: context.height * .69,
          //             child: ListView.builder(
          //               padding: EdgeInsets.zero,
          //               itemCount: notifier.homeUserDataList.length + 1,
          //               shrinkWrap: true,
          //               itemBuilder: (context, index) {
          //                 if (index == notifier.homeUserDataList.length) {
          //                   // Last index, show "No Data"
          //                   return const DummyProfileCard();
          //                 }
          //                 var data = notifier.homeUserDataList[index];

          //                 return CustomProfileCard(
          //                   profileImage: data.profilePhoto != null
          //                       ? ApiConstants.profileBaseUrl +
          //                           data.profilePhoto!
          //                       : '', // Replace with actual image
          //                   name: data.name ?? "Name",
          //                   designation: data.designation ?? "designation",
          //                   distance: data.distance != null
          //                       ? getDistance(data.distance.toString())
          //                       : '',
          //                   onUnlockTap: () {
          //                     // print("Unlock Now Clicked!");
          //                   },
          //                 );
          //               },
          //             ),
          //           ),
          //         ],
          //       ),

          notifier.isHomeLoading
              ? SizedBox(
                  height: context.height * .69, child: const HomeShimmer())
              : RefreshIndicator(
                  displacement: 10,
                  triggerMode: RefreshIndicatorTriggerMode.onEdge,
                  color: AppColor.appThemeColor,
                  onRefresh: () async {
                    var notifier = ref.read(homeProvider.notifier);
                    // notifier.updateCoordinates(radius: '');
                  },
                  child: notifier.homeUserDataList.isEmpty
                      ? SizedBox(
                          height: context.height * .55,
                          width: context.width * .55,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Lottie.asset(Assets.emptyAnimation,
                                  backgroundLoading: true,
                                  // height: context.height * .4,
                                  width: context.width * .6,
                                  fit: BoxFit.fill),
                              AppText(
                                text: AppString.noNearbyUser,
                                color: AppColor.black000000,
                                fontSize: 16.sp,
                              )
                            ],
                          ),
                        )
                      : Column(
                          children: [
                            AnimatedContainer(
                              duration: const Duration(seconds: 1),
                              width: context.width,
                              constraints: BoxConstraints(
                                  maxHeight: context.height * .69),
                              child: SizedBox(
                                height: context.height * .69,
                                child: AnimationLimiter(
                                  child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    itemCount:
                                        notifier.homeUserDataList.length + 1,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      if (index ==
                                          notifier.homeUserDataList.length) {
                                        // Last index, show "No Data"
                                        return const DummyProfileCard();
                                      }
                                      var data =
                                          notifier.homeUserDataList[index];

                                      return AnimationConfiguration
                                          .staggeredList(
                                        position: index,
                                        child: SlideAnimation(
                                          curve: Curves.easeInOutCirc,
                                          horizontalOffset:
                                              index % 2 == 0 ? -100 : 100,
                                          child: FadeInAnimation(
                                            child: CustomProfileCard(
                                              profileImage:
                                                  data.profilePhoto != null
                                                      ? ApiConstants
                                                              .profileBaseUrl +
                                                          data.profilePhoto!
                                                      : '',
                                              isSubscription: notifier
                                                  .isSubscription, // Replace with actual image
                                              name: data.name ?? "",
                                              designation:
                                                  data.designation ?? "",
                                              distance: data.distance != null
                                                  ? getDistance(
                                                      data.distance.toString())
                                                  : '',
                                              onUnlockTap: () {
                                                printLog(
                                                    "user_points are : on click $credit");

                                                if (notifier.isSubscription) {
                                                  toNamed(
                                                          context,
                                                          Routes
                                                              .otherUserProfile,
                                                          args: data.id
                                                              .toString())
                                                      .then(
                                                    (value) {
                                                      double lat = Getters
                                                              .getLocalStorage
                                                              .getLat() ??
                                                          0.0;
                                                      double lang = Getters
                                                              .getLocalStorage
                                                              .getLang() ??
                                                          0.0;
                                                      notifier.getHomeDataApi(
                                                          lat: lat, lang: lang);
                                                    },
                                                  );
                                                } else if (credit > 0) {
                                                  printLog(
                                                      "points are greater");
                                                  toNamed(
                                                          context,
                                                          Routes
                                                              .otherUserProfile,
                                                          args: data.id
                                                              .toString())
                                                      .then(
                                                    (value) {
                                                      double lat = Getters
                                                              .getLocalStorage
                                                              .getLat() ??
                                                          0.0;
                                                      double lang = Getters
                                                              .getLocalStorage
                                                              .getLang() ??
                                                          0.0;
                                                      notifier.getHomeDataApi(
                                                          lat: lat, lang: lang);
                                                    },
                                                  );
                                                } else {
                                                  _showRewardedAd(
                                                      id: data.id.toString());
                                                  // showDialog(
                                                  //   context: context,
                                                  //   builder: (context) =>
                                                  //       const VIPMembershipDialog(),
                                                  // );
                                                }

                                                // print("Unlock Now Clicked!");
                                              },
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                )

          // Image.asset(Assets.map)
        ],
      ));
    });
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

class AdHelper {
  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3940256099942544/5224354917"; // Your rewarderAdUnitId for Android
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/1712485313"; // Your rewarderAdUnitId for Ios
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }
}
