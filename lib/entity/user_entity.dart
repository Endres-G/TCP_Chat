import 'dart:convert';

import 'package:get/get.dart';
import 'package:whats_2/entity/chat_entity.dart';
import 'package:whats_2/entity/message_entity.dart';

class UserEntity extends GetxController {
  String id;
  List<ChatEntity> chats;

  UserEntity({
    required this.id,
    required this.chats,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'chats': chats.map((chat) => chat.toMap()).toList(),
    };
  }

  String toJsonString() {
    return jsonEncode(toMap());
  }

  factory UserEntity.fromMap(Map<String, dynamic> map) {
    return UserEntity(
      id: map['id'],
      chats: List<ChatEntity>.from(map['chats'].map((chat) {
        return ChatEntity.fromMap(chat);
      })),
    );
  }
}
