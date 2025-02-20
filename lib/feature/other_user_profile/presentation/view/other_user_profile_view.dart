import 'dart:developer';

import 'package:NearMii/feature/auth/presentation/provider/state_notifiers/signup_notifiers.dart';
import 'package:NearMii/feature/common_widgets/common_button.dart';
import 'package:NearMii/feature/common_widgets/common_text_field.dart';
import 'package:NearMii/feature/common_widgets/custom_bottom_sheet.dart';
import 'package:NearMii/feature/common_widgets/custom_report_tile.dart';
import 'package:NearMii/feature/common_widgets/custom_toast.dart';
import 'package:NearMii/feature/other_user_profile/data/model/other_user_profile_model.dart';
import 'package:NearMii/feature/other_user_profile/presentation/provider/other_user_profile_provider.dart';
import 'package:NearMii/feature/other_user_profile/presentation/provider/report_provider.dart';
import 'package:NearMii/feature/other_user_profile/presentation/states/other_user_profile_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:NearMii/config/assets.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/feature/auth/presentation/provider/state_notifiers/login_notifiers.dart';
import 'package:NearMii/feature/common_widgets/app_text.dart';
import 'package:NearMii/feature/common_widgets/custom_cache_network.dart';
import 'package:NearMii/feature/common_widgets/custom_search_bar_widget.dart';
import 'package:NearMii/feature/common_widgets/custom_switch_btn.dart';
import 'package:NearMii/feature/common_widgets/profile_grid_view.dart';
import 'package:NearMii/feature/home/data/models/subscription_model.dart';
import 'package:flutter/cupertino.dart';
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
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        final notifier = ref.read(otherUserProfileProvider.notifier);
        notifier.otherUserProfileApi(widget.id ?? '');
        // notifier.reportApi(
        //     widget.reportedUserId ?? '', widget.somethingElse ?? '');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(otherUserProfileProvider);

    final otherUserData = ref.watch(otherUserProfileProvider.notifier);

    ref.listen(
      otherUserProfileProvider,
      (previous, next) {
        if (next is OtherUserProfileApiLoading) {
          log("other user loading is called");
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
        } else if (next is OtherUserProfileApiSuccess) {
          if (context.mounted) {
            toast(msg: AppString.loginSuccess, isError: false);
          }

          back(context);
          // toNamed(context, Routes.bottomNavBar);
        } else if (next is OtherUserProfileApiFailed) {
          if (context.mounted) {
            back(context);
          }

          // toast(msg: next.error);
        }
      },
    );

    return Scaffold(
      body: otherUserData.profile == null
          ? Center(
              child: Text("Loading data1 ${otherUserData.profile?.name}"),
            )
          : SliverSnap(
              stretch: true,
              scrollBehavior: const CupertinoScrollBehavior(),
              pinned: true,
              animationCurve: Curves.easeInOutCubicEmphasized,
              // bottom: const PreferredSize(
              //   preferredSize: Size.fromHeight(100),
              //   child: Icon(
              //     Icons.directions_boat,
              //     color: Colors.blue,
              //     size: 45,
              //   ),
              // ),
              // collapsedBarHeight: 60,
              animationDuration: const Duration(milliseconds: 1),
              onCollapseStateChanged:
                  (isCollapsed, scrollingOffset, maxExtent) {},
              collapsedBackgroundColor: AppColor.btnColor,
              expandedBackgroundColor: const Color.fromRGBO(0, 0, 0, 0),
              backdropWidget: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(Assets.background),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              expandedContentHeight: context.height * .55,
              expandedContent: profileSection(context: context),
              collapsedContent: otherUserData.profile != null
                  ? appBarWidgetSection(
                      context: context,
                      otherUserProfileData: otherUserData.profile!)
                  : const SizedBox(
                      child: Text("loading"),
                    ),
              body: const Text("No data")

              //  bottomSection(loginNotifier: loginNotifier, context: context),
              ),
    );
  }
}

//APP BAR WIDGET SECTION
Widget appBarWidgetSection(
    {required BuildContext context,
    required OtherUserProfileModel otherUserProfileData}) {
  return Row(
    children: [
      GestureDetector(
        onTap: () {
          back(context);
        },
        child: SvgPicture.asset(
          Assets.icBackBtn,
          colorFilter:
              const ColorFilter.mode(AppColor.primary, BlendMode.srcIn),
        ),
      ),
      15.horizontalSpace,
      Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xff69DDA5),
        ),
        padding: const EdgeInsets.all(3),
        child: CustomCacheNetworkImage(
          img: '',
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
        final reportNotifier = ref.read(reportProvider.notifier);
        final somethingTextController = TextEditingController();

        ref.watch(reportProvider);
        ref.watch(selectedReportIndex);

        int selected = ref.read(selectedReportIndex);
        return PopupMenuButton(
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(4), // Adjust the radius as needed
          ),
          position: PopupMenuPosition.under,
          padding: EdgeInsets.zero,
          onSelected: (value) {
            showCustomBottomSheet(
                context: context,
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(Assets.reportNavClose),
                      15.verticalSpace,
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 4, vertical: context.height * .02),
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
                          ref.read(selectedReportIndex.notifier).state = 0;
                        },
                      ),
                      CustomReportTile(
                        title: AppString.theyAreUnderTheAge,
                        check: selected == 1,
                        ontap: () {
                          ref.read(selectedReportIndex.notifier).state = 1;
                        },
                      ),
                      CustomReportTile(
                        title: AppString.violenceAndDangerous,
                        check: selected == 2,
                        ontap: () {
                          ref.read(selectedReportIndex.notifier).state = 2;
                        },
                      ),
                      CustomReportTile(
                        title: AppString.hateSpeech,
                        check: selected == 3,
                        ontap: () {
                          ref.read(selectedReportIndex.notifier).state = 3;
                        },
                      ),
                      CustomReportTile(
                        title: AppString.nudity,
                        check: selected == 4,
                        ontap: () {
                          ref.read(selectedReportIndex.notifier).state = 4;
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
                          controller: somethingTextController,
                          // enableBorder: OutlineInputBorder(
                          //   borderRadius: BorderRadius.circular(20),
                          // ),
                          minLines: 2,
                          fillColor: AppColor.whiteF0F5FE,
                          hintText: "Lorem ipsum dolor sit......",
                          onChanged: (value) {
                            if (value!.isNotEmpty) {
                              reportNotifier.clearAllChecks();
                            }
                          }),
                      5.verticalSpace,
                      CommonAppBtn(
                        title: AppString.submit,
                        onTap: () {
                          print("object");
                          reportNotifier.reportApi(
                              reportedUserId: '', somethingElse: '');
                          // back(context);
                        },
                      ),
                      10.verticalSpace
                    ],
                  ),
                ));
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
Widget bottomSection(
    {required SignupNotifiers signupNotifier, required BuildContext context}) {
  return Container(
    color: AppColor.primary,
    width: context.width,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: context.width * .04),
      child: Column(children: [
        const CustomSearchBarWidget(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ProfileGridView(
            title: AppString.socialMedia,
            isMyProfile: false,
            socialMedia: signupNotifier.socialMediaList,
          ),
        )
      ]),
    ),
  );
}

//PROFILE SECTION
Widget profileSection(
    {required BuildContext context, OtherUserProfileModel? profile}) {
  return Column(
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
              child: Padding(
                padding: EdgeInsets.only(left: context.width * .05),
                child: SvgPicture.asset(
                  Assets.icBackBtn,
                  colorFilter:
                      const ColorFilter.mode(AppColor.primary, BlendMode.srcIn),
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
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(Assets.reportNavClose),
                        15.verticalSpace,
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 4, vertical: context.height * .02),
                          child: AppText(
                              text: AppString.report,
                              fontSize: 20.sp,
                              color: AppColor.black1A1C1E,
                              fontWeight: FontWeight.w700),
                        ),
                        const CustomReportTile(
                          title: AppString.theyArePretending,
                          check: true,
                        ),
                        const CustomReportTile(
                          title: AppString.theyAreUnderTheAge,
                          check: false,
                        ),
                        const CustomReportTile(
                          title: AppString.violenceAndDangerous,
                          check: false,
                        ),
                        const CustomReportTile(
                          title: AppString.hateSpeech,
                          check: false,
                        ),
                        const CustomReportTile(
                          title: AppString.nudity,
                          check: false,
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
                          enableBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          minLines: 2,
                          fillColor: AppColor.whiteF0F5FE,
                          hintText: "Lorem ipsum dolor sit......",
                        ),
                        5.verticalSpace,
                        // CommonAppBtn(
                        //   title: AppString.submit,
                        //   onTap: () {
                        //     back(context);
                        //   },
                        // ),
                        10.verticalSpace
                      ],
                    ));
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
                  colorFilter:
                      const ColorFilter.mode(AppColor.primary, BlendMode.srcIn),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: context.height * .02),
        Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xff69DDA5),
          ),
          padding: const EdgeInsets.all(6),
          child: CustomCacheNetworkImage(
            img: '',
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
        const Wrap(
          alignment: WrapAlignment.center,
          runSpacing: 8,
          spacing: 6,
          children: [
            InfoChip(label: 'Social', value: ''),
            InfoChip(label: 'Contact', value: ''),
            InfoChip(label: 'Portfolio', value: ''),
            InfoChip(label: 'Finance', value: ''),
            InfoChip(label: 'Business', value: ''),
          ],
        )
      ]);
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



  // void toggleCheck(int index) {
  //   state = [
  //     for (int i = 0; i < state.length; i++)
  //       if (i == index)
  //         state[i].copyWith(isChecked: !state[i].isChecked)
  //       else
  //         state[i]
  //   ];
  // }

  // void uncheckAll() {
  //   state = state.map((e) => e.copyWith(isChecked: false)).toList();
  // }
//  onChanged: (value) {
//           if (value.isNotEmpty) {
//             reportNotifier.clearReason(); // Uncheck all if user types
//           }
//         },
        
//   onTap: () {
//           reportNotifier.reportApi(
//             reportedUserId: '',
//             somethingElse: selectedReason.isEmpty ? textController.text : selectedReason,
//           );
//         },