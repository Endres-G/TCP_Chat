import 'package:flutter/material.dart';
import 'package:whats_2/core/widgets/chat_bubble.dart';
import 'package:whats_2/core/widgets/message_input.dart';
import 'package:whats_2/data/controller/tcp_controller.dart';
import 'package:whats_2/modules/conversation/controller/chat_controller.dart';

class ChatPage extends StatelessWidget {
  final String conversationId;
  final ChatController _controller = ChatController();
  final TcpController controller = TcpController();
  var time = DateTime.now().toUtc().millisecondsSinceEpoch / 1000;

  ChatPage({required this.conversationId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(conversationId),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _controller.messages.length,
              itemBuilder: (context, index) {
                final message = _controller.messages[index];
                Future<bool> sentByMe = _controller.isSentByMe(message);
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
              controller.sendTextMessage(conversationId, text);
              _controller.sendMessageToList(
                content: text,
                receiverId: conversationId,
                timeStamp: time.toString().substring(1, 10),
              );
              // Mostra a msg
              (context as Element).markNeedsBuild();
            },
          ),
        ],
      ),
    );
  }
}
