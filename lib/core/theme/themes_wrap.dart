import 'package:flutter/material.dart';

class Spacing {
  static const double zero = 0;
  static const double tiny = 2;
  static const double small = 4;
  static const double small1 = 8;
  static const double small2 = 12;
  static const double small3 = 16;
  static const double normal = 20;
  static const double medium = 24;
  static const double medium1 = 28;
  static const double medium2 = 32;
  static const double medium3 = 36;
  static const double big = 40;
  static const double big1 = 44;
  static const double big2 = 48;
  static const double big3 = 52;
  static const double huge = 56;
  static const double huge1 = 60;
  static const double huge2 = 64;
  static const double huge3 = 68;
  static const double huge4 = 72;
  static const double huge5 = 76;
  static const double huge6 = 80;
}

class Sizes {
  static const double borderRadius = 16;
  static const EdgeInsets pagePadding = EdgeInsets.only(right: 16, left: 16, top: 24, bottom: 16);
  static const double fieldSpacing = 12;
}

class FontSize {
  static const double tiny = 12;
  static const double normal = 14;
  static const double small = 16;
  static const double small1 = 18;
  static const double small2 = 20;
  static const double small3 = 22;
  static const double medium = 24;
  static const double medium1 = 26;
  static const double medium2 = 28;
  static const double medium3 = 30;
  static const double big = 32;
  static const double big1 = 34;
  static const double big2 = 36;
  static const double big3 = 38;
  static const double huge = 40;
  static const double huge1 = 42;
  static const double huge2 = 44;
  static const double huge3 = 46;
  static const double huge4 = 48;
  static const double huge5 = 50;
  static const double huge6 = 52;
}

class CustomColors {
  static const MaterialColor blue = MaterialColor(
    0xFF447BAE,
    <int, Color>{
      50: Color.fromRGBO(68, 123, 174, .1),
      100: Color.fromRGBO(68, 123, 174, .2),
      200: Color.fromRGBO(68, 123, 174, .3),
      300: Color.fromRGBO(68, 123, 174, .4),
      400: Color.fromRGBO(68, 123, 174, .5),
      500: Color.fromRGBO(68, 123, 174, .6),
      600: Color.fromRGBO(68, 123, 174, .7),
      700: Color.fromRGBO(68, 123, 174, .8),
      800: Color.fromRGBO(68, 123, 174, .9),
      900: Color.fromRGBO(68, 123, 174, 1),
    },
  );

  static const MaterialColor black = MaterialColor(
    0xFF161616,
    <int, Color>{
      50: Color.fromRGBO(22, 22, 22, .1),
      100: Color.fromRGBO(22, 22, 22, .2),
      200: Color.fromRGBO(22, 22, 22, .3),
      300: Color.fromRGBO(22, 22, 22, .4),
      400: Color.fromRGBO(22, 22, 22, .5),
      500: Color.fromRGBO(22, 22, 22, .6),
      600: Color.fromRGBO(22, 22, 22, .7),
      700: Color.fromRGBO(22, 22, 22, .8),
      800: Color.fromRGBO(22, 22, 22, .9),
      900: Color.fromRGBO(22, 22, 22, 1),
    },
  );

  static const MaterialColor grey = MaterialColor(
    0xFFBEBEBE,
    <int, Color>{
      10: Color.fromRGBO(190, 190, 190, .01),
      25: Color.fromRGBO(190, 190, 190, .05),
      50: Color.fromRGBO(190, 190, 190, .1),
      100: Color.fromRGBO(190, 190, 190, .2),
      200: Color.fromRGBO(190, 190, 190, .3),
      300: Color.fromRGBO(190, 190, 190, .4),
      400: Color.fromRGBO(190, 190, 190, .5),
      500: Color.fromRGBO(190, 190, 190, .6),
      600: Color.fromRGBO(190, 190, 190, .7),
      700: Color.fromRGBO(190, 190, 190, .8),
      800: Color.fromRGBO(190, 190, 190, .9),
      900: Color.fromRGBO(190, 190, 190, 1),
    },
  );
}
