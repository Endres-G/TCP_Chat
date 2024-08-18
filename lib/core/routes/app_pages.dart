import 'package:get/get.dart';
import 'package:whats_2/core/routes/app_routes.dart';
import 'package:whats_2/data/view/tcp_view.dart';
import 'package:whats_2/modules/register/view/register.view.dart';
import 'package:whats_2/modules/test/view/home_view.dart';
import 'package:whats_2/splash_view.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.home,
      page: () => HomeView(),
    ),
    // GetPage(
    //   name: AppRoutes.register,
    //   page: () => RegisterView(),
    // ),
    GetPage(
      name: AppRoutes.splash,
      page: () => SplashView(),
    )
  ];
}
