import 'dart:convert';

class MessageEntity {
  dynamic? senderId;
  String? receiverId;
  String content;
  String? timeStamp;

  MessageEntity({
    required this.senderId,
    required this.receiverId,
    required this.content,
    required this.timeStamp,
  });

  // Serializa a mensagem para JSON
  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'content': content,
      'timeStamp': timeStamp,
    };
  }

  // Desserializa a mensagem a partir de JSON
  factory MessageEntity.fromJson(Map<String, dynamic> json) {
    return MessageEntity(
      senderId: json['senderId'],
      receiverId: json['receiverId'],
      content: json['content'],
      timeStamp: json['timeStamp'],
    );
  }

  factory MessageEntity.fromMap(Map<String, dynamic> json) {
    return MessageEntity(
      senderId: json['senderId'],
      receiverId: json['receiverId'],
      content: json['content'],
      timeStamp: json['timeStamp'],
    );
  }
}
