import 'dart:convert'; // Para utf8.decode
import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:whats_2/entity/user_entity.dart';
import 'package:whats_2/global_controller.dart';

class TcpController extends GetxController {
  late Socket _socket;
  var receivedData = ''.obs; // Observable variable
  final TextEditingController textController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    _connectToServer();
  }

  void _connectToServer() async {
    try {
      // Conecta ao servidor Python
      _socket = await Socket.connect('0.tcp.sa.ngrok.io', 10215);
      print(
          'Connected to: ${_socket.remoteAddress.address}:${_socket.remotePort}');

      // Ouve por dados do servidor
      _socket.listen((data) async {
        receivedData.value = utf8.decode(data); // retorno do servidor

        print(receivedData);
        receivedData.toString;
        final session =
            await Get.find<GlobalController>().saveUserSession(UserEntity(
          id: receivedData.substring(2),
          // chats: [],
        ));
      }, onError: (error) {
        print('Error: $error');
        _socket.destroy();
      }, onDone: () {
        print('Server disconnected');
        _socket.destroy();
      });
    } catch (e) {
      print('Unable to connect: $e');
    }
  }

  void sendMessage(String message) {
    if (_socket != null) {
      _socket.write(message);
    }
  }

  @override
  void onClose() {
    _socket.destroy();
    super.onClose();
  }

  // TcpController saveId() {

  // }
}
