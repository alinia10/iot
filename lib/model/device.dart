import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:json_annotation/json_annotation.dart';
@JsonSerializable()
class Device {
  String name;
  String num;
  Rx<DeviceStatus> state;

  Device(this.name, this.num, this.state);

  static Device fromJson(Map<String, dynamic> json, String deviceName) {
    return Device(deviceName, json['num'], Rx(DeviceStatus.values.firstWhere(
            (element) => element.name == json['state'])));
  }

  Map<String, dynamic> toJson() => {
    "num": num,
    "state": state.value.name,
  };

  copyWith({required DeviceStatus deviceStatus}) {
    return Device(name, num, Rx(deviceStatus));
  }


}

enum DeviceStatus { ON, OFF }