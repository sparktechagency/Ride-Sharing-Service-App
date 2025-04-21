import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/app_constants.dart';

class PrefsHelper extends GetxController {
  static String token = "";
  static String clientId = "";
  static String? myImage = "";
  static String myName = "";
  static String myPhone = "";
  static bool isProvider = false;
  static String mySubscription = "premium-plus";
  static String localizationLanguageCode = 'en';
  static String localizationCountryCode = 'US';

  //==============================> Get All Data Form Shared Preference <==========================

  static Future<void> getAllPrefData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    // token = preferences.getString(AppConstants.bearerToken) ?? "";
    clientId = preferences.getString("") ?? "";
    myImage = preferences.getString("") ?? "";
    myName = preferences.getString("") ?? "";
    myPhone = preferences.getString("") ?? "";
    isProvider = preferences.getBool("") ?? false;
    //  forgetPasswordToken = preferences.getString(AppConstants.forgetPasswordToken) ?? "";
    localizationLanguageCode =
        preferences.getString("localizationLanguageCode") ?? "en";
    localizationCountryCode =
        preferences.getString("localizationCountryCode") ?? "US";
  }

  //===========================> Get Data Form Shared Preference <========================

  static Future<String> getString(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(key) ?? "";
  }

  static Future<bool?> getBool(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(key);
  }

  static Future<int> getInt(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getInt(key) ?? (-1);
  }

  //=============================> Save Data To Shared Preference <========================

  static Future setString(String key, value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString(key, value);
  }

  static Future setBool(String key, bool value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setBool(key, value);
  }

  static Future setInt(String key, int value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setInt(key, value);
  }

  //===============================> Remove Value <==================================
  static Future remove(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.remove(key);
  }

  //==============================> Remove All Data Form Shared Preference <============================
  static Future<void> removeAllPrefData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    // preferences.setString(AppConstants.bearerToken, "");
    // preferences.setString(AppConstants.forgetPasswordToken, "");
    preferences.setString("clientId", "");
    preferences.setString("myEmail", "");
    preferences.setBool("isProvider", false);
    token = "";
    clientId = "";
    isProvider = false;
    myName = "";
    myPhone = "";
    // preferences.remove(AppConstants.bearerToken);
    // preferences.remove(AppConstants.forgetPasswordToken);
    // preferences.remove("clientId");
    //Get.offAllNamed(AppRoutes.logInScreen);
  }
}