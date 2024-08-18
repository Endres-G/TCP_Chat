class MessageEntity {
  String? id;
  String? senderId;
  String? receiverId;
  String? content;
  DateTime? timeStamp;

  MessageEntity({
    this.id,
    this.senderId,
    this.receiverId,
    this.content,
    this.timeStamp,
  });

  // Serializa a mensagem para JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'senderId': senderId,
      'receiverId': receiverId,
      'content': content,
      'timeStamp': timeStamp?.toIso8601String(),
    };
  }

  // Desserializa a mensagem a partir de JSON
  factory MessageEntity.fromJson(Map<String, dynamic> json) {
    return MessageEntity(
      id: json['id'],
      senderId: json['senderId'],
      receiverId: json['receiverId'],
      content: json['content'],
      timeStamp:
          json['timeStamp'] != null ? DateTime.parse(json['timeStamp']) : null,
    );
  }
}
