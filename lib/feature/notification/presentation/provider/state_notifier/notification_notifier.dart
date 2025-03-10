import 'dart:developer';

import 'package:NearMii/config/helper.dart';
import 'package:NearMii/core/helpers/all_getter.dart';
import 'package:NearMii/feature/common_widgets/custom_toast.dart';
import 'package:NearMii/feature/notification/data/model/notification_response_model.dart';
import 'package:NearMii/feature/notification/domain/usecases/notification_usecases.dart';
import 'package:NearMii/feature/notification/presentation/provider/state/notification_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotificationNotifier extends StateNotifier<NotificationState> {
  final NotificationUsecases notificationUsecases;

  NotificationNotifier({required this.notificationUsecases})
      : super(NotificationInitial());

  List<NotificationData> notificationDataList = [];
  bool isNotificationLoading = false;
  bool isFromSearch = false;

  List<NotificationData> recentNotificationList = [];

  List<NotificationData> notificationLastWeekTimeList = [];
  List<NotificationData> notificationLastMonthTimeList = [];

  TextEditingController notificationSearchController = TextEditingController();
  //Notification US
  Future<void> notificationApi({required bool isFromSear}) async {
    isNotificationLoading = true;
    state = const NotificationApiLoading();
    try {
      if (!(await Getters.networkInfo.isConnected)) {
        isNotificationLoading = false;

        state = const NotificationApiFailed(
          error: AppString.noInternetConnection,
        );
        return;
      }
      if (await Getters.networkInfo.isSlow) {
        toast(
          msg: AppString.networkSlow,
        );
      }
      Map<String, dynamic> body = {};
      final result = await notificationUsecases.callNotification(body: body);
      state = result.fold((error) {
        log("login error:${error.message} ");
        return NotificationApiFailed(error: error.message);
      }, (result) {
        notificationDataList = result ?? [];
        log("history result is :->$result");
        DateTime now = DateTime.now();
        DateTime last7Days = now.subtract(const Duration(days: 7));
        DateTime last14Days = now.subtract(const Duration(days: 14));
        DateTime last365Days = now.subtract(const Duration(days: 365));
        recentNotificationList = notificationDataList
            .where((history) =>
                history.createdAt != null &&
                history.createdAt!.isAfter(last7Days))
            .toList();

        notificationLastWeekTimeList = notificationDataList
            .where((history) =>
                history.createdAt != null &&
                history.createdAt!.isAfter(last14Days) &&
                history.createdAt!.isBefore(last7Days))
            .toList();

        notificationLastMonthTimeList = notificationDataList
            .where((history) =>
                history.createdAt != null &&
                history.createdAt!.isAfter(last365Days) &&
                history.createdAt!.isBefore(last14Days))
            .toList();

        isNotificationLoading = false;

        return const NotificationApiSuccess();
      });
    } catch (e) {
      isNotificationLoading = false;

      state = NotificationApiFailed(error: e.toString());
    }
  }
}
