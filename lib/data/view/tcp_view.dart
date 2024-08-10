import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whats_2/data/controller/tcp_controller.dart';

class TcpView extends StatelessWidget {
  final TcpController controller = Get.put(TcpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TCP Communication'),
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
              decoration: InputDecoration(labelText: 'Send Message'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                controller.sendMessage(controller.textController.text);
              },
              child: Text('Send'),
            ),
          ],
        ),
      ),
    );
  }
}
