import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:mqtt_client/mqtt_client.dart';

import '../model/device.dart';
import 'logic.dart';

/*
mqtt/esp32/temp

 */

class DevicePage extends StatelessWidget {
  final logic = Get.put(DeviceLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Device'),
      ),
      body: LoaderOverlay(
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

                return Column(children: [
                  const Text('Connected').paddingSymmetric(vertical: 20),
                  ...devices,
                ]);
              case MqttConnectionState.connecting:
                return const CircularProgressIndicator();
              case MqttConnectionState.disconnected:
                return Column(
                  children: [
                    const Text('Disconnected').paddingSymmetric(vertical: 20),
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
      ),
    );
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(left: 7), child: Text("Loading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
