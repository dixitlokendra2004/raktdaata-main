import 'dart:ui';
import 'package:flutter/material.dart';

class ColorConstant {
  static Color blueGray5002 = fromHex('#e8eef3');

  static Color buttonThemeSecondary = fromHex('#33edbc2c');

  static Color gray600 = fromHex('#828282');

  static Color blueGray200 = fromHex('#b8b8c7');

  static Color blueGray400 = fromHex('#888888');

  static Color gray800 = fromHex('#4f4f4f');

  static Color blueA700 = fromHex('#0066ff');

  static Color gray200 = fromHex('#e9e9e9');

  static Color gray100 = fromHex('#f7f7f7');

  static Color gray3007f = fromHex('#7fdcdddf');

  static Color black90001 = fromHex('#000000');

  static Color black900 = fromHex('#090909');

  static Color gray20001 = fromHex('#e8e8e8');

  static Color deepPurpleA200 = fromHex('#5c41ff');

  static Color whiteA700 = fromHex('#ffffff');

  static Color black90002 = fromHex('#000000');

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
