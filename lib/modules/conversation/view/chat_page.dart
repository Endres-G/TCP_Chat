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

class ChatPage extends StatelessWidget {
  final ChatEntity chatSelected;
  final ChatController chatController = ChatController();
  final TcpController tcpController = TcpController();

  ChatPage({required this.chatSelected});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(chatSelected.receiver), //colocar o id da conversa
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: chatSelected.messages?.length,
              itemBuilder: (context, index) {
                print("zzz${chatSelected.messages?.length}");
                final message = chatSelected.messages?[index];
                print("zzz${message}");
                print("zzz${message.runtimeType}");
                //pegando a mensagem da lista de mensagens do chat
                Future<bool> sentByMe =
                    chatController.isSentByMe(chatSelected.receiver);
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ChatBubble(
                    message: message["content"],
                    isSentByMe: sentByMe,
                  ),
                );
              },
            ),
          ),
          MessageInput(
            onMessageSend: (text) {
              final double time =
                  DateTime.now().toUtc().millisecondsSinceEpoch / 1000;

              // enviando msg pro server
              Future<String?> id =
                  tcpController.sendTextMessage(chatSelected.receiver, text);

              MessageEntity messageDone = MessageEntity(
                  senderId: id,
                  receiverId: chatSelected.receiver,
                  content: text,
                  timeStamp: time.toString());

              // adicionando MessageEntity na lista de MessageEntity do Chat

              chatSelected.messages?.add(messageDone);

              // atualizando o usuário salvando o chat com uma mensagem
              Future<void> savingOnCache(
                  String idUser, List<ChatEntity> chatList) async {
                await Get.find<GlobalController>().saveUserSession(UserEntity(
                    id: idUser,
                    chats: chatList // salva o nosso ID e chat na cache
                    ));
              }

              // Mostra a msg na tela
              (context as Element).markNeedsBuild();
            },
          ),
        ],
      ),
    );
  }
}
