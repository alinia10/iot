import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:snowa/mqtt/mqtt_client.dart';

import '../screens/home/home_logic.dart';

abstract class MqttLogic extends GetxController {
  MqttClientController clientController = GetIt.instance.get<MqttClientController>();

  final status = MqttConnectionState.disconnected.obs;

  final loading = false.obs;

  @override
  void onInit() {
    clientController.logic = this;
    reload();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    clientController.logic = null;
    super.onClose();
  }

  void reload() {
    status.value = clientController.client.connectionStatus?.state ??
        MqttConnectionState.disconnected;
  }

  void tryConnect() {
    clientController.connect();
  }

  showLoading() {
    loading.value = true;
  }

  hideLoading() {
    loading.value = false;
  }

  int publish(String deviceName, MqttQos qos, String message) {
    final MqttClientPayloadBuilder builder = MqttClientPayloadBuilder();
    builder.addString(message);
    return clientController.client.publishMessage(deviceName, qos, builder.payload!);
  }
}
