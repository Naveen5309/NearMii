import 'dart:developer';

import 'package:NearMii/config/assets.dart';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/core/helpers/all_getter.dart';
import 'package:NearMii/core/utils/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView>
    with SingleTickerProviderStateMixin {
  // late AnimationController _controller;
  // late Animation _animation;
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();

    // _controller =
    //     AnimationController(duration: const Duration(seconds: 3), vsync: this);
    // _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
    //   CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    // );

    // // Start the animation
    // _controller.forward();
  }

  //CHECK LOGIN

  Future<bool> checkLogin() async {
    bool isLogin = Getters.getLocalStorage.getIsLogin() ?? false;
    return isLogin;
  }

  //CHECK is ONBOARD

  Future<bool> checkIsOnBoard() async {
    bool isFirstOnboard = Getters.getLocalStorage.getFirstOnboard() ?? true;

    log("is first onboard:-> $isFirstOnboard");
    return isFirstOnboard;
  }

  @override
  void dispose() {
    // _controller.dispose();
    super.dispose();
  }

  void _navigateToNextScreen() {
    // Store mounted state before async call
    final isMounted = context.mounted;

    // Simulate a delay for the splash screen
    Future.delayed(const Duration(seconds: 3), () async {
      // Check if the widget is still mounted
      if (!isMounted) return;

      // Navigate to the next screen (replace with your next screen logic)
      bool isLogin = await checkLogin();
      bool isFirstOnboard = await checkIsOnBoard();

      if (!isMounted) return;

      if (isLogin) {
        if (context.mounted) {
          offAllNamed(context, Routes.bottomNavBar, args: true);
        }
      } else if (isFirstOnboard) {
        if (context.mounted) {
          offAllNamed(context, Routes.onboard, args: false);
        }
      } else {
        if (context.mounted) {
          offAllNamed(context, Routes.auth, args: false);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  colors: AppColor.splashGradient,
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )

                    // color: AppColor.appThemeColor

                    ),
              ),
              SizedBox(
                // width: MediaQuery.of(context).size.width * 0.5,
                // height: MediaQuery.of(context).size.width * 0.25,
                child: SvgPicture.asset(
                  Assets.appLogo,
                  fit: BoxFit.fill,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
