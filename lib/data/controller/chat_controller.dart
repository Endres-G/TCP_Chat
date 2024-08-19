import 'package:whats_2/entity/message_entity.dart';

class ChatController {
  List<MessageEntity> messages = [];
  final String currentUserId = 'user123';

  void sendMessage(String content) {
    final message = MessageEntity(
      id: "01",
      senderId: "123456789",
      receiverId: "987654321",
      content: content,
      timeStamp: DateTime.now(),
    );
    messages.add(message);
  }

  bool isSentByMe(MessageEntity message) {
    return message.senderId == currentUserId;
  }
}
