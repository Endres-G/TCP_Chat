import 'package:flutter/material.dart';
import 'package:whats_2/modules/conversation/view/chat_page.dart';
import 'package:whats_2/entity/chat_entity.dart';

class ConversationsPage extends StatefulWidget {
  @override
  _ConversationsPageState createState() => _ConversationsPageState();
}

class _ConversationsPageState extends State<ConversationsPage>
    with AutomaticKeepAliveClientMixin {
  final List<ChatEntity> _conversations = [];

  void _addChat(String id) {
    setState(() {
      _conversations.add(ChatEntity(receiver: id));
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: ListView.builder(
        itemCount: _conversations.length,
        itemBuilder: (context, index) {
          final chat = _conversations[index];
          var lastMessage = chat.lastMessage;
          lastMessage ?? (lastMessage = "última msg aqui");
          return ListTile(
            title: Text(chat.receiver),
            subtitle: Text(lastMessage),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatPage(conversationId: chat.receiver),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addChatButton(),
        child: Icon(Icons.add),
      ),
    );
  }

  void _addChatButton() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final TextEditingController _textController = TextEditingController();
        return AlertDialog(
          title: Text('Adicionar Conversa:'),
          content: TextField(
            controller: _textController,
            decoration: InputDecoration(hintText: 'ID:'),
          ),
          actions: [
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Adicionar'),
              onPressed: () {
                final id = _textController.text;
                _addChat(id);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
