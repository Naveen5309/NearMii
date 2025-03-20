import 'dart:developer';

import 'package:NearMii/config/helper.dart';
import 'package:NearMii/core/helpers/all_getter.dart';
import 'package:NearMii/feature/common_widgets/custom_toast.dart';
import 'package:NearMii/feature/history/data/model/history_model.dart';
import 'package:NearMii/feature/history/domain/usecases/history_usecases.dart';
import 'package:NearMii/feature/history/presentation/provider/states/history_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HistoryNotifier extends StateNotifier<HistoryState> {
  final HistoryUsecases historyUsecases;

  HistoryNotifier({required this.historyUsecases}) : super(HistoryInitial());

  List<HistoryModel> historyDataList = [];
  List<HistoryModel> recentHistoryList = [];

  List<HistoryModel> historyLastWeekTimeList = [];
  List<HistoryModel> historyLastMonthTimeList = [];

  bool isHistoryLoading = false;
  bool isFromSearch = false;

  TextEditingController historySearchController = TextEditingController();

  //History US
  Future<void> historyApi({required bool isFromSear}) async {
    isFromSearch = isFromSear;
    isHistoryLoading = true;
    state = const HistoryApiLoading();
    try {
      if (!(await Getters.networkInfo.isConnected)) {
        state = const HistoryApiFailed(
          error: AppString.noInternetConnection,
        );
        return;
      }
      if (await Getters.networkInfo.isSlow) {
        toast(
          msg: AppString.networkSlow,
        );
      }
      Map<String, dynamic> body = {
        "name": isFromSear ? historySearchController.text.trim() : "",
      };
      final result = await historyUsecases.callHistory(body: body);
      state = result.fold((error) {
        log("login error:${error.message} ");
        return HistoryApiFailed(error: error.message);
      }, (result) {
        historyDataList = result ?? [];
        log("history result is :->$result");
        DateTime now = DateTime.now();
        DateTime last7Days = now.subtract(const Duration(days: 7));
        DateTime last14Days = now.subtract(const Duration(days: 14));
        DateTime last365Days = now.subtract(const Duration(days: 365));
        recentHistoryList = historyDataList
            .where((history) =>
                history.createdAt != null &&
                history.createdAt!.isAfter(last7Days))
            .toList();

        historyLastWeekTimeList = historyDataList
            .where((history) =>
                history.createdAt != null &&
                history.createdAt!.isAfter(last14Days) &&
                history.createdAt!.isBefore(last7Days))
            .toList();

        historyLastMonthTimeList = historyDataList
            .where((history) =>
                history.createdAt != null &&
                history.createdAt!.isAfter(last365Days) &&
                history.createdAt!.isBefore(last14Days))
            .toList();

        log("Recent History (Last 7 Days): ${recentHistoryList.length}");
        log("Last Week History (7-14 Days): ${historyLastWeekTimeList.length}");
        log("Last Month History (14-30 Days): ${historyLastMonthTimeList.length}");
        isHistoryLoading = false;

        return const HistoryApiSuccess();
      });
    } catch (e) {
      isHistoryLoading = false;

      state = HistoryApiFailed(error: e.toString());
    }
  }
}

//  Time Format Function
String getTimeAgo(DateTime? dateTime) {
  if (dateTime == null) return "Unknown";

  Duration diff = DateTime.now().difference(dateTime);
  if (diff.inSeconds < 60) return "${diff.inSeconds}s ago";
  if (diff.inMinutes < 60) return "${diff.inMinutes}m ago";
  if (diff.inHours < 24) return "${diff.inHours}h ago";
  if (diff.inDays < 7) return "${diff.inDays}d ago";
  if (diff.inDays < 30) return "${(diff.inDays / 7).floor()}w ago";
  return "${(diff.inDays / 30).floor()}mo ago";
}
