import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whats_2/entity/user_entity.dart';

class GlobalController extends GetxController {
  UserEntity? userEntity = UserEntity.empty();
  static const String _keyUserSession = "user_session";

  Future<void> saveUserSession(UserEntity userEntity) async {
    final prefs = await SharedPreferences.getInstance();

    print(userEntity.toMap().toString());
    print(userEntity.toMap().toString().runtimeType);
    await prefs.setString(
        _keyUserSession, userEntity.toJsonString().toString());
  }

  Future<UserEntity?> getUserSession() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_keyUserSession);
    print("ta dando o get");
    print(jsonString);
    if (jsonString != null) {
      final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
      print(jsonMap["name"]);
      print(UserEntity.fromMap(jsonMap));
      return UserEntity.fromMap(jsonMap);
    }
    return null;
  }

  Future<void> clearUserSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyUserSession);
  }
}
