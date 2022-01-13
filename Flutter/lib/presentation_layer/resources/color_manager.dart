import 'package:flutter/material.dart';

class ColorManager {
  static Color primary = HexColor.fromHex('#FFDE59');
  static Color primaryWithOpacity40 =
      HexColor.fromHex('#FFDE59').withOpacity(0.4);
  static Color grey = HexColor.fromHex('#767676');
  static Color greyWithOpacity80 = HexColor.fromHex('#767676').withOpacity(0.8);
  static Color whiteWithOpacity60 =
      HexColor.fromHex('#FFFFFF').withOpacity(0.6);
  static Color red = HexColor.fromHex('#DE2C2C');
  static Color white = HexColor.fromHex('#FFFFFF');
  static Color black = HexColor.fromHex('#000000');
}

extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll('#', '');
    if (hexColorString.length == 6) {
      hexColorString = 'FF' + hexColorString;
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}
