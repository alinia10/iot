import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AppLayout{
  static getSize(BuildContext context){
    return MediaQuery.of(context).size;
  }
}
Color primary = const Color(0xFF687daf);

class Styles{
  static TextStyle connectedStyle = const TextStyle(fontSize: 20, color: Colors.green, fontWeight: FontWeight.w500);
  static TextStyle disconnectedStyle = const TextStyle(fontSize: 20, color: Colors.red, fontWeight: FontWeight.w500);
  static TextStyle headLineStyle1 = TextStyle(fontSize: 26, color: Colors.black, fontWeight: FontWeight.bold);
  static TextStyle headLineStyle2 = TextStyle(fontSize: 21, color: Colors.black, fontWeight: FontWeight.w500);
  static TextStyle headLineStyle3 = TextStyle(fontSize: 17, color: Colors.grey.shade500, fontWeight: FontWeight.w500);
  static TextStyle headLineStyle4 = TextStyle(fontSize: 14, color: Colors.grey.shade500, fontWeight: FontWeight.w500);
}

class MyString {
  var connected = Text("Connected", style: Styles.headLineStyle2.copyWith(color: Colors.green),);
  var disconnected= Text("Disconnected", style: Styles.headLineStyle3.copyWith(color: Colors.red),);
}