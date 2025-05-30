import 'package:NearMii/config/assets.dart';
import 'package:NearMii/config/helper.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:mime/mime.dart';
import 'package:url_launcher/url_launcher.dart';
import '../feature/common_widgets/custom_toast.dart';

class CallUtils {
  CallUtils._();

  static Future<void> openDialer(String phoneNumber) async {
    Uri callUrl = Uri.parse('tel:=$phoneNumber');
    if (await canLaunchUrl(callUrl)) {
      await launchUrl(callUrl);
    } else {
      throw 'Could not open the dialler.';
    }
  }
}

class Utils {
  Utils._();

  static Future<bool> hasNetwork({bool? showToast}) async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.isEmpty ||
        connectivityResult.first == ConnectivityResult.none) {
      toast(msg: "check your Internet Connection", isError: true);
      return false;
    } else {
      return true;
    }
  }

  static bool emailValidation(String email) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern.toString());
    return regex.hasMatch(email);
  }

  static String? getFileType(String path) {
    final mimeType = lookupMimeType(path);
    String? result = mimeType?.substring(0, mimeType.indexOf('/'));
    return result;
  }

  static Future<void> showLoader() async {
    BotToast.cleanAll();
    BotToast.showCustomLoading(
        useSafeArea: true,
        allowClick: false,
        clickClose: false,
        ignoreContentClick: true,
        align: Alignment.center,
        toastBuilder: (void Function() cancelFunc) {
          return Stack(
            alignment: Alignment.center,
            children: [
              const SizedBox(
                  width: 90,
                  height: 90,
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                    strokeCap: StrokeCap.round,
                    strokeWidth: 5,
                    color: AppColor.appThemeColor,
                  )),

              Image.asset(
                Assets.appLogoRound,
                height: 85,
                width: 85,
              )

              // CommonImageWidget(
              //   img: AppImages.icAppLogo,
              //   width: 50,
              // )
            ],
          );

          //Lottie.asset(Assets.appLoading,height: 180.h);
        });
  }

  static void hideLoader() {
    BotToast.closeAllLoading();
  }

  static void hideKeyboard(context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static void hideBottomSheet(context) {
    back(context);
  }

  static Future<void> launchURL(Uri uri) async {
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch ${uri.path}';
    }
  }
}
