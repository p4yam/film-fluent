import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';


class AppThemes {

  static final ThemeData lightTheme = ThemeData(
      primaryColor: AppColor.Green,
      primarySwatch: Colors.green,
      brightness: Brightness.light,
      backgroundColor: AppColor.BG,
      scaffoldBackgroundColor: AppColor.BG,
      inputDecorationTheme: InputDecorationTheme(
        border: InputBorder.none
      ),
      textTheme: GoogleFonts.ralewayTextTheme(),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColor.White,
      elevation: 25,
      showSelectedLabels: true,
      showUnselectedLabels: false,
      selectedIconTheme: IconThemeData(color: AppColor.Green),
      selectedItemColor: AppColor.Green,
      unselectedIconTheme: IconThemeData(color: AppColor.GrayLight)
    ),
    dividerTheme:DividerThemeData(
      color: AppColor.Gray
    ),
    appBarTheme: AppBarTheme(
      color: AppColor.BG,
      elevation: 2
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColor.Green,
      foregroundColor: AppColor.White
    )
  );
}
