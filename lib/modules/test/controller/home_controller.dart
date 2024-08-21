import 'package:get/get.dart';
import 'package:whats_2/entity/user_entity.dart';
import 'package:whats_2/global_controller.dart';

class HomeController extends GetxController {
  Future<UserEntity?> getUser() async {
    final session = await Get.find<GlobalController>().getUserSession();
    return session;
  }
}
