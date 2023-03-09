import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';



import 'package:get/get.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:snowa/device/topic_creator.dart';
import 'package:snowa/mqtt/mqtt_controller.dart';

import '../../model/device.dart';

class HomeLogic extends MqttLogic {
  static const LED = "LED";
  final devices = [
    Device(LED, "0", DeviceStatus.OFF.obs),
    Device(LED, "1", DeviceStatus.OFF.obs),
    Device(LED, "2", DeviceStatus.OFF.obs),
    Device(LED, "3", DeviceStatus.OFF.obs),
  ];

  //TODO: get current status

  @override
  void onInit() {
    super.onInit();
  }

  void _publishDeviceStatus(Device device, DeviceStatus deviceStatus) {
    final copyDevice = device.copyWith(deviceStatus: deviceStatus);
    final message = jsonEncode(copyDevice.toJson());

    final returnValue = publish(getTopic(device.name), MqttQos.exactlyOnce, message);
    print("published '$message' to   return: $returnValue");
    showLoading();
  }

  void setDeviceStatus(Device device, DeviceStatus deviceStatus) {
    _publishDeviceStatus(device, deviceStatus);
  }

  void _subscribe(String deviceName) {
    clientController.subscribe(deviceName, MqttQos.exactlyOnce);
  }

  void startListening() {
    print("LISTENING");
    clientController.client.updates?.listen((event) {
      event.forEach((element) {
        final recMess = element.payload as MqttPublishMessage;
        String message =
            MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
        String decodeMessage = const Utf8Decoder().convert(message.codeUnits);
        print(
            "MQTTClientWrapper::GOT A NEW MESSAGE $decodeMessage on Topic ${element.topic}");
        final deviceName = element.topic.split("/")[1];
        if (deviceName == LED) {
          Map<String, dynamic> deviceMap = jsonDecode(message);
          final device = Device.fromJson(deviceMap, deviceName);
          print("DEVICE: ${device.name} ${device.num} ${device.state.value}");
          devices
              .firstWhere(
                  (element) => device.name == element.name && device.num == element.num)
              .state
              .value = device.state.value;
          hideLoading();
        }
      });
    });
  }

  @override
  void reload() {
    super.reload();
    print("RELOAD  ${clientController.client.connectionStatus?.state}");
    if (clientController.client.connectionStatus?.state == MqttConnectionState.connected) {
      print("CONNECTED");
      _subscribe(LED);
      startListening();
    }
  }


}



