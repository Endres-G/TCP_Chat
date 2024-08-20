import 'dart:convert'; // Para utf8.decode
import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:whats_2/entity/message_entity.dart';
import 'package:whats_2/entity/user_entity.dart';
import 'package:whats_2/global_controller.dart';

class TcpController extends GetxController {
  late Socket _socket;
  var receivedData = ''.obs; // Observable variable
  final TextEditingController textController = TextEditingController();
  bool _isConnected = false; // Estado de conexão
  bool _idSaved = false; // Estado do ID

  @override
  void onInit() {
    super.onInit();
    _connectToServer();
  }

  Future<void> _connectToServer() async {
    String connectPaulao = "0.tcp.sa.ngrok.io";
    String connectLocalHost = "192.168.0.106";
    String connectLocalHostEmul = "10.0.2.2";

    try {
      // Conecta ao servidor Python
      _socket = await Socket.connect(connectPaulao, 18148);
      print(
          'Connected to: ${_socket.remoteAddress.address}:${_socket.remotePort}');
      _isConnected = true;

      // Ouve por dados do servidor
      _socket.listen((data) async {
        receivedData.value = utf8.decode(data); // retorno do servidor

        if (!_idSaved && receivedData.startsWith('02')) {
          // Verifica se a mensagem contém o ID
          final id = receivedData.substring(2); // nosso ID
          print("VAI SALVAR NOSSO ID DA SESSÃO!");
          await Get.find<GlobalController>().saveUserSession(UserEntity(
            id: id, // salva o nosso ID na cache
          ));
          _idSaved = true; // Marca como ID salvo
          sendMessage("03$id"); // Loga o user depois de registrado
        }
        if (receivedData.startsWith('07')) {
          // Trata as mensagens de confirmação aqui
          print("Mensagem de confirmação recebida: $receivedData");
        } else if (receivedData.startsWith('06')) {
          await Get.find<GlobalController>().saveMessagesSession(MessageEntity(
            content: receivedData.substring(43),
            receiverId: receivedData.substring(15, 28),
            senderId: receivedData.substring(2, 15),
            timeStamp: receivedData.substring(28, 42),
          ));
          print("ALGUEM QUER CONTATO????");
          print(receivedData.substring(42));
          print(receivedData.substring(15, 28));
          print(receivedData.substring(2, 15));
          print(receivedData.substring(28, 42));
        }
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
    if (_isConnected && _socket != null) {
      print("Enviando mensagem: $message");
      _socket.write(message);
    } else {
      print("Socket não está conectado. Não é possível enviar a mensagem.");
    }
  }

  Future<void> sendTextMessage(
    String receiverId,
    String content,
  ) async {
    if (!_isConnected) {
      print("Aguardando conexão...");
      await _connectToServer(); // Tenta reconectar
    }
    var time = DateTime.now().toUtc().millisecondsSinceEpoch / 1000;
    final userId = await Get.find<GlobalController>().getUserId();

    MessageEntity message = MessageEntity(
      senderId: userId,
      receiverId: receiverId,
      content: content,
      timeStamp: time.toString().substring(1, 10), // ou um timestamp específico
    );

    String sendMessageToServer =
        "05${message.senderId}${message.receiverId}${message.timeStamp}${message.content}";

    print("AQUI É DENTRO DO ENVIO DE MENSAGEM!!!!!");
    print(sendMessageToServer);

    _socket.write(sendMessageToServer);
  }

  @override
  void onClose() {
    _socket.destroy();
    super.onClose();
  }

  // TcpController saveId() {

  // }
}
