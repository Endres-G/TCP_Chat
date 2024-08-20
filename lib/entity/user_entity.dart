import 'dart:convert';

import 'package:get/get.dart';
import 'package:whats_2/entity/chat_entity.dart';

class UserEntity extends GetxController {
  String? id;
  List<ChatEntity>? chats;

  UserEntity({
    required this.id,
    required this.chats,
  });

  Map<String, dynamic> toMap() {
    return {'id': id, 'chats': chats};
  }

  String toJsonString() {
    return jsonEncode(toMap());
  }

  static UserEntity empty() {
    return UserEntity(
      id: "",
      chats: [],
    );
  }

  static UserEntity fromMap(map) {
    return UserEntity(
      id: map['id'],
      chats: map['chats'],
    );
  }
}
