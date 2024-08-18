import 'package:whats_2/data/view/message.dart';

class ChatController {
  List<Message> messages = [
    Message(content: 'Olá!', isSentByMe: false),
    Message(content: 'Oi, como vai?', isSentByMe: true),
  ];

  void sendMessage(String content) {
    messages.add(Message(content: content, isSentByMe: true));
  }
}
