import 'dart:convert';

import 'package:get/get.dart';
import 'package:whats_2/entity/message_entity.dart';

class ChatEntity extends GetxController {
  List<MessageEntity>? messages;
  String receiver;
  DateTime? lastViewedMessage;
  DateTime? lastReceivedMessage;
  List<String?>? lastMessage = ["q"];

  ChatEntity({required this.receiver, required this.messages});

  Map<String, dynamic> toMap() {
    return {
      'messages': messages?.map((e) => e.toMap()).toList() ?? [],
      'receiver': receiver,
      'lastViewedMessage': lastViewedMessage,
      'lastReceivedMessage': lastReceivedMessage,
      'lastMessage': lastMessage,
    };
  }

  // Desserializa a mensagem a partir de JSON
  factory ChatEntity.fromJson(Map<String, dynamic> json) {
    return ChatEntity(
      messages: json['messages'],
      receiver: json['receiver'],
    );
  }

  factory ChatEntity.fromMap(Map<String, dynamic> map) {
    return ChatEntity(
      messages: List<MessageEntity>.from(map['messages'].map((chat) {
        return MessageEntity.fromMap(chat);
      })),
      receiver: map["receiver"],
    );
  }

  String toJsonString() {
    return jsonEncode(toMap());
  }
}
