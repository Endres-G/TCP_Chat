import 'package:flutter/material.dart';
import 'package:whats_2/core/widgets/chat_bubble.dart';
import 'package:whats_2/core/widgets/message_input.dart';
import 'package:whats_2/data/controller/chat_controller.dart';

class ChatPage extends StatelessWidget {
  final String conversationId;
  final ChatController _controller = ChatController();

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
                bool sentByMe = _controller.isSentByMe(message);
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
              _controller.sendMessage(
                content: text,
                receiverId: conversationId,
                timeStamp: DateTime.now(),
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
