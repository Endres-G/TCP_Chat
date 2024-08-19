class MessageEntity {
  Future<String?> senderId;
  String receiverId;
  String content;
  DateTime? timeStamp;

  MessageEntity({
    required this.senderId,
    required this.receiverId,
    required this.content,
    required this.timeStamp,
  });

  // Serializa a mensagem para JSON
  Map<String, dynamic> toJson() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'content': content,
      'timeStamp': timeStamp?.toIso8601String(),
    };
  }

  // Desserializa a mensagem a partir de JSON
  factory MessageEntity.fromJson(Map<String, dynamic> json) {
    return MessageEntity(
      senderId: json['senderId'],
      receiverId: json['receiverId'],
      content: json['content'],
      timeStamp:
          json['timeStamp'] != null ? DateTime.parse(json['timeStamp']) : null,
    );
  }
}
