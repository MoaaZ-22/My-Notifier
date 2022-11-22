import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {

  static SharedPreferences? sharedpreferences ;

  static init() async
  {
    sharedpreferences = await SharedPreferences.getInstance();
  }

  static Future<bool?> setDataIntoShPre({required String key ,required bool value}) async
  {
    return await sharedpreferences?.setBool(key, value);
  }

  static bool? getDataIntoShPre({required String key})
  {
    return  sharedpreferences?.getBool(key);
  }

  static Future<bool?> saveData({required String key, required dynamic value}) async
  {
    if(value is String) return await sharedpreferences?.setString(key, value);
    if(value is int) return await sharedpreferences?.setInt(key, value);
    if(value is bool) return await sharedpreferences?.setBool(key, value);
    return sharedpreferences?.setDouble(key, value);
  }


  // Method To Remove Shared Info About User And Return To Login
  static Future<bool?> removeUserData({required String key}) async
  {
    return await sharedpreferences?.remove(key);
  }


  static Future<bool> setStringList(String key, List<String> list) async {

    return sharedpreferences!.setStringList(key, list);
  }


  static getStringList(String key) {
    return sharedpreferences?.getStringList(key) ?? [];
  }
}