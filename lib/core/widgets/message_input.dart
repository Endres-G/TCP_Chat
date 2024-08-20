import 'package:flutter/material.dart';
import 'package:whats_2/data/controller/tcp_controller.dart';

class MessageInput extends StatelessWidget {
  final Function(String) onMessageSend;
  final TcpController controller = TcpController();

  MessageInput({required this.onMessageSend});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Digite uma mensagem...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              onMessageSend(_controller.text);
              _controller.clear();
            },
          ),
        ],
      ),
    );
  }
}
