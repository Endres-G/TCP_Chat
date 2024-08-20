import 'package:get/get.dart';
import 'package:whats_2/entity/message_entity.dart';
import 'package:whats_2/global_controller.dart';

class ChatController {
  List<MessageEntity> messages = [];

  Future<MessageEntity?> sendMessageToList({
    required String content,
    String? senderId,
    required String receiverId,
    required String timeStamp,
  }) async {
    final userId = await Get.find<GlobalController>().getUserId();

    final message = MessageEntity(
      senderId: userId,
      receiverId: receiverId,
      content: content,
      timeStamp: timeStamp,
    );
    print(userId);
    print(message.content);
    print(message.receiverId);
    print(message.timeStamp);
    messages.add(message);
    return message;
  }

  Future<bool> isSentByMe(MessageEntity message) async {
    final userId = await Get.find<GlobalController>().getUserId();

    return message.senderId == userId;
  }
}
