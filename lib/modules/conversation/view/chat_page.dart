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

class ChatPage extends StatefulWidget {
  final ChatEntity chatSelected;

  const ChatPage({super.key, required this.chatSelected});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ChatController chatController = ChatController();
  final TcpController tcpController = TcpController();

  late ChatEntity chat;

  @override
  initState() {
    chat = widget.chatSelected;
    super.initState();
  }

  a(String text) async {
    final double time = DateTime.now().toUtc().millisecondsSinceEpoch / 1000;

    // enviando msg pro server
    final id = await tcpController.sendTextMessage(chat.receiver, text);

    MessageEntity messageDone = MessageEntity(
        senderId: id,
        receiverId: chat.receiver,
        content: text,
        timeStamp: time.toString());

    // adicionando MessageEntity na lista de MessageEntity do Chat
    setState(() {
      chat.messages?.add(messageDone);
    });

    // atualizando o usuário salvando o chat com uma mensagem
    // Future<void> savingOnCache(
    //     String idUser, List<ChatEntity> chatList) async {
    //   await Get.find<GlobalController>().saveUserSession(UserEntity(
    //       id: id,
    //       chats: chatList // salva o nosso ID e chat na cache
    //       ));
    // }
  }

  @override
  Widget build(BuildContext context) {
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
          MessageInput(onMessageSend: a),
        ],
      ),
    );
  }
}
