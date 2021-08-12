import 'package:flutter/cupertino.dart';

class AppColor {
  static const Green = Color(0XFF25BA7C);
  static const GreenDarker = Color(0XFF266354);
  static const GreenDark = Color(0XFF268664);
  static const GreenLight = Color(0XFFB9E9D5);
  static const GreenLighter = Color(0XFFDEF5EB);
  static const GrayDarker = Color(0XFF27293A);
  static const GrayDark = Color(0XFF525461);
  static const Gray = Color(0XFF757681);
  static const GrayLight = Color(0XFFDEDFE1);
  static const GrayLighter = Color(0XFFEEEEEF);
  static const BG = Color(0XFFF5F6F8);
  static const White = Color(0XFFFFFFFF);

  static const GreenAccent = Color(0XFF94D96A);
  static const BlueAccent = Color(0XFF2D8AF1);
  static const BlueLightAccent = Color(0XFF37DAFB);
  static const RedAccent = Color(0XFFFF5079);
  static const OrangeAccent = Color(0XFFFF7454);
  static const OrangeAccentLight = Color(0XFFFF7D4D);
  static const YellowAccent = Color(0XFFFFA132);
  static const PurpleAccent = Color(0XFF7128A0);
  static const PurpleLightAccent = Color(0XFFB436B8);

  static const GreenGradient = LinearGradient(colors: [Green, GreenAccent]);
  static const BlueGradient =
      LinearGradient(colors: [BlueAccent, BlueLightAccent]);
  static const RedGradient = LinearGradient(colors: [RedAccent, OrangeAccent]);
  static const OrangeGradient =
      LinearGradient(colors: [OrangeAccent, OrangeAccentLight]);
  static const PurpleGradient =
      LinearGradient(colors: [PurpleAccent, PurpleLightAccent]);
}
