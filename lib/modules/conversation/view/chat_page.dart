import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:whats_2/core/widgets/chat_bubble.dart';
import 'package:whats_2/core/widgets/message_input.dart';
import 'package:whats_2/data/controller/tcp_controller.dart';
import 'package:whats_2/entity/chat_entity.dart';
import 'package:whats_2/entity/message_entity.dart';
import 'package:whats_2/entity/user_entity.dart';
import 'package:whats_2/global_controller.dart';
import 'package:whats_2/modules/conversation/controller/chat_controller.dart'; //chatController

class ChatPage extends GetView<TcpController> {
  final int index;

  ChatPage({super.key, required this.index});

  final ChatController chatController = ChatController();

  sendTextMessage(String receiver, String text) async {
    await controller.sendTextMessage(receiver, text);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final _count = controller.count.value;
        ChatEntity chat = controller.userChats.value[index];
        return Scaffold(
          appBar: AppBar(
            title: Text(chat.receiver), //colocar o id da conversa
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: chat.messages?.length,
                  itemBuilder: (context, index) {
                    final message = chat.messages?[index];
                    Future<bool> sentByMe =
                        chatController.isSentByMe(chat.receiver);
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ChatBubble(
                        message: message?.content ?? "Error",
                        isSentByMe: sentByMe,
                      ),
                    );
                  },
                ),
              ),
              MessageInput(
                  onMessageSend: (value) =>
                      sendTextMessage(chat.receiver, value)),
            ],
          ),
        );
      },
    );
  }
}
