import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whats_2/aplication_binding.dart';
import 'package:whats_2/core/routes/app_pages.dart';
import 'package:whats_2/core/routes/app_routes.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: AplicationBinding(),
      getPages: AppPages.routes,
      initialRoute: AppRoutes.splash,
      theme: ThemeData(
        useMaterial3: true,
      ),
    );
  }
}
