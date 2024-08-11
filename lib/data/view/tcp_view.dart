import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whats_2/data/controller/tcp_controller.dart';

class TcpView extends StatelessWidget {
  final TcpController controller = Get.put(TcpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TCP Communication'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Obx(() {
              return Text('Received Data: ${controller.receivedData}');
            }),
            TextField(
              controller: controller.textController,
              decoration: const InputDecoration(labelText: 'Send Message'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                controller.sendMessage(controller.textController.text);
              },
              child: const Text('Send'),
            ),
          ],
        ),
      ),
    );
  }
}
