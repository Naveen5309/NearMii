import 'dart:developer';

import 'package:NearMii/config/helper.dart';
import 'package:NearMii/core/helpers/all_getter.dart';
import 'package:NearMii/feature/common_widgets/custom_toast.dart';
import 'package:NearMii/feature/history/data/model/history_model.dart';
import 'package:NearMii/feature/history/domain/usecases/history_usecases.dart';
import 'package:NearMii/feature/history/presentation/provider/states/history_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HistoryNotifier extends StateNotifier<HistoryState> {
  final HistoryUsecases historyUsecases;

  HistoryNotifier({required this.historyUsecases}) : super(HistoryInitial());

  List<HistoryModel> historyDataList = [];

  //History US
  Future<void> historyApi({required String name}) async {
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
        "name": name,
      };
      final result = await historyUsecases.callHistory(body: body);
      state = result.fold((error) {
        log("login error:${error.message} ");
        return HistoryApiFailed(error: error.message);
      }, (result) {
        historyDataList = result ?? [];
        log("history result is :->${result}");
        return const HistoryApiSuccess();
      });
    } catch (e) {
      state = HistoryApiFailed(error: e.toString());
    }
  }
}
