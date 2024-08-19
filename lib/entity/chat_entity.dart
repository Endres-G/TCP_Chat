import 'package:get/get.dart';
import 'package:whats_2/entity/message_entity.dart';

class ChatEntity extends GetxController {
  List<MessageEntity>? messages;
  String receiver;
  DateTime? lastViewedMessage;
  DateTime? lastReceivedMessage;
  String? lastMessage;

  ChatEntity({required this.receiver});
}
