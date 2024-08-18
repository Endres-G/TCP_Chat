import 'package:flutter/material.dart';
import 'package:whats_2/screens/chat_page.dart';

class GroupsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('Grupo $index'),
          subtitle: Text('Última mensagem...'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ChatScreen(conversationTitle: 'Grupo $index'),
              ),
            );
          },
        );
      },
    );
  }
}
