import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whats_2/modules/register/controller/register.controller.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtenha uma instância do RegisterController
    final RegisterController registerController =
        Get.find<RegisterController>();
    final now = DateTime.now().toUtc().millisecondsSinceEpoch / 1000;

    print(now);
    // Verifica o usuário e redireciona
    Future.delayed(const Duration(seconds: 2), () async {
      await registerController.createUser();
    });

    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
