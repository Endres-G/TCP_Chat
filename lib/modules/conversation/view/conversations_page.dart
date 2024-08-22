import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:whats_2/data/controller/tcp_controller.dart';
import 'package:whats_2/entity/user_entity.dart';
import 'package:whats_2/global_controller.dart';
import 'package:whats_2/modules/conversation/view/chat_page.dart';
import 'package:whats_2/entity/chat_entity.dart';
import 'package:whats_2/modules/conversation/controller/chat_controller.dart';

class ConversationsPage extends StatefulWidget {
  final Future<UserEntity?> user;
  const ConversationsPage({required this.user, Key? key}) : super(key: key);

  @override
  _ConversationsPageState createState() => _ConversationsPageState();
}

class _ConversationsPageState extends State<ConversationsPage>
    with AutomaticKeepAliveClientMixin {
  final ChatController chatController = ChatController();
  final TcpController tcpController = TcpController();
  late Future<UserEntity?> _userFuture;

  @override
  void initState() {
    super.initState();

    _userFuture = widget.user; // Inicializa o Future
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: FutureBuilder<UserEntity?>(
        future: _userFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            print("ddd${snapshot.data}");
            return Center(child: Text('Nenhum usuário encontrado.'));
          } else {
            final user = snapshot.data!;
            return ListView.builder(
              itemCount: user.chats?.length ?? 0,
              itemBuilder: (context, index) {
                final ChatEntity? chat = user.chats?[index];

                return ListTile(
                  title: Text(chat!.receiver),
                  subtitle: Text("última mensagem aqui"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatPage(
                          index: index,
                        ),
                      ),
                    );
                  },
                );
              },
            );
          }
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
                final id = "10000000000${_textController.text}";
                _addChat(id);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _addChat(String id) async {
    // Obtemos o usuário atual
    final user = await _userFuture;

    if (user != null) {
      // Atualiza o estado com a cópia local do usuário
      final List<ChatEntity> chats = Get.find<TcpController>().userChats.value;
      chats.add(ChatEntity(receiver: id, messages: []));
      print("aaa${user.chats}");
      setState(() {
        print("sss${chatController.messages}");
        user.chats = chats;

        // Atualiza o Future para refletir a mudança

        _userFuture = Future.value(user);
      });
      Get.find<TcpController>().userChats.value = chats;

      await Get.find<GlobalController>().saveUserSession(UserEntity(
        id: user.id, chats: chats, // salva o nosso ID e chat na cache
      ));

      print("aaa${user.chats}");
    }
  }

  @override
  bool get wantKeepAlive => true;
}
