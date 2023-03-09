import 'package:get_it/get_it.dart';
import 'package:snowa/mqtt/mqtt_client.dart';
import 'package:snowa/mqtt/mqtt_controller.dart';


void providesDependencies() {
  GetIt.instance.registerLazySingleton(() => MqttClientController.instance);
}
