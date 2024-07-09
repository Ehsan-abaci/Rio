import 'dart:ui';

class ColorManager {
  // Tint colors
  static Color white = HexColor.fromHexColor('#FFFFFF');
  static Color primary = HexColor.fromHexColor('#5200FF');
  static Color primaryDark = HexColor.fromHexColor('#310099');
  static Color primaryLight = HexColor.fromHexColor('#FF904C');
  static Color primaryExtraLight = HexColor.fromHexColor('#CBB2FF');

  static Color success = HexColor.fromHexColor('#5AD363');
  static Color successDark = HexColor.fromHexColor('#36C941');
  static Color successLight = HexColor.fromHexColor('#87E08D');

  static Color warning = HexColor.fromHexColor('#F5CF3F');
  static Color warningDark = HexColor.fromHexColor('#BFA131');
  static Color warningLight = HexColor.fromHexColor('#FFE47D');

  static Color danger = HexColor.fromHexColor('#F90000');
  static Color dangerDark = HexColor.fromHexColor('#BF0000');
  static Color dangerLight = HexColor.fromHexColor('#FF4C4C');

// Background colors
  static Color appBg = HexColor.fromHexColor('#F5F5F5');
  static Color overlay = HexColor.fromHexColor('#000000').withOpacity(.8);
  static Color inputBg = HexColor.fromHexColor('#DADADA').withOpacity(.8);
  static Color surface = HexColor.fromHexColor('#FFFFFF');
  static Color surfaceTertiary = HexColor.fromHexColor('#000000').withOpacity(.06);
  static Color surfaceTertiaryReverse = HexColor.fromHexColor('#FFFFFF').withOpacity(0.6);
  static Color surfacePrimary = HexColor.fromHexColor('#EEE5FF');
  static Color surfacePrimaryBlur = HexColor.fromHexColor('#5200FF').withOpacity(.07);
  static Color surfaceSuccess = HexColor.fromHexColor('#F0FFF1');
  static Color surfaceWarning = HexColor.fromHexColor('#FFFBED');
  static Color surfaceDanger = HexColor.fromHexColor('#FFE5E5');
  static Color walletBg = HexColor.fromHexColor('#FFCEC3');
  static Color lemonYellow = HexColor.fromHexColor('#FCE778');
// Foreground colors

  static Color highEmphasis = HexColor.fromHexColor('#000000').withOpacity(.87);
  static Color mediumEmphasis = HexColor.fromHexColor('#000000').withOpacity(.6);
  static Color lowEmphasis = HexColor.fromHexColor('000000').withOpacity(.38);
  static Color reversedEmphasis = HexColor.fromHexColor('FFFFFF');
  static Color placeholder = HexColor.fromHexColor('#8C8C8C');
  static Color border = HexColor.fromHexColor('DBDBDB');
  static Color red = HexColor.fromHexColor('FA0000');
  static Color green = HexColor.fromHexColor('5AD362');
}

extension HexColor on Color {
  static Color fromHexColor(String hexColor) {
    hexColor = hexColor.replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    return Color(int.parse(hexColor, radix: 16));
  }
}
