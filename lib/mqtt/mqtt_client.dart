import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:snowa/mqtt/mqtt_controller.dart';

import '../device/topic_creator.dart';

class MqttClientController {
  MqttServerClient client = MqttServerClient('192.168.159.73', 'snowa');
  MqttLogic? logic;

   MqttClientController._(){
      _setupAndConnect();
   }

   static final MqttClientController instance = MqttClientController._();

  _setupAndConnect() async {
    _setCertifications();
    _setOptionsAndCallbacks();
    _setConnectMessage();
    await connect();
    _checkForConnection();
  }

  void tryAgain() {
    connect();
  }

  connect() async {
    try {
      await client.connect();
    } on Exception catch (e) {
      print('EXAMPLE::client exception - $e');
      client.disconnect();
    }
  }

  void subscribe(String deviceName , MqttQos qos) {
    client.subscribe(getTopic(deviceName), qos  );
  }

  /*
  {
      final recMess = messages.first.payload as MqttPublishMessage;
      String message = MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      String decodeMessage = Utf8Decoder().convert(message.codeUnits);

      print(
          "MQTTClientWrapper::GOT A NEW MESSAGE $decodeMessage on Topic ${messages.first.topic}");
    });
   */



  void _setOptionsAndCallbacks() {
    client.logging(on: false);
    client.keepAlivePeriod = 20;
    client.port = 1883;
    client.onDisconnected = _onDisconnected;
    client.onConnected = _onConnected;
    client.onSubscribed = _onSubscribed;
  }

  SubscribeCallback? get _onSubscribed => (String topic) {
        print("Subscribe to $topic");
      };

  DisconnectCallback? get _onDisconnected => () {
        logic?.reload();
        print("Disconnected ${client.connectionStatus?.state}");
      };

  ConnectCallback? get _onConnected => () {
        logic?.reload();
        print("connected ${client.connectionStatus?.state}");

      };

  void _setCertifications() async {
    const certs = "assets/certs/";
    ByteData clientCrt = await rootBundle.load("${certs}client.crt");
    ByteData clientKey = await rootBundle.load('${certs}client.key');
    ByteData mosquitto = await rootBundle.load("${certs}mosquitto.org.crt");
    SecurityContext securityContext = SecurityContext.defaultContext;
    securityContext.setClientAuthoritiesBytes(mosquitto.buffer.asUint8List());
    securityContext.useCertificateChainBytes(clientCrt.buffer.asUint8List());
    securityContext.usePrivateKeyBytes(clientKey.buffer.asUint8List());

    client.securityContext = securityContext;
  }

  void _checkForConnection() {
    if (client.connectionStatus?.state == MqttConnectionState.connected) {
      print('EXAMPLE::Mosquitto client connected');
    } else {
      print('EXAMPLE::ERROR Mosquitto client connection failed - '
          'disconnecting, status is ${client.connectionStatus}');
      client.disconnect();
    }
  }

  void _setConnectMessage() {
    final connMessage = MqttConnectMessage()
        .withClientIdentifier('snowa')
        .withWillTopic('willtopic')
        .withWillMessage('hello mqtt')
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);
    print('EXAMPLE::Mosquitto client connecting....');
    client.connectionMessage = connMessage;
  }
}
