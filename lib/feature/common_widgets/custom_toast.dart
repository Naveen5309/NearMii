import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import '../../config/helper.dart';
import 'app_text.dart';

void toast({required String msg, bool isError = true, bool isInfo = false}) {
  BotToast.showCustomText(
      duration: const Duration(seconds: 2),
      toastBuilder: (cancelFunc) => Align(
            alignment: const Alignment(0, 0.8),
            child: Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                  color: isError
                      ? Colors.red
                      : (isInfo == true)
                          ? Colors.yellow[700]
                          : Colors.green,
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 4.0,
                      spreadRadius: 0.0,
                      offset: const Offset(
                        0.0,
                        2.0,
                      ),
                    )
                  ]),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: AppColor.primary),
                        child: Icon(
                          isError
                              ? Icons.error
                              : (isInfo == true)
                                  ? Icons.info_outline_rounded
                                  : Icons.done_all,
                          color: isError
                              ? Colors.red
                              : (isInfo == true)
                                  ? Colors.yellow[700]
                                  : Colors.green,
                        ),
                      ),
                      xWidth(10),
                      Flexible(
                        child: AppText(
                            text: msg,
                            textAlign: TextAlign.center,
                            fontSize: 15,
                            fontFamily: AppString.fontFamily,
                            color: AppColor.primary),
                      ),
                      xWidth(10),
                    ],
                  ),
                ],
              ),
            ),
          ));
}
