import 'package:get/get.dart';
import 'package:whats_2/global_controller.dart';
import 'package:whats_2/modules/register/controller/register.controller.dart';

class AplicationBinding implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put<GlobalController>(GlobalController(), permanent: true);
    Get.put(RegisterController());
  }
}
