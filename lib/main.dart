import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whats_2/data/view/tcp_view.dart';
//import 'package:whats_2/modules/test/view/home_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: TcpView(),
    );
  }
}
