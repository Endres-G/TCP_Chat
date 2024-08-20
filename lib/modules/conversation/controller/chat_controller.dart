import 'package:get/get.dart';
import 'package:whats_2/entity/chat_entity.dart';
import 'package:whats_2/entity/message_entity.dart';
import 'package:whats_2/entity/user_entity.dart';
import 'package:whats_2/global_controller.dart';

class ChatController {
  List<MessageEntity> messages = [];
  List<ChatEntity> conversations1 = [];
  late Future<List<ChatEntity>?> conversations2;

  Future<MessageEntity?> sendMessageToList({
    required List<MessageEntity>? list,
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
    list?.add(message);
    return message;
  }

  Future<bool> isSentByMe(MessageEntity message) async {
    final userId = await Get.find<GlobalController>().getUserId();

    return message.senderId == userId;
  }

//t
  Future<List<ChatEntity>?> getChatsUser() async {
    final userSession = await Get.find<GlobalController>().getUserSession();
    print(userSession?.chats);
    return userSession?.chats;
  }
}
