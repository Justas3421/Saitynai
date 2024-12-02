import 'package:flutter/material.dart';

enum LandingPageColors {
  cardColor(Color(0xff2D2D2D)),
  accentColor(Color(0xff313550));

  const LandingPageColors(this.color);
  final Color color;
}

enum ColorSeed {
  primaryDark('darkViolet', Color(0xFF6559A8)),
  secondaryDark('', Color(0xff59a8a2)),
  tertiaryDark('', Color(0xffa759a8)),

  primaryLight('lightGreen', Color(0xff57cc99)),
  secondaryLight('Swamp', Color(0xff38a3a5)),
  tertiaryLight('PastelGreen', Color(0xffc7f9cc)),

  success('Green', Color(0xff04a24c)),
  error('Red', Color(0xffe21c3d)),
  info('DarkBlue', Color(0xff1c4494)),
  warning('Yellow', Color(0xfffcdc0c)),

  lightBackground('White Background', Color(0xffffffff)),
  darkBackground('White Background', Color(0xff2D2D2D)),
  lightPrimaryText('Black', Color(0xff101213)),
  darkPrimaryText('White', Color(0xffffffff)),
  lightSecondaryText('Grey', Color(0xff57636c)),
  darkSecondaryText('LightGrey', Color(0xffD3D3D3)),
  alternate('GreyBlue', Color(0xff22577a));

  const ColorSeed(this.label, this.color);
  final String label;
  final Color color;

  static Color backgroundColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? ColorSeed.darkBackground.color
          : ColorSeed.lightBackground.color;

  static Color primaryText(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? ColorSeed.darkPrimaryText.color
          : ColorSeed.lightPrimaryText.color;

  static Color secondaryText(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? ColorSeed.darkSecondaryText.color
          : ColorSeed.lightSecondaryText.color;

  static Color getReversedForegroundColor(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return isDarkMode
        ? ColorSeed.lightPrimaryText.color
        : ColorSeed.darkPrimaryText.color;
  }
}
