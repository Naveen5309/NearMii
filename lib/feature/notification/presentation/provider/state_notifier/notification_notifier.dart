import 'dart:developer';

import 'package:NearMii/config/helper.dart';
import 'package:NearMii/core/helpers/all_getter.dart';
import 'package:NearMii/feature/common_widgets/custom_toast.dart';
import 'package:NearMii/feature/history/data/model/history_model.dart';
import 'package:NearMii/feature/notification/domain/usecases/notification_usecases.dart';
import 'package:NearMii/feature/notification/presentation/provider/state/notification_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotificationNotifier extends StateNotifier<NotificationState> {
  final NotificationUsecases notificationUsecases;

  NotificationNotifier({required this.notificationUsecases})
      : super(NotificationInitial());

  List<HistoryModel> notificationDataList = [];

  //Notification US
  Future<void> notificationApi() async {
    state = const NotificationApiLoading();
    try {
      if (!(await Getters.networkInfo.isConnected)) {
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
        log("history result is :->${result}");
        return const NotificationApiSuccess();
      });
    } catch (e) {
      state = NotificationApiFailed(error: e.toString());
    }
  }
}
