import 'dart:developer';

import 'package:NearMii/config/assets.dart';
import 'package:NearMii/config/enums.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/core/utils/routing/routes.dart';
import 'package:NearMii/feature/auth/presentation/provider/login_provider.dart';
import 'package:NearMii/feature/auth/presentation/provider/states/auth_states.dart';
import 'package:NearMii/feature/common_widgets/app_text.dart';
import 'package:NearMii/feature/common_widgets/bg_image_container.dart';
import 'package:NearMii/feature/common_widgets/common_back_btn.dart';
import 'package:NearMii/feature/common_widgets/common_button.dart';
import 'package:NearMii/feature/common_widgets/custom_search_bar_widget.dart';
import 'package:NearMii/feature/common_widgets/custom_social_gridview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectSocialMediaView extends ConsumerStatefulWidget {
  const SelectSocialMediaView({super.key});

  @override
  ConsumerState<SelectSocialMediaView> createState() =>
      _SelectSocialMediaViewState();
}

class _SelectSocialMediaViewState extends ConsumerState<SelectSocialMediaView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final notifier = ref.read(loginProvider.notifier);
      notifier.getSocialPlatform();
    });
  }

  @override
  Widget build(BuildContext context) {
    // final authState = ref.watch(loginProvider);
    final loginState = ref.watch(loginProvider);
    final loginNotifier = ref.read(loginProvider.notifier);
    ref.listen(
      loginProvider,
      (previous, next) {
        log("current state is:-> $next");
        if (next is AuthApiLoading && next.authType == AuthType.socialMedia) {
          showDialog(
            context: context,
            builder: (context) {
              return Center(
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
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
      body: BgImageContainer(
          bgImage: Assets.icProfileBg,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: context.width * .05),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: totalHeight,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CommonBackBtn(),
                      AppText(
                        text: AppString.skip,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
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

                  15.verticalSpace,
                  AppText(
                    text: "Lorem ipsum dolor sit amet consectetur. Massa.",
                    fontSize: 14.sp,
                    color: AppColor.grey999,
                  ),

                  //SEARCH FIELD
                  const CustomSearchBarWidget(),

                  Consumer(
                    builder: (context, ref, child) {
                      return CustomSocialGridview(
                          title: "Social Media",
                          socialMedia: loginNotifier.platformDataList ?? []);
                    },
                  ),

                  //login
                  CommonAppBtn(
                    onTap: () {
                      offAllNamed(context, Routes.login);
                    },
                    title: AppString.next,
                    textSize: 16.sp,
                  ),

                  SizedBox(
                    height: context.height * .05,
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
