import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';

const PrimaryColor = Color(0xFF0DB34C);

class Template {
  static final headerStyle =
      TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold);

  static final backButtonStyle = ElevatedButton.styleFrom(
      shadowColor: Colors.black54,
      primary: Colors.black26, //
      onPrimary: Colors.white);

  static final primaryButtonStyle = ElevatedButton.styleFrom(
    primary: HexColor.fromHex("0DB34C"), //
    onPrimary: Colors.white, // foreground
  );

  static final subButtonStyle = ElevatedButton.styleFrom(
    primary: Colors.black26, //
    onPrimary: Colors.white, // foreground
  );




  //------------------------------------------------------Color
  static Color primaryColor = HexColor.fromHex("0DB34C"); // Màu chính của ứng dụng
  static Color backgroundColor = HexColor.fromHex("F3F3F3"); // Màu nền

  static Color errorColor = Colors.red;
  static Color disableColor = Colors.black26;
  static Color subColor = Colors.black54; // Màu chữ phụ

  //------------------------------------------------------Content
  final Color subTextColor = Colors.black54; // Màu chữ phụ
  final Color priceColor = Colors.redAccent; // Màu giá sản phẩm

  //------------------------------------------------------Snack Bar
  static void snackError(String messsage) {
    snackSuccessDuration(messsage, 3, errorColor);
  }

  static void snackSuccess(String messsage) {
    snackSuccessDuration(messsage, 3, primaryColor);
  }

  static void snackSuccessDuration(
      String messsage, int durationSecond, Color bgColor) {
    Get.snackbar("Thông báo", messsage,
        backgroundColor: bgColor,
        colorText: Colors.white,
        margin: EdgeInsets.only(top: 0, left: 0, right: 0),
        barBlur: 0.5,
        borderRadius: 0,
        animationDuration: Duration(seconds: 0),
        snackStyle: SnackStyle.FLOATING,
        duration: Duration(seconds: durationSecond));
  }
}

extension HexColor on Color {
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
