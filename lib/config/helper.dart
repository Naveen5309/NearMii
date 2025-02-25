import 'dart:developer';
import 'package:NearMii/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
part 'extensions.dart';
part '../config/app_colors.dart';
part '../config/app_strings.dart';

void exit() {
  SystemNavigator.pop();
}

double screenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double screenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double safeAreaHeight(BuildContext context) {
  return (MediaQuery.of(context)
          .padding
          .top) /*+
          MediaQuery.of(context).padding.bottom)*/
      +
      15;
}

Widget dividerVirtical({
  double height = 25,
  double width = 1,
  Color color = const Color(0xff100301),
}) {
  return Container(
    height: height,
    width: width,
    color: color,
  );
}

void unFocus(BuildContext context) {
  FocusScope.of(context).unfocus();
}

SizedBox yHeight(double height) {
  return SizedBox(
    height: height,
  );
}

SizedBox xWidth(double width) {
  return SizedBox(
    width: width,
  );
}

void pushTo(BuildContext context, Widget widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

void pushReplacement(BuildContext context, Widget widget) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => widget));
}

void pushRemoveUtil(BuildContext context, Widget widget) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => widget),
    (route) {
      return false;
    },
  );
}

void offAllNamed(BuildContext context, String routesName, {Object? args}) {
  Navigator.pushNamedAndRemoveUntil(
      context, routesName, (Route<dynamic> route) => false,
      arguments: args);
}

void toNamed(BuildContext context, String routesName, {Object? args}) {
  Navigator.pushNamed(context, routesName, arguments: args);
}

void back(BuildContext context) {
  Navigator.pop(context);
}

void printLog(dynamic msg, {String fun = ""}) {
  _printLog(' $fun=> ${msg.toString()}');
}

void functionLog({required dynamic msg, required dynamic fun}) {
  _printLog("${fun.toString()} ::==> ${msg.toString()}");
}

void _printLog(dynamic msg, {String name = "Riverpod"}) {
  if (kDebugMode) {
    log(msg.toString(), name: name);
  }
}

void blocLog({required String msg, required String bloc}) {
  _printLog("${bloc.toString()} ::==> ${msg.toString()}");
}

bool emailValidation(String email) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = RegExp(pattern.toString());
  return regex.hasMatch(email);
}

Widget customLoader({
  double height = 55,
  double width = 100,
  Color color = Colors.black,
  double? value,
}) {
  return const SizedBox(
      /*  child: Lottie.asset(Assets.buttonLoader,
      height: height,
      width: width,),*/
      );
}

checkPostLocked(int price) {
  return (price == 1);
}

bool isHtml(String input) {
  final RegExp htmlRegex = RegExp(r"<[^>]*>");
  return htmlRegex.hasMatch(input);
}

double totalHeight =
    MediaQuery.of(navigatorKey.currentState!.context).padding.top +
        AppBar().preferredSize.height;

List<String> genderList = ["Male", "Female", "Other"];

String formatDOB(DateTime dob) {
  return '${dob.day.toString().padLeft(2, '0')}/${dob.month.toString().padLeft(2, '0')}/${dob.year}';
}

CrossAxisAlignment getCrossAxisAlignment(int index) {
  if (index % 3 == 0) {
    return CrossAxisAlignment.start;
  } else if (index % 3 == 1) {
    return CrossAxisAlignment.center;
  } else {
    return CrossAxisAlignment.end;
  }
}

Alignment getAlignment(int index) {
  if (index % 3 == 0) {
    return Alignment.centerLeft;
  } else if (index % 3 == 1) {
    return Alignment.center;
  } else {
    return Alignment.centerRight;
  }
}

String getDistance(String value) {
  if (value.isEmpty) return "0"; // Handle empty string case

  double? number = double.tryParse(value);
  if (number == null) {
    return value; // Return original if it's not a valid number
  }

  // Check if it's an integer
  if (number % 1 == 0) {
    return "${number.toInt()} meters away";
  } else {
    return "${number.toStringAsFixed(1)} meters away";
  }
}
