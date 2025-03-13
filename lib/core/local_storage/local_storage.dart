import 'dart:convert';
import 'package:NearMii/feature/setting/data/model/profile_model.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import '../../config/helper.dart';
import '../../feature/auth/data/models/user_model.dart';

abstract class HiveConst {
  static const String userData = 'userData';

  static const String authToken = 'authToken';
  static const String isProfileComplete = 'isProfileComplete';
  static const String isOnboard = 'isOnboard';
  static const String editPrfileUserData = 'EditPrfileUserData';

  static const String isLogin = 'isLogin';
  static const String isSubscription = 'isSubscription';
  static const String credits = 'credits';

  static const String address = 'address';

  static const String location = 'location';
  static const String profilePic = 'profilePic';
  static const String socialImg = 'socialImg';

  static const String name = 'name';
  static const String isShowVip = 'isShowVip';
}

abstract class LocalStorage {
  Future<bool> saveLoginUser(UserModel userModel);
  Future<bool> saveGetUserProfile(UserProfileModel editProfileModel);

  Future<void> saveFirstIn(bool isOnboard);
  UserModel? getLoginUser();
  UserProfileModel? getUserProfileData();
  bool? getFirstOnboard();
  Future<void> saveIShowVip(bool isShowVip);

  Future<void> clearAllBox();
  Future<void> clearLoginData();

  String? getToken();
  String? getAddress();

  String? getLocation();
  String? getProfilePic();

  String? getSocialProfilePic();

  String? getName();

  Future<void> saveToken(String token);
  Future<void> saveAddress(String address);
  Future<void> saveLocation(String location);
  Future<void> saveProfileImg(String socialImg);

  Future<void> saveSocialImg(String pic);

  Future<void> saveName(String name);

  Future<void> saveIsLogin(bool isLogin);
  Future<void> saveCredits(int credits);

  Future<void> saveIsSubscription(bool isSubscription);

  bool? getIsLogin();
  bool? getIsSaveVip();

  bool? getIsSubscription();
  int? getCredits();

  Future<void> saveIsProfileComplete(int isComplete);
  int? getIsProfileComplete();
}

class HiveStorageImp extends LocalStorage {
  final Box userBox;

  HiveStorageImp({
    required this.userBox,
  });

  @override
  Future<void> saveToken(String token) async {
    await userBox.put(HiveConst.authToken, token);
    printLog("==============saveToken==========> $token ");
  }

  @override
  Future<void> saveName(String name) async {
    await userBox.put(HiveConst.name, name);
  }

  @override
  Future<void> saveProfileImg(String profilePic) async {
    await userBox.put(HiveConst.profilePic, profilePic);
  }

  @override
  Future<void> saveSocialImg(String socialImg) async {
    await userBox.put(HiveConst.socialImg, socialImg);
  }

  @override
  Future<void> saveAddress(String address) async {
    await userBox.put(HiveConst.address, address);
    printLog("==============address==========> $address ");
  }

  @override
  Future<void> saveLocation(String location) async {
    await userBox.put(HiveConst.location, location);
    printLog("==============location==========> $location ");
  }

  @override
  String? getToken() {
    final authToken = userBox.get(HiveConst.authToken);
    return authToken;
  }

  @override
  String? getName() {
    final name = userBox.get(HiveConst.name);
    return name;
  }

  @override
  String? getProfilePic() {
    final profilePic = userBox.get(HiveConst.profilePic);
    return profilePic;
  }

  @override
  String? getSocialProfilePic() {
    final socialImg = userBox.get(HiveConst.socialImg);
    return socialImg;
  }

  @override
  String? getAddress() {
    final address = userBox.get(HiveConst.address);
    return address;
  }

  @override
  String? getLocation() {
    final location = userBox.get(HiveConst.location);
    return location;
  }

  static Future<LocalStorage> init() async => HiveStorageImp(
        userBox: await Hive.openBox(HiveConst.userData),
      );

  @override
  Future<bool> saveLoginUser(UserModel userModel) async {
    await userBox.put(HiveConst.userData, userModel.toJson());
    printLog("==============saveLoginUser==========");

    return true;
  }

  @override
  Future<bool> saveGetUserProfile(UserProfileModel editProfileModel) async {
    await userBox.put(HiveConst.editPrfileUserData, editProfileModel.toJson());
    printLog("==============saveUpdateProfile==========");

    return true;
  }

  @override
  UserModel? getLoginUser() {
    final user = userBox.get(HiveConst.userData);
    if (user == null) return null;
    final data = UserModel.fromJson(jsonDecode(jsonEncode(user)));
    return data;
  }

  @override
  UserProfileModel? getUserProfileData() {
    final user = userBox.get(HiveConst.editPrfileUserData);
    if (user == null) return null;
    final data = UserProfileModel.fromJson(jsonDecode(jsonEncode(user)));
    return data;
  }

  @override
  Future<void> clearAllBox() async {
    await userBox.clear();
  }

  @override
  Future<void> clearLoginData() async {
    await userBox.delete(HiveConst.isLogin);
    await userBox.delete(HiveConst.authToken);
    await userBox.delete(HiveConst.userData);
  }

  @override
  Future<void> saveIsProfileComplete(int isComplete) async {
    await userBox.put(HiveConst.isProfileComplete, isComplete);
  }

  @override
  int? getIsProfileComplete() {
    final isComplete = userBox.get(HiveConst.isProfileComplete);
    return isComplete;
  }

  @override
  bool? getIsLogin() {
    final isLogin = userBox.get(HiveConst.isLogin);
    return isLogin;
  }

  @override
  Future<void> saveIsLogin(bool isLogin) async {
    await userBox.put(HiveConst.isLogin, isLogin);
  }

  @override
  bool? getFirstOnboard() {
    final onboard = userBox.get(HiveConst.isOnboard);
    return onboard;
  }

  @override
  Future<void> saveFirstIn(bool isOnboard) async {
    await userBox.put(HiveConst.isOnboard, isOnboard);
  }

  @override
  bool? getIsSubscription() {
    final isSubscription = userBox.get(HiveConst.isSubscription);
    return isSubscription;
  }

  @override
  Future<void> saveIsSubscription(bool isSubscription) async {
    await userBox.put(HiveConst.isOnboard, isSubscription);
  }

  @override
  int? getCredits() {
    final credits = userBox.get(HiveConst.credits);
    return credits;
  }

  @override
  Future<void> saveCredits(int credits) async {
    await userBox.put(HiveConst.credits, credits);
  }

  @override
  bool? getIsSaveVip() {
    final isShowVip = userBox.get(HiveConst.isShowVip);
    return isShowVip;
  }

  @override
  Future<void> saveIShowVip(bool isShowVip) async {
    await userBox.put(HiveConst.isShowVip, isShowVip);
  }
}
