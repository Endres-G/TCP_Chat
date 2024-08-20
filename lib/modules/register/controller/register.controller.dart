import 'package:get/get.dart';
import 'package:whats_2/core/routes/app_routes.dart';
import 'package:whats_2/data/controller/tcp_controller.dart';
import 'package:whats_2/global_controller.dart';

class RegisterController extends GetxController {
  final TcpController controller = Get.put(TcpController());

  createUser() async {
    print("DENTRO DE CRIARRRRRR");
    final userId = await Get.find<GlobalController>().getUserSession();
    if (userId?.id != null) {
      controller
          .sendMessage("03${userId?.id}"); //loga o user depois de registrado

      print("USUARIO JA EXISTEE");
      // Navega para a rota se userId não for nulo
      Get.toNamed(AppRoutes.home); // ta logado entao entra
    } else {
      print("USUARIO NAAAAAAAAAAAAOOOOO");
      // Se userId for nulo, então loga e depois entra na home
      controller.sendMessage("01"); // cria o user

      Get.toNamed(AppRoutes.home);
    }
  }
}
