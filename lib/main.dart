import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snowa/di/app_module.dart';
import 'package:snowa/screens/home/home_page.dart';

import 'screens/home/home_logic.dart';

void main() {
  providesDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage()
    );
  }
}