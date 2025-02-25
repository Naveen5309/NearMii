import 'package:NearMii/config/app_utils.dart';
import 'package:NearMii/config/assets.dart';
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
import 'package:NearMii/feature/common_widgets/custom_search_bar_widget.dart';
import 'package:NearMii/feature/common_widgets/custom_social_gridview.dart';
import 'package:NearMii/feature/common_widgets/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      notifier.getSocialPlatform(query: '');
    });
  }

  final _debounce = Debouncer();

  void _onSearchChanged(String query) {
    final notifier = ref.read(signupProvider.notifier);
    _debounce.run(() {
      notifier.getSocialPlatform(query: query);
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
            await Getters.getLocalStorage.saveIsLogin(true);
            await Getters.getLocalStorage.saveFirstIn(false);

            if (context.mounted) {
              offAllNamed(context, Routes.bottomNavBar);
              toast(msg: AppString.signupSuccess, isError: false);
            }

            toast(msg: AppString.signupSuccess, isError: false);
          },
          title: AppString.next,
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
                              offAllNamed(context, Routes.bottomNavBar);
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
                    AppText(
                      text: "Lorem ipsum dolor sit amet consectetur. Massa.",
                      fontSize: 14.sp,
                      color: AppColor.grey999,
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

                    CustomSocialGridview(
                      title: AppString.socialMedia,
                      socialMedia: signupPro.socialMediaList,
                      notifier: signupPro,
                    ),

                    //CONTACT INFORMATION

                    CustomSocialGridview(
                      notifier: signupPro,
                      title: AppString.contactInformation,
                      socialMedia: signupPro.contactList,
                    ),

                    //PORTFOLIO

                    CustomSocialGridview(
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
