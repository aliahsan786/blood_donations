import 'dart:convert';

import 'package:get/get.dart';
import 'package:blood_donations/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  static SharedPreferenceHelper instance = SharedPreferenceHelper();

  static String idTokenKey = "IDTOKENKEY";
  static String userIdKey = "USERIDKEY";
  static String userDataKey = "USERDATA";
  static String chapDataKey = "CHAPDATA";
  static String userFilterKey = "USERFILTER";
  static String userNameKey = "USERNAMEKEY";
  static String displayNameKey = "USERDISPLAYNAME";
  static String adminNameKey = "ADMINNAME";
  static String userEmailKey = "USEREMAILKEY";
  static String adminEmailKey = "ADMINEMAILKEY";
  static String userProfilePicKey = "USERPROFILEKEY";
  static String loginTypeKey = "LOGINTYPEKEY";
  static String chatInfoKey = "CHATINFOKEY";
  static String isAdminKey = "ISADMINKEY";
  static String isSignUpKey = "ISSIGNUPKEY";
  static String isSignInKey = "ISSIGNINKEY";
  static String isPhoneLinkedKey = "ISPHONELINKEDKEY";
  static String isGoogleKey = "ISGOOGLEKEY";
  static String isFacebookKey = "ISFACEBOOKKEY";
  static String isAppleKey = "ISAPPLEKEY";
  static String isVendorKey = "ISVENDORKEY";
  static String isUserKey = "ISUSERKEY";

  //++ save data IN SharedPreference
  //++ save data IN SharedPreference

  Future<bool> saveUserIdToken(String idToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(idTokenKey, idToken);
  }

  Future<String?> getUserIdToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(idTokenKey);
  }

  Future<bool> saveUserName(String userName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userNameKey, userName);
  }

  Future<String?> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userNameKey);
  }

  Future<bool> saveIsVendor(bool isAdmin) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(isVendorKey, isAdmin);
  }

  Future<bool> saveIsUser(bool isUser) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(isUserKey, isUser);
  }

  Future<bool> saveIsAdmin(bool isAdmin) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(isAdminKey, isAdmin);
  }

  Future<bool?> getIsAdmin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(isAdminKey);
  }

  Future<bool?> getIsVendor() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(isVendorKey);
  }

  Future<bool> saveIsSignUp(bool isSignUp) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(isSignUpKey, isSignUp);
  }

  Future<bool?> getIsSignUp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(isSignUpKey);
  }

  Future<bool> saveIsSignIn(bool isSignIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(isSignInKey, isSignIn);
  }

  Future<bool?> getIsSignIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(isSignInKey);
  }

  Future<bool> saveIsPhoneLinked(bool isPhoneLinked) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(isPhoneLinkedKey, isPhoneLinked);
  }

  Future<bool?> getIsPhoneLinked() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(isPhoneLinkedKey);
  }

  Future<bool> saveIsGoogle(bool isGoogle) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(isGoogleKey, isGoogle);
  }

  Future<bool?> getIsGoogle() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(isGoogleKey);
  }

  //+Model Here
  Future<bool> saveUserData(Rx<UserModel> user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // String userDataString = jsonEncode(user);
    return prefs.setString(userDataKey, jsonEncode(user.value.toJson()));
  }

  Future<String?> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userDataKey);
  }

  Future<bool> saveUserEmail(String getUseremail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userEmailKey, getUseremail);
  }

  Future<String?> getUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userEmailKey);
  }

  Future<bool> saveAdminEmail(String getAdminEmail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(adminEmailKey, getAdminEmail);
  }

  Future<String?> getAdminEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(adminEmailKey);
  }

  Future<bool> saveAdminName(String getAdminName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(adminNameKey, getAdminName);
  }

  Future<String?> getAdminName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(adminNameKey);
  }

  Future<bool> saveUserId(String getUserId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userIdKey, getUserId);
  }

  Future<String?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userIdKey);
  }

  Future<bool> saveDisplayName(String getDisplayName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(displayNameKey, getDisplayName);
  }

  Future<String?> getDisplayName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(displayNameKey);
  }

  Future<bool> saveUserProfileUrl(String getUserProfile) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userProfilePicKey, getUserProfile);
  }

  Future<String?> getUserProfileUrl() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userProfilePicKey);
  }

  Future<bool> saveLoginType(String loginType) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(loginTypeKey, loginType);
  }

  Future<String?> getLoginType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(loginTypeKey);
  }

  //++get data FROM SharedPreference
  //++get data FROM SharedPreference

  Future<bool?> getIsUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(isUserKey);
  }

  Future<String?> getUserFilterData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userFilterKey);
  }

  Future<String?> getChapData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(chapDataKey);
  }

  Future<bool> removeUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(userDataKey);
  }

  Future<bool> saveUserChatData(Map<String, dynamic> chatInfo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // String userDataString = jsonEncode(user);
    return prefs.setString(chatInfoKey, jsonEncode(chatInfo));
  }

  Future<bool> logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.remove(userEmailKey);
    return prefs.clear();
  }
}
