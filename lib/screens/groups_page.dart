import 'package:flutter/material.dart';
import 'package:whats_2/entity/group_entity.dart';
import 'package:whats_2/screens/chat_page.dart';

class GroupsPage extends StatefulWidget {
  @override
  _GroupsPageState createState() => _GroupsPageState();
}

class _GroupsPageState extends State<GroupsPage>
    with AutomaticKeepAliveClientMixin {
  final List<GroupEntity> _Groups = [];

  void _addgroup(
      String idGroup, String id1, String id2, String id3, String id4) {
    setState(() {
      _Groups.add(GroupEntity(
          idGroup: idGroup,
          receiver1: id1,
          receiver2: id2,
          receiver3: id3,
          receiver4: id4));
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: ListView.builder(
        itemCount: _Groups.length,
        itemBuilder: (context, index) {
          final group = _Groups[index];
          var lastMessage = group.lastMessage;
          lastMessage ?? (lastMessage = "última msg aqui");
          return ListTile(
            title: Text(group.idGroup),
            subtitle: Text(lastMessage),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatPage(conversationId: group.idGroup),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addgroupButton(),
        child: Icon(Icons.add),
      ),
    );
  }

//
  void _addgroupButton() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final TextEditingController _textControllerGroup =
            TextEditingController();
        final TextEditingController _textController1 = TextEditingController();
        final TextEditingController _textController2 = TextEditingController();
        final TextEditingController _textController3 = TextEditingController();
        final TextEditingController _textController4 = TextEditingController();

        return AlertDialog(
          title: Text('Adicionar Grupo:'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _textControllerGroup,
                decoration: InputDecoration(hintText: 'ID Group:'),
              ),
              TextField(
                controller: _textController1,
                decoration: InputDecoration(hintText: 'ID 1:'),
              ),
              TextField(
                controller: _textController2,
                decoration: InputDecoration(hintText: 'ID 2:'),
              ),
              TextField(
                controller: _textController3,
                decoration: InputDecoration(hintText: 'ID 3:'),
              ),
              TextField(
                controller: _textController4,
                decoration: InputDecoration(hintText: 'ID 4:'),
              ),
            ],
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
                final idGroup = _textControllerGroup.text;
                final id1 = _textController1.text;
                final id2 = _textController2.text;
                final id3 = _textController3.text;
                final id4 = _textController4.text;

                // Aqui você pode manipular os IDs conforme necessário
                _addgroup(idGroup, id1, id2, id3, id4);
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
