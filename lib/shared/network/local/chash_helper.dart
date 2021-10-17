import 'package:shared_preferences/shared_preferences.dart';

class ChashHelper{

  static late SharedPreferences sharedPreferences;

  static init() async{
    sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<bool> setBoolData(
    {
      required String key,
      required bool value
    }
  ) async{
   return await sharedPreferences.setBool(key, value);
  }

  bool? getBoolData({
    required String key,
  }){
  return  sharedPreferences.getBool(key);
  }

}