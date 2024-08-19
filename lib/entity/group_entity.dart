import 'package:get/get.dart';
import 'package:whats_2/entity/message_entity.dart';

class GroupEntity extends GetxController {
  List<MessageEntity>? messages;
  String receiver1;
  String receiver2;
  String receiver3;
  String receiver4;
  String idGroup;
  DateTime? lastViewedMessage;
  DateTime? lastReceivedMessage;
  String? lastMessage;

  GroupEntity(
      {required this.idGroup,
      required this.receiver1,
      required this.receiver2,
      required this.receiver3,
      required this.receiver4});
}
