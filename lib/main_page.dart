// widget main page scaffold
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Main Page')),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.devices),
              label: 'Device',
            ),
          ],
          onTap: (index) {
            switch (index) {
              case 0:
                Get.toNamed('/home');
                break;
              case 1:
                Get.toNamed('/device');
                break;
            }
          },
        ));
  }
}
