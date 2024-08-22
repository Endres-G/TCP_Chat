import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whats_2/entity/chat_entity.dart';
import 'package:whats_2/entity/message_entity.dart';
import 'package:whats_2/entity/user_entity.dart';

class GlobalController extends GetxController {
  static const String _keyUserSession = "user_session";
  static const String _keyMessageSession = "message_session";
  static const String _keyChatSession = "chat_session";

  Future<void> saveUserSession(UserEntity userEntity) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(_keyUserSession, userEntity.toJsonString());
  }

  Future<void> saveChatSession(ChatEntity chatEntity) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
        _keyChatSession, chatEntity.toJsonString().toString());
  }

  Future<ChatEntity?> getChatSession() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_keyChatSession);
    if (jsonString != null) {
      final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
      return ChatEntity.fromJson(jsonMap);
    }
    return null;
  }

  Future<String?> getUserId() async {
    final userInstance = await Get.find<GlobalController>().getUserSession();
    final userId = userInstance?.id;
    return userId;
  }

  Future<UserEntity?> getUserSession() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_keyUserSession);
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
}
