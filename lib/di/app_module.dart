import 'package:get_it/get_it.dart';
import 'package:snowa/mqtt/mqtt_client.dart';
import 'package:snowa/mqtt/mqtt_controller.dart';
import 'package:snowa/network/rest/rest_client.dart';
import 'package:dio/dio.dart';

void providesDependencies() {
  GetIt.instance.registerLazySingleton(() => MqttClientController.instance);
}
