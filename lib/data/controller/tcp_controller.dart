import 'dart:convert'; // Para utf8.decode
import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:whats_2/entity/chat_entity.dart';
import 'package:whats_2/entity/message_entity.dart';
import 'package:whats_2/entity/user_entity.dart';
import 'package:whats_2/global_controller.dart';
import 'package:whats_2/modules/conversation/controller/chat_controller.dart';

class TcpController extends GetxController {
  late Socket _socket;
  Rx<List<ChatEntity>> userChats = Rx<List<ChatEntity>>([]);
  late String currentUserId;
  var receivedData = ''.obs; // Observable variable
  final TextEditingController textController = TextEditingController();
  bool _isConnected = false; // Estado de conexão
  bool _idSaved = false; // Estado do ID
  final ChatController chatController = ChatController();

  @override
  void onInit() async {
    super.onInit();
    final a = await Get.find<GlobalController>().getUserSession();
    print(a!.chats);
    userChats.value = a.chats;
    currentUserId = a.id;
    await Future.delayed(Duration(seconds: 2));
    _connectToServer();
    print("LLLLLLLLLLLLLLLL");
  }

  Future<void> _connectToServer() async {
    String connectPaulao = "0.tcp.sa.ngrok.io";
    String connectLocalHost = "192.168.0.106";
    String connectLocalHostEmul = "10.0.2.2";

    try {
      // Conecta ao servidor Python
      _socket = await Socket.connect(connectPaulao, 17546);
      final currentUser = await Get.find<GlobalController>().getUserSession();
      userChats.value = currentUser!.chats;
      currentUserId = currentUser.id;
      print(
          'Connected to: ${_socket.remoteAddress.address}:${_socket.remotePort}');
      _isConnected = true;
      // Ouve por dados do servidor
      _socket.listen(
        (data) async {
          print("+++++++++++++++++++++++++");
          receivedData.value = utf8.decode(data); // retorno do servidor
          print(receivedData);
          // final MessageEntity mensagemRecebida = MessageEntity(
          //   content: receivedData.substring(38),
          //   receiverId: receivedData.substring(15, 28),
          //   senderId: receivedData.substring(2, 15),
          //   timeStamp: receivedData.substring(28, 38),
          // );
          if (!_idSaved && receivedData.startsWith('02')) {
            // Verifica se a mensagem contém o ID
            final id = receivedData.substring(2); // nosso ID
            print("VAI SALVAR NOSSO ID DA SESSÃO!");
            await Get.find<GlobalController>().saveUserSession(UserEntity(
                id: id,
                chats: userChats.value // salva o nosso ID e chat na cache
                ));
            _idSaved = true; // Marca como ID salvo
            sendMessage("03$id"); // Loga o user depois de registrado
          }
          if (receivedData.startsWith('07')) {
            print("qqqqqqqqqqqqqqqqqq");
            print(receivedData);
            // int index = userChats.value.indexWhere((e) =>
            //     e.receiver == mensagemRecebida.receiverId ||
            //     e.receiver == mensagemRecebida.senderId);
            // ChatEntity selectedChat = userChats.value[index];
            // selectedChat.messages!.add(mensagemRecebida);
            // userChats[index] = selectedChat;

            // print("yyy${userChats}");
            // await Get.find<GlobalController>().saveUserSession(UserEntity(
            //   id: currentUserId,
            //   chats: userChats, // salva o nosso ID e chat na cache
            // ));
            // Trata as mensagens de confirmação aqui
            print("Mensagem de confirmação recebida: $receivedData");
          } else if (receivedData.startsWith('06')) {
            //salvando msg recebida
            final MessageEntity mensagemRecebida = MessageEntity(
              content: receivedData.substring(38),
              receiverId: receivedData.substring(15, 28),
              senderId: receivedData.substring(2, 15),
              timeStamp: receivedData.substring(28, 38),
            );
            print("aaaaaaaaaaaaa");
            //pegando a mensagem recebida
            final userInstance =
                await Get.find<GlobalController>().getUserSession();
            print("KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK");
            print(userInstance!.toMap());
            final ChatEntity chatSelected = userInstance!.chats[0];

            print("rrr1${mensagemRecebida}");

            print("rrr2${chatSelected.messages}");

            chatSelected.messages?.add(mensagemRecebida);

            print("rrr3${chatSelected.messages}");

            print("rrr4${userInstance.chats[0].messages?[0]}");

            //salvando a mensagem recebida no userentity
            await Get.find<GlobalController>().saveUserSession(UserEntity(
                id: userInstance.id,
                chats: userInstance.chats // salva o nosso ID e chat na cache
                ));

            print("rrr5${userInstance.chats[0].messages?[0]}");

            print("${receivedData.substring(2)}");

            print("???");
            print(receivedData.substring(0, 2));
            print(receivedData.substring(2, 15));
            print(receivedData.substring(15, 28));
            print(receivedData.substring(28, 37));
            print(receivedData.substring(37));
            print("???");

            /* print(receivedData.substring(37));
            print(receivedData.substring(15, 28));
            print(receivedData.substring(2, 15));
            print(receivedData.substring(28, 37));*/
          }
        },
        onError: (error) {
          print('Error: $error');
          _socket.destroy();
        },
      );
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

  Future<String?> sendTextMessage(
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
    print(userChats);
    int index =
        userChats.value.indexWhere((e) => e.receiver == message.receiverId);
    ChatEntity selectedChat = userChats.value[index];
    selectedChat.messages!.add(message);
    userChats.value[index] = selectedChat;

    print("yyy${userChats.value}");
    await Get.find<GlobalController>().saveUserSession(UserEntity(
      id: currentUserId,
      chats: userChats.value, // salva o nosso ID e chat na cache
    ));
    return userId;
  }

  @override
  void onClose() {
    _socket.destroy();
    super.onClose();
  }

  // TcpController saveId() {

  // }
}
