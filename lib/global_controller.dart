import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whats_2/entity/message_entity.dart';
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

  Future<String?> getUserId() async {
    final userInstance = await Get.find<GlobalController>().getUserSession();
    final userId = userInstance?.id;
    return userId;
  }

  Future<UserEntity?> getUserSession() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_keyUserSession);

    print(jsonString);
    if (jsonString != null) {
      final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
      print(jsonMap["id"]);

      return UserEntity.fromMap(jsonMap);
    }
    return null;
  }

  Future<void> clearUserSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyUserSession);
  }

  Future<void> saveMessages(String userId, List<MessageEntity> messages) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> messageJsons =
        messages.map((msg) => jsonEncode(msg.toJson())).toList();
    await prefs.setStringList('messages_$userId', messageJsons);
  }

  Future<List<MessageEntity>> loadMessages(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? messageJsons = prefs.getStringList('messages_$userId');
    if (messageJsons == null) return [];
    return messageJsons
        .map((json) => MessageEntity.fromJson(jsonDecode(json)))
        .toList();
  }
}
