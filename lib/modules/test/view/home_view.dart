import 'package:flutter/material.dart';
import 'package:whats_2/entity/user_entity.dart';
import 'package:whats_2/modules/conversation/view/conversations_page.dart';
import 'package:whats_2/modules/test/controller/home_controller.dart';
import 'package:whats_2/screens/groups_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final HomeController homeController = HomeController();

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
        body: FutureBuilder<UserEntity?>(
          future: homeController.getUser(),
          // Chama o Future diretamente aqui
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Erro: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data == null) {
              print("dddd${snapshot.data}");
              return Center(child: Text('Nenhum usuário encontrado.'));
            } else {
              final user = snapshot.data!;

              return TabBarView(
                children: [
                  ConversationsPage(
                    user: Future.value(user), // Passa um Future com o resultado
                  ),
                  GroupsPage(),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
