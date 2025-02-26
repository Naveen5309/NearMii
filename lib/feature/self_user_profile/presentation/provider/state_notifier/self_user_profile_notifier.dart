import 'dart:developer';
import 'package:NearMii/config/helper.dart';
import 'package:NearMii/core/helpers/all_getter.dart';
import 'package:NearMii/feature/common_widgets/custom_toast.dart';
import 'package:NearMii/feature/self_user_profile/domain/usecases/self_user_profile_usecases.dart';
import 'package:NearMii/feature/self_user_profile/presentation/provider/state/self_user_profile_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelfUserProfileNotifier extends StateNotifier<SelfUserProfileState> {
  final SelfUserProfileUsecases selfUserProfileUsecases;

  SelfUserProfileNotifier({required this.selfUserProfileUsecases})
      : super(SelfUserProfileInitial());

  //SelfUserProfile US
  Future<void> updateSocialLinksApi({required String name}) async {
    state = const SelfUserProfileApiLoading();
    try {
      if (!(await Getters.networkInfo.isConnected)) {
        state = const SelfUserProfileApiFailed(
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
      final result =
          await selfUserProfileUsecases.callUpdateSocialProfile(body: body);

      state = result.fold((error) {
        log("login error:${error.message} ");
        return SelfUserProfileApiFailed(error: error.message);
      }, (result) {
        // historyDataList = result ?? [];
        log("SelfUserProfile result is :->$result");
        return const SelfUserProfileApiSuccess();
      });
    } catch (e) {
      state = SelfUserProfileApiFailed(error: e.toString());
    }
  }

  //SelfUserProfile US
  Future<void> hideAllLinksApi({required String name}) async {
    state = const SelfUserProfileApiLoading();
    try {
      if (!(await Getters.networkInfo.isConnected)) {
        state = const SelfUserProfileApiFailed(
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
      final result = await selfUserProfileUsecases.callHideAllLinks(body: body);

      state = result.fold((error) {
        log("login error:${error.message} ");
        return SelfUserProfileApiFailed(error: error.message);
      }, (result) {
        // historyDataList = result ?? [];
        log("SelfUserProfile result is :->${result}");
        return const SelfUserProfileApiSuccess();
      });
    } catch (e) {
      state = SelfUserProfileApiFailed(error: e.toString());
    }
  }

  //SelfUserProfile US
  Future<void> updateGetSelfPlatformApi({required String name}) async {
    state = const SelfUserProfileApiLoading();
    try {
      if (!(await Getters.networkInfo.isConnected)) {
        state = const SelfUserProfileApiFailed(
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
      final result =
          await selfUserProfileUsecases.callGetSelfPlatform(body: body);

      state = result.fold((error) {
        log("login error:${error.message} ");
        return SelfUserProfileApiFailed(error: error.message);
      }, (result) {
        // historyDataList = result ?? [];
        log("SelfUserProfile result is :->${result}");
        return const SelfUserProfileApiSuccess();
      });
    } catch (e) {
      state = SelfUserProfileApiFailed(error: e.toString());
    }
  }
}
