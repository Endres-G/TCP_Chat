import 'package:whats_2/entity/message_entity.dart';
import 'package:whats_2/global_controller.dart';

class ChatController {
  List<MessageEntity> messages = [];
  final userId = GlobalController().getUserId();

  void sendMessage({
    required String content,
    Future<String>? senderId,
    required String receiverId,
    required DateTime timeStamp,
  }) {
    final message = MessageEntity(
      senderId: userId,
      receiverId: receiverId,
      content: content,
      timeStamp: timeStamp,
    );

    messages.add(message);
  }

  bool isSentByMe(MessageEntity message) {
    return message.senderId == userId;
  }
}
