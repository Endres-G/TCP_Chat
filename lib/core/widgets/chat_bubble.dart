import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isSentByMe;

  ChatBubble({required this.message, required this.isSentByMe});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: isSentByMe ? Colors.green[100] : Colors.grey[300],
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Text(message),
      ),
    );
  }
}
