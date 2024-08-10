import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whats_2/app/controller/home_controller.dart';

class HomeView extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());
  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() => Text(controller.count.toString())),
            ElevatedButton(onPressed: addCount, child: const Text("apertaaaa"))
          ],
        ),
      ),
    );
  }

  void addCount() {
    controller.count.value++;
  }
}
