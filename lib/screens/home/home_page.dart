import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:snowa/screens/home/home_logic.dart';

import '../../model/device.dart';
import '../../utils/utils.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  final logic = Get.put(HomeLogic());

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title: Obx(() {
        switch (logic.status.value) {
          case MqttConnectionState.connected:
            return MyString.connected;
          case MqttConnectionState.connecting:
            return MyString.connecting;
          case MqttConnectionState.disconnected:
            return MyString.disconnected;
          case MqttConnectionState.disconnecting:
            return MyString.disconnecting;
          case MqttConnectionState.faulted:
            return MyString.faulted;
        }
      }),
    ), body: LoaderOverlay(
      child: Center(
        child: Obx(() {
          switch (logic.status.value) {
            case MqttConnectionState.connected:
              if (logic.loading.value) {
                context.loaderOverlay.show();
              } else {
                context.loaderOverlay.hide();
              }
              List<Widget> devices = logic.devices
                  .map((e) => Switch(
                      value: e.state.value == DeviceStatus.ON,
                      onChanged: (value) {
                        logic.setDeviceStatus(
                            e, value ? DeviceStatus.ON : DeviceStatus.OFF);
                      }).paddingSymmetric(vertical: 10))
                  .toList();

              return Column(children: devices);
            case MqttConnectionState.connecting:
              return const CircularProgressIndicator();
            case MqttConnectionState.disconnected:
              return Column(
                children: [
                  const Text('Connection Failed').paddingSymmetric(vertical: 20),
                  ElevatedButton(
                    onPressed: () {
                      logic.tryConnect();
                    },
                    child: const Text('Try again'),
                  )
                ],
              );
            default:
              return const SizedBox();
          }
        }),
      ),
    ));
  }
}
