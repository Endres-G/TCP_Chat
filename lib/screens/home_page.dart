import 'package:flutter/material.dart';
import 'conversations_page.dart';
import 'groups_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Chat App'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Conversas'),
              Tab(text: 'Grupos'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ConversationsPage(),
            GroupsPage(),
          ],
        ),
      ),
    );
  }
}
