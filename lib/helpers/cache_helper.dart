import 'package:shared_preferences/shared_preferences.dart';

abstract class CacheHelper{
  static late SharedPreferences _cacheHelper;

  static Future init() async{
    _cacheHelper = await SharedPreferences.getInstance();
  }

  static void setBool({required String key, required bool value }) async{
    await _cacheHelper.setBool(key, value);
  }

  static Future<bool> setData({required String key, required String value}) async{
    return await _cacheHelper.setString(key, value);
  }

  static dynamic getData({required String key}){
    return _cacheHelper.get(key);
  }

  static clearData({required String key}) async{
    await _cacheHelper.remove(key);
  }
}