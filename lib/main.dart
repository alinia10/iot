import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:snowa/di/app_module.dart';
import 'package:snowa/main_page.dart';
import 'package:snowa/network/rest/rest_client.dart';

import 'device/logic.dart';
import 'device/view.dart';
import 'home/view.dart';
import 'package:dio/dio.dart';

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
        home: DevicePage(),
        routes: {
          '/home': (context) => HomePage(),
          '/device': (context) => DevicePage(),
        },
    );
  }
}
