import 'package:flutter/material.dart';
import 'package:whats_2/data/controller/tcp_controller.dart';
import 'package:whats_2/modules/conversation/view/chat_page.dart';
import 'package:whats_2/entity/chat_entity.dart';
import 'package:whats_2/modules/conversation/controller/chat_controller.dart';

class ConversationsPage extends StatefulWidget {
  @override
  _ConversationsPageState createState() => _ConversationsPageState();
}

class _ConversationsPageState extends State<ConversationsPage>
    with AutomaticKeepAliveClientMixin {
  final ChatController chatController = ChatController();
  final TcpController tcpController = TcpController();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: ListView.builder(
        itemCount: chatController.conversations1.length,
        itemBuilder: (context, index) {
          final chat = chatController.conversations1[index];
          var lastMessage = chat.lastMessage;
          lastMessage ?? (lastMessage = "última msg aqui");
          return ListTile(
            title: Text(chat.receiver),
            subtitle: Text(lastMessage),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatPage(
                    chatSelected: chat,
                  ),
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

  void _addChat(String id) {
    setState(() {
      chatController.conversations1
          .add(ChatEntity(receiver: id, messages: chatController.messages));
    });
  }

  @override
  bool get wantKeepAlive => true;
}
