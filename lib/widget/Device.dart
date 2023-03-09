import 'package:flutter/material.dart';
import 'package:snowa/model/device.dart';

class DeviceView extends StatelessWidget {
  const DeviceView({Key? key, required this.tittle, required this.icon, required this.status}) : super(key: key);

  final String tittle;
  final IconData icon;
  final DeviceStatus status;

  @override
  Widget build(BuildContext context) {
    return Placeholder();

  }
}
