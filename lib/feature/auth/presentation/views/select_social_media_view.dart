import 'package:NearMii/config/app_utils.dart';
import 'package:NearMii/config/assets.dart';
import 'package:NearMii/config/constants.dart';
import 'package:NearMii/config/debouncer.dart';
import 'package:NearMii/config/enums.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/core/helpers/all_getter.dart';
import 'package:NearMii/core/utils/routing/routes.dart';
import 'package:NearMii/feature/auth/presentation/provider/login_provider.dart';
import 'package:NearMii/feature/auth/presentation/provider/signup_provider.dart';
import 'package:NearMii/feature/auth/presentation/provider/states/auth_states.dart';
import 'package:NearMii/feature/common_widgets/app_text.dart';
import 'package:NearMii/feature/common_widgets/bg_image_container.dart';
import 'package:NearMii/feature/common_widgets/common_back_btn.dart';
import 'package:NearMii/feature/common_widgets/common_button.dart';
import 'package:NearMii/feature/common_widgets/custom_bottom_sheet.dart';
import 'package:NearMii/feature/common_widgets/custom_search_bar_widget.dart';
import 'package:NearMii/feature/common_widgets/custom_social_gridview.dart';
import 'package:NearMii/feature/common_widgets/custom_toast.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SelectSocialMediaView extends ConsumerStatefulWidget {
  final bool isFromProfile;

  const SelectSocialMediaView({
    super.key,
    required this.isFromProfile,
  });

  @override
  ConsumerState<SelectSocialMediaView> createState() =>
      _SelectSocialMediaViewState();
}

class _SelectSocialMediaViewState extends ConsumerState<SelectSocialMediaView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final notifier = ref.read(signupProvider.notifier);
      notifier.getSocialPlatform();
    });
  }

  final _debounce = Debouncer();

  void _onSearchChanged(String query) {
    final notifier = ref.read(signupProvider.notifier);
    _debounce.run(() {
      notifier.getSocialPlatform();
    });
  }

  @override
  Widget build(BuildContext context) {
    // final authState = ref.watch(loginProvider);
    ref.watch(signupProvider);
    final signupPro = ref.watch(signupProvider.notifier);

    ref.listen(
      loginProvider,
      (previous, next) {
        if (next is AuthApiLoading && next.authType == AuthType.socialMedia) {
          Utils.showLoader();
        } else if (next is AuthApiSuccess &&
            next.authType == AuthType.socialMedia) {
          // toast(msg: AppString.loginSuccess, isError: false);
          Utils.hideLoader();

          // toNamed(context, Routes.bottomNavBar);
        } else if (next is AuthApiFailed &&
            next.authType == AuthType.socialMedia) {
          Utils.hideLoader();

          // toast(msg: next.error);
        }
      },
    );

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton:
          //login
          Padding(
        padding: EdgeInsets.symmetric(
            horizontal: context.width * .05, vertical: context.height * .01),
        child: CommonAppBtn(
          onTap: () async {
            if (widget.isFromProfile) {
              back(context);
            } else {
              await Getters.getLocalStorage.saveIsLogin(true);
              await Getters.getLocalStorage.saveFirstIn(false);

              if (context.mounted) {
                offAllNamed(context, Routes.bottomNavBar, args: true);
                toast(msg: AppString.signupSuccess, isError: false);
              }

              toast(msg: AppString.signupSuccess, isError: false);
            }
          },
          title: widget.isFromProfile ? AppString.done : AppString.next,
          textSize: 16.sp,
        ),
      ),
      body: BgImageContainer(
          bgImage: Assets.icProfileBg,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: context.width * .05),
            child: SingleChildScrollView(
              child: Consumer(builder:
                  (BuildContext context, WidgetRef ref, Widget? child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: totalHeight,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CommonBackBtn(),
                        InkWell(
                          onTap: () async {
                            await Getters.getLocalStorage.saveIsLogin(true);
                            await Getters.getLocalStorage.saveFirstIn(false);

                            if (context.mounted) {
                              offAllNamed(context, Routes.bottomNavBar,
                                  args: true);
                              toast(
                                  msg: AppString.signupSuccess, isError: false);
                            }
                          },
                          child: AppText(
                            text: widget.isFromProfile ? " " : AppString.skip,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),

                    SizedBox(
                      height: context.height * .05,
                    ),
                    //Logo

                    //ADD SOCIAL PROFILES TEXT

                    AppText(
                      text: AppString.addSocialProfiles,
                      fontSize: 32.sp,
                    ),

                    10.verticalSpace,

                    RichText(
                      text: TextSpan(
                        text: 'Upload the URL of your profiles. ',
                        style: TextStyle(
                          color: AppColor.grey999,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        children: [
                          TextSpan(
                            text: 'Learn More',
                            style: TextStyle(
                              color: AppColor.btnColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // Handle the tap action here

                                showCustomBottomSheet(
                                    context: context,
                                    content: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: .0, vertical: 15),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              AppText(
                                                text:
                                                    "Steps to Add Profile Link",
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              InkWell(
                                                  onTap: () {
                                                    back(context);
                                                  },
                                                  child: SvgPicture.asset(
                                                      height: 30,
                                                      width: 30,
                                                      Assets.icCloseCircle))
                                            ],
                                          ),
                                          12.verticalSpace,
                                          SizedBox(
                                            height: context.height * .8,
                                            child: ListView.builder(
                                              itemCount:
                                                  AppString.stepsList.length,
                                              itemBuilder: (context, index) {
                                                var data =
                                                    AppString.stepsList[index];
                                                return Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 8.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      5.verticalSpace,
                                                      AppText(
                                                          fontFamily: Constants
                                                              .fontFamily,
                                                          fontSize: 15.sp,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          text: data["step"] ??
                                                              ''),
                                                      5.verticalSpace,
                                                      AppText(
                                                          fontFamily: Constants
                                                              .fontFamily,
                                                          fontSize: 12.sp,
                                                          lineHeight: 1.5,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: AppColor
                                                              .black000000
                                                              .withOpacity(.6),
                                                          text: data["msg"] ??
                                                              ''),
                                                    ],
                                                  ),
                                                );

                                                // ListTile(
                                                //   title: Text(
                                                //     AppString
                                                //         .profileUrls[index],
                                                //     style: const TextStyle(
                                                //         fontSize: 16),
                                                //   ),
                                                // );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ));

                                // You can add any navigation or action here, e.g., navigate to a new screen
                              },
                          ),
                        ],
                      ),
                    ),

                    15.verticalSpace,

                    //SEARCH FIELD
                    CustomSearchBarWidget(
                      controller: signupPro.searchTextController,
                      onChanged: (value) {
                        _onSearchChanged(value);
                      },
                    ),

                    //SOCIAL MEDIA

                    signupPro.socialMediaList.isEmpty
                        ? const SizedBox()
                        : CustomSocialGridview(
                            title: AppString.socialMedia,
                            socialMedia: signupPro.socialMediaList,
                            notifier: signupPro,
                          ),

                    //CONTACT INFORMATION

                    signupPro.contactList.isEmpty
                        ? const SizedBox()
                        : CustomSocialGridview(
                            notifier: signupPro,
                            title: AppString.contactInformation,
                            socialMedia: signupPro.contactList,
                          ),

                    //PORTFOLIO

                    signupPro.portfolioList.isEmpty
                        ? const SizedBox()
                        : CustomSocialGridview(
                            notifier: signupPro,
                            title: AppString.portfolio,
                            socialMedia: signupPro.portfolioList,
                          ),

                    SizedBox(
                      height: context.height * .05,
                    ),
                  ],
                );
              }),
            ),
          )),
    );
  }
}
