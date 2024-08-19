import 'package:flutter/material.dart';
import 'package:whats_2/core/widgets/chat_bubble.dart';
import 'package:whats_2/core/widgets/message_input.dart';
import 'package:whats_2/data/controller/chat_controller.dart';

class ChatScreen extends StatelessWidget {
  final String conversationTitle;
  final ChatController _controller = ChatController();

  ChatScreen({required this.conversationTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(conversationTitle),
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
                    message: message.content ?? '',
                    isSentByMe: sentByMe,
                  ),
                );
              },
            ),
          ),
          MessageInput(
            onMessageSend: (text) {
              _controller.sendMessage(text);
            },
          ),
        ],
      ),
    );
  }
}
