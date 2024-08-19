import 'package:flutter/material.dart';
import 'package:whats_2/screens/chat_page.dart';

class ConversationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('Conversa $index'),
          subtitle: const Text('Última mensagem...'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ChatScreen(conversationTitle: 'Conversa $index'),
              ),
            );
          },
        );
      },
    );
  }
}
