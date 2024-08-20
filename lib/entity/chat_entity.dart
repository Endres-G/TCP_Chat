import 'dart:convert';

import 'package:get/get.dart';
import 'package:whats_2/entity/message_entity.dart';

class ChatEntity extends GetxController {
  List<MessageEntity>? messages;
  String receiver;
  DateTime? lastViewedMessage;
  DateTime? lastReceivedMessage;
  String? lastMessage;

  ChatEntity({required this.receiver, required this.messages});

  Map<String, dynamic> toMap() {
    return {
      'messages': messages,
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

  String toJsonString() {
    return jsonEncode(toMap());
  }
}
