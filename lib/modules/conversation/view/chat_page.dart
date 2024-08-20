import 'package:flutter/material.dart';
import 'package:whats_2/core/widgets/chat_bubble.dart';
import 'package:whats_2/core/widgets/message_input.dart';
import 'package:whats_2/data/controller/tcp_controller.dart';
import 'package:whats_2/entity/chat_entity.dart';
import 'package:whats_2/modules/conversation/controller/chat_controller.dart'; //chatController

class ChatPage extends StatelessWidget {
  final ChatEntity chatSelected;
  final ChatController chatController = ChatController();
  final TcpController tcpController = TcpController();
  var time = DateTime.now().toUtc().millisecondsSinceEpoch / 1000;

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
                final message = chatSelected.messages?[
                    index]; //pegando a mensagem da lista de mensagens do chat
                Future<bool> sentByMe = chatController.isSentByMe(message!);
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ChatBubble(
                    message: message.content,
                    isSentByMe: sentByMe,
                  ),
                );
              },
            ),
          ),
          MessageInput(
            onMessageSend: (text) {
              tcpController.sendTextMessage(chatSelected.receiver,
                  text); //enviando pro server e pra cache
              chatController.sendMessageToList(
                //enviando pra lista
                list: chatSelected.messages,
                content: text,
                receiverId: chatSelected.receiver,
                timeStamp: time.toString().substring(1, 10),
              );
              // Mostra a msg na tela
              (context as Element).markNeedsBuild();
            },
          ),
        ],
      ),
    );
  }
}
