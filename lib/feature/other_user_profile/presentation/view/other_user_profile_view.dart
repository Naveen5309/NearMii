import 'package:NearMii/config/app_utils.dart';
import 'package:NearMii/config/debouncer.dart';
import 'package:NearMii/config/enums.dart';
import 'package:NearMii/core/network/http_service.dart';
import 'package:NearMii/feature/common_widgets/common_button.dart';
import 'package:NearMii/feature/common_widgets/common_text_field.dart';
import 'package:NearMii/feature/common_widgets/custom_bottom_sheet.dart';
import 'package:NearMii/feature/common_widgets/custom_report_tile.dart';
import 'package:NearMii/feature/common_widgets/custom_toast.dart';
import 'package:NearMii/feature/common_widgets/other_user_profile_grid_view.dart';
import 'package:NearMii/feature/common_widgets/profile_shimmer.dart';
import 'package:NearMii/feature/other_user_profile/data/model/other_user_profile_model.dart';
import 'package:NearMii/feature/other_user_profile/presentation/provider/other_user_profile_provider.dart';
import 'package:NearMii/feature/other_user_profile/presentation/provider/report_provider.dart';
import 'package:NearMii/feature/other_user_profile/presentation/states/other_user_profile_states.dart';
import 'package:NearMii/feature/other_user_profile/presentation/states_notifier/other_user_profile_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:NearMii/config/assets.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/feature/common_widgets/app_text.dart';
import 'package:NearMii/feature/common_widgets/custom_cache_network.dart';
import 'package:NearMii/feature/common_widgets/custom_search_bar_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sliver_snap/widgets/sliver_snap.dart';

class OtherUserProfileView extends ConsumerStatefulWidget {
  final String? id;
  final String? reportedUserId;
  final String? somethingElse;

  const OtherUserProfileView({
    super.key,
    required this.id,
    required this.somethingElse,
    required this.reportedUserId,
  });

  @override
  ConsumerState<OtherUserProfileView> createState() =>
      _OtherUserProfileViewState();
}

class _OtherUserProfileViewState extends ConsumerState<OtherUserProfileView> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        final notifier = ref.read(otherUserProfileProvider.notifier);
        notifier.otherUserProfileApi(widget.id ?? '');
        notifier.getOtherSocialPlatform(userId: widget.id ?? '');
      },
    );
  }

  final _debounce = Debouncer();

  void onSearchChanged(query) {
    final notifier = ref.read(otherUserProfileProvider.notifier);
    _debounce.run(() {
      notifier.getOtherSocialPlatform(userId: widget.id ?? '');
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(otherUserProfileProvider);
    ref.watch(reportProvider);

    final otherUserData = ref.read(otherUserProfileProvider.notifier);

    ref.listen(
      reportProvider,
      (previous, next) {
        printLog("current loading is :-> $next");
        if (next is OtherUserProfileApiLoading &&
            ((next.otherUserType == OtherUserType.report))) {
          printLog("other user loading is called");
          Utils.showLoader();
        } else if (next is OtherUserProfileApiSuccess &&
            next.otherUserType == OtherUserType.report) {
          Utils.hideLoader();
          toast(msg: AppString.reportSubmitted, isError: false);
          back(context);
        } else if (next is OtherUserProfileApiFailed &&
            next.otherUserType == OtherUserType.report) {
          toast(msg: next.error);

          if (context.mounted) {
            Utils.hideLoader();
          }
        }
      },
    );

    return Scaffold(
      body: ((otherUserData.profile == null) || (otherUserData.isLoading))
          ? const ProfileShimmer()
          : SliverSnap(
              stretch: true,
              scrollBehavior: const MaterialScrollBehavior(),
              pinned: true,
              animationCurve: Curves.easeInOutCubicEmphasized,
              animationDuration: const Duration(milliseconds: 5),
              onCollapseStateChanged:
                  (isCollapsed, scrollingOffset, maxExtent) {},
              collapsedBackgroundColor: AppColor.btnColor,
              expandedBackgroundColor: const Color.fromRGBO(0, 0, 0, 0),
              expandedContentHeight: context.height * .55,
              expandedContent: profileSection(
                  otherUserProfileProvider: otherUserData,
                  context: context,
                  profile: otherUserData.profile!),
              collapsedContent: otherUserData.profile != null
                  ? appBarWidgetSection(
                      context: context,
                      otherUserProfileData: otherUserData.profile!,
                      id: widget.id)
                  : const SizedBox(
                      child: Text("loading"),
                    ),
              body: bottomSection(
                profile: otherUserData.profile!,
                otherUserProfileNotifier: otherUserData,
                context: context,
                onSearchChanged: onSearchChanged,
              )),
    );
  }
}

//APP BAR WIDGET SECTION
Widget appBarWidgetSection({
  required BuildContext context,
  required OtherUserProfileModel otherUserProfileData,
  required String? id,
}) {
  return Row(
    children: [
      InkWell(
        onTap: () {
          back(context);
        },
        child: Padding(
          padding: EdgeInsets.only(
            right: 20.w,
            top: 15,
            bottom: 15,
          ),
          child: SvgPicture.asset(
            Assets.icBackBtn,
            colorFilter:
                const ColorFilter.mode(AppColor.primary, BlendMode.srcIn),
          ),
        ),
      ),
      // 15.horizontalSpace,
      Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xff69DDA5),
        ),
        padding: const EdgeInsets.all(3),
        child: CustomCacheNetworkImage(
          img: otherUserProfileData.profilePhoto != null
              ? "${ApiConstants.profileBaseUrl}${otherUserProfileData.profilePhoto}"
              : '',
          imageRadius: 150,
          height: 40.w,
          width: 40.w,
        ),
      ),
      5.horizontalSpace,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            text: otherUserProfileData.name ?? '',
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
            color: AppColor.whiteFFFFFF,
          ),
          AppText(
            text: otherUserProfileData.designation ?? '',
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: AppColor.whiteFFFFFF.withOpacity(.8),
          ),
        ],
      ),
      const Spacer(),
      Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
        ref.watch(reportProvider);

        return PopupMenuButton(
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(4), // Adjust the radius as needed
          ),
          position: PopupMenuPosition.under,
          padding: EdgeInsets.zero,
          onSelected: (value) {},
          itemBuilder: (BuildContext bc) {
            return [
              const PopupMenuItem(
                  value: AppString.report,
                  child: AppText(
                    text: AppString.report,
                    color: AppColor.redFF3B30,
                  )),
            ];
          },
          child: Padding(
            padding: EdgeInsets.only(right: context.width * .05),
            child: SvgPicture.asset(
              Assets.icMore,
              colorFilter:
                  const ColorFilter.mode(AppColor.primary, BlendMode.srcIn),
            ),
          ),
        );
      }),
    ],
  );
}

//BOTTOM SECTION
Widget bottomSection({
  required OtherUserProfileNotifier otherUserProfileNotifier,
  required BuildContext context,
  required OtherUserProfileModel? profile,
  required Function(String) onSearchChanged,
})
//
{
  return Container(
    color: AppColor.primary,
    width: context.width,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: context.width * .04),
      child: SingleChildScrollView(
        // Enable full scrolling
        child: Column(
          children: [
            CustomSearchBarWidget(
              controller: otherUserProfileNotifier.platformSearchController,
              onChanged: (value) {
                onSearchChanged(value);
              },
            ),
            ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: otherUserProfileNotifier.newPlatformLists.length,
              shrinkWrap: true, // Allow wrapping content height
              physics:
                  const NeverScrollableScrollPhysics(), // Prevent nested scrolling conflicts
              itemBuilder: (context, index) {
                var data = otherUserProfileNotifier.newPlatformLists[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: OtherUserProfileGridView(
                    notifier: otherUserProfileNotifier,
                    controller:
                        otherUserProfileNotifier.platformSearchController,
                    title: data.title ?? '',
                    socialMedia: data.list ?? [],
                  ),
                );
              },
            )
          ],
        ),
      ),
    ),
  );
}

//PROFILE SECTION
Widget profileSection({
  required BuildContext context,
  required OtherUserProfileModel? profile,
  required OtherUserProfileNotifier otherUserProfileProvider,
}) {
  return Container(
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage(Assets.background),
        fit: BoxFit.fill,
      ),
    ),
    child: Column(
        mainAxisSize:
            MainAxisSize.min, // Ensures column takes only necessary space
        children: [
          SizedBox(height: context.height * .1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  back(context);
                },
                child: SizedBox(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: context.width * .05,
                        vertical: context.height * .02),
                    child: SvgPicture.asset(
                      Assets.icBackBtn,
                      colorFilter: const ColorFilter.mode(
                          AppColor.primary, BlendMode.srcIn),
                    ),
                  ),
                ),
              ),
              PopupMenuButton(
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(4), // Adjust the radius as needed
                ),
                position: PopupMenuPosition.under,
                padding: EdgeInsets.zero,
                onSelected: (value) {
                  showCustomBottomSheet(
                      context: context,
                      content: Consumer(builder: (context, ref, child) {
                        // ref.watch(selectedReportIndex);
                        final reportNotifier =
                            ref.watch(reportProvider.notifier);
                        // final somethingTextController = TextEditingController();
                        int selected = ref.watch(selectedReportIndex);

                        printLog("selected is $selected");
                        return SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(Assets.reportNavClose),
                              15.verticalSpace,
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 4,
                                    vertical: context.height * .02),
                                child: AppText(
                                    text: AppString.report,
                                    fontSize: 20.sp,
                                    color: AppColor.black1A1C1E,
                                    fontWeight: FontWeight.w700),
                              ),
                              CustomReportTile(
                                title: AppString.theyArePretending,
                                check: selected == 0,
                                ontap: () {
                                  printLog("oncloc");
                                  ref
                                      .read(selectedReportIndex.notifier)
                                      .update((_) => 0);
                                  reportNotifier.reasonController.text =
                                      AppString.theyArePretending;
                                  reportNotifier.somethingElseController
                                      .clear();
                                  // back(context);
                                },
                              ),
                              CustomReportTile(
                                title: AppString.theyAreUnderTheAge,
                                check: selected == 1,
                                ontap: () {
                                  ref
                                      .read(selectedReportIndex.notifier)
                                      .update((_) => 1);
                                  reportNotifier.reasonController.text =
                                      AppString.theyAreUnderTheAge;
                                  reportNotifier.somethingElseController
                                      .clear();
                                },
                              ),
                              CustomReportTile(
                                title: AppString.violenceAndDangerous,
                                check: selected == 2,
                                ontap: () {
                                  ref
                                      .read(selectedReportIndex.notifier)
                                      .update((_) => 2);
                                  reportNotifier.reasonController.text =
                                      AppString.violenceAndDangerous;
                                  reportNotifier.somethingElseController
                                      .clear();
                                },
                              ),
                              CustomReportTile(
                                title: AppString.hateSpeech,
                                check: selected == 3,
                                ontap: () {
                                  ref
                                      .read(selectedReportIndex.notifier)
                                      .update((_) => 3);
                                  reportNotifier.reasonController.text =
                                      AppString.hateSpeech;
                                  reportNotifier.somethingElseController
                                      .clear();
                                },
                              ),
                              CustomReportTile(
                                title: AppString.nudity,
                                check: selected == 4,
                                ontap: () {
                                  ref
                                      .read(selectedReportIndex.notifier)
                                      .update((_) => 4);
                                  reportNotifier.reasonController.text =
                                      AppString.nudity;
                                  reportNotifier.somethingElseController
                                      .clear();
                                },
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  AppText(
                                      text: "Something Else",
                                      fontSize: 14.sp,
                                      color: AppColor.black1A1C1E,
                                      fontWeight: FontWeight.w700),
                                ],
                              ),
                              CustomTextFieldWidget(
                                  controller:
                                      reportNotifier.somethingElseController,
                                  // enableBorder: OutlineInputBorder(
                                  //   borderRadius: BorderRadius.circular(20),
                                  // ),
                                  minLines: 2,
                                  fillColor: AppColor.whiteF0F5FE,
                                  hintText: "Lorem ipsum dolor sit......",
                                  onChanged: (value) {
                                    if (value!.isNotEmpty) {
                                      ref
                                          .read(selectedReportIndex.notifier)
                                          .state = -1;
                                    }
                                  }),
                              5.verticalSpace,
                              CommonAppBtn(
                                  title: AppString.submit,
                                  onTap: () {
                                    int selected =
                                        ref.watch(selectedReportIndex);

                                    String somethingElseText = reportNotifier
                                        .somethingElseController.text
                                        .trim();

                                    if ((selected != -1 &&
                                            somethingElseText.isNotEmpty) ||
                                        (selected == -1 &&
                                            somethingElseText.isEmpty)) {
                                      toast(
                                          msg:
                                              "Select either a report or enter something in 'Something Else'");
                                      return;
                                    }
                                    String finalReason = selected != -1
                                        ? reportNotifier.reasonController.text
                                        : '';
                                    String finalSomethingElse =
                                        selected == -1 ? somethingElseText : '';

                                    reportNotifier.reportApi(
                                      reportedUserId:
                                          profile?.id.toString() ?? '',
                                      reason: finalReason,
                                      somethingElse: finalSomethingElse,
                                    );
                                  }),
                              10.verticalSpace
                            ],
                          ),
                        );
                      }));

                  // showCustomBottomSheet(
                  //     context: context,
                  //     content: Column(
                  //       mainAxisSize: MainAxisSize.min,
                  //       children: [
                  //         SvgPicture.asset(Assets.reportNavClose),
                  //         15.verticalSpace,
                  //         Padding(
                  //           padding: EdgeInsets.symmetric(
                  //               horizontal: 4, vertical: context.height * .02),
                  //           child: AppText(
                  //               text: AppString.report,
                  //               fontSize: 20.sp,
                  //               color: AppColor.black1A1C1E,
                  //               fontWeight: FontWeight.w700),
                  //         ),
                  //         const CustomReportTile(
                  //           title: AppString.theyArePretending,
                  //           check: true,
                  //         ),
                  //         const CustomReportTile(
                  //           title: AppString.theyAreUnderTheAge,
                  //           check: false,
                  //         ),
                  //         const CustomReportTile(
                  //           title: AppString.violenceAndDangerous,
                  //           check: false,
                  //         ),
                  //         const CustomReportTile(
                  //           title: AppString.hateSpeech,
                  //           check: false,
                  //         ),
                  //         const CustomReportTile(
                  //           title: AppString.nudity,
                  //           check: false,
                  //         ),
                  //         const SizedBox(
                  //           height: 12,
                  //         ),
                  //         Row(
                  //           children: [
                  //             const SizedBox(
                  //               width: 5,
                  //             ),
                  //             AppText(
                  //                 text: "Something Else",
                  //                 fontSize: 14.sp,
                  //                 color: AppColor.black1A1C1E,
                  //                 fontWeight: FontWeight.w700),
                  //           ],
                  //         ),
                  //         CustomTextFieldWidget(
                  //           enableBorder: OutlineInputBorder(
                  //             borderRadius: BorderRadius.circular(20),
                  //           ),
                  //           minLines: 2,
                  //           fillColor: AppColor.whiteF0F5FE,
                  //           hintText: "Lorem ipsum dolor sit......",
                  //         ),
                  //         5.verticalSpace,
                  //         // CommonAppBtn(
                  //         //   title: AppString.submit,
                  //         //   onTap: () {
                  //         //     back(context);
                  //         //   },
                  //         // ),
                  //         10.verticalSpace
                  //       ],
                  //     ));
                },
                itemBuilder: (BuildContext bc) {
                  return [
                    const PopupMenuItem(
                        value: AppString.report,
                        child: AppText(
                          text: AppString.report,
                          color: AppColor.redFF3B30,
                        )),
                  ];
                },
                child: Padding(
                  padding: EdgeInsets.only(right: context.width * .05),
                  child: SvgPicture.asset(
                    Assets.icMore,
                    colorFilter: const ColorFilter.mode(
                        AppColor.primary, BlendMode.srcIn),
                  ),
                ),
              ),
            ],
          ),
          Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xff69DDA5),
            ),
            padding: const EdgeInsets.all(6),
            child: CustomCacheNetworkImage(
              dummyPadding: 30,
              img: profile?.profilePhoto != null
                  ? "${ApiConstants.profileBaseUrl}${profile?.profilePhoto}"
                  : '',
              imageRadius: 150,
              height: 105.w,
              width: 105.w,
            ),
          ),
          10.verticalSpace,
          AppText(
            color: AppColor.whiteFFFFFF,
            text: profile?.name ?? "",
            fontSize: 20.sp,
            fontWeight: FontWeight.w500,
          ),
          5.verticalSpace,
          AppText(
            text: profile?.designation ?? '',
            fontWeight: FontWeight.w500,
            fontSize: 16.sp,
            color: AppColor.whiteFFFFFF.withOpacity(.8),
          ),
          25.verticalSpace,
          AppText(
            text: profile?.bio ?? "",
            textAlign: TextAlign.center,
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: AppColor.whiteFFFFFF.withOpacity(.8),
          ),
          20.verticalSpace,
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 12,
            runSpacing: 12,
            children:
                otherUserProfileProvider.newPlatformListProfile.map((entry) {
              return InfoChip(
                  label: entry.title ?? "Unknown",
                  value: entry.list?.length.toString() ?? '0');
            }).toList(),
          ),
        ]),
  );
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
            text: AppString.hideProfile,
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

      // ToggleSwitchBtn(
      //   onToggled: (isToggled) {},
      // ),
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
          text: "$points Points",
          color: const Color(0xff01C27D),
          fontSize: 15.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    ],
  );
}
