import 'package:get/get.dart';
import 'package:whats_2/entity/chat_entity.dart';
import 'package:whats_2/entity/message_entity.dart';
import 'package:whats_2/entity/user_entity.dart';
import 'package:whats_2/global_controller.dart';

class ChatController {
  List<MessageEntity> messages = [];

  Future<List<MessageEntity>?> sendMessageToList({
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
    print("ccc3${list}");
    list?.add(message);
    print("ccc4${list}");
    return list;
  }

//t
  Future<List?> getChatsUser() async {
    final userSession = await Get.find<GlobalController>().getUserSession();
    print(userSession?.chats);
    return userSession?.chats;
  }
}
