import 'dart:convert'; // Para utf8.decode
import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

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
      _socket = await Socket.connect('10.0.2.2', 65432);
      print(
          'Connected to: ${_socket.remoteAddress.address}:${_socket.remotePort}');

      // Ouve por dados do servidor
      _socket.listen((data) {
        receivedData.value =
            utf8.decode(data); // Atualiza a variável observável
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
}
