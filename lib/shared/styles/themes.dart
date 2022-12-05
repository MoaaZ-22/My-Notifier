
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

ThemeData? darkTheme = ThemeData(
  textTheme: const TextTheme(
      bodyText1: TextStyle(fontSize: 30,fontFamily: 'AsapCondensed-Bold', color: Colors.white)
  ),
  appBarTheme: const AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  ),
  scrollbarTheme: ScrollbarThemeData(
    mainAxisMargin: 4.5.h,
    thumbColor: MaterialStateProperty.all(Colors.black54),
    minThumbLength: 12.h,
    trackBorderColor: MaterialStateProperty.all(Colors.white),
    trackColor: MaterialStateProperty.all(Colors.white),
    trackVisibility: MaterialStateProperty.all(true),
    interactive: true,
    thumbVisibility: MaterialStateProperty.all(true),
    thickness: MaterialStateProperty.all(5),
  ),
);

ThemeData? lightTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  ),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  textTheme: const TextTheme(
      bodyText1: TextStyle(fontSize: 30,fontFamily: 'AsapCondensed-Bold', color: Colors.black),
      bodyText2: TextStyle(fontSize: 12, fontFamily: 'AsapCondensed-Medium')
  ),
  scrollbarTheme: ScrollbarThemeData(
    mainAxisMargin: 4.5.h,
    thumbColor: MaterialStateProperty.all(Colors.black54),
    minThumbLength: 12.h,
    trackBorderColor: MaterialStateProperty.all(Colors.white),
    trackColor: MaterialStateProperty.all(Colors.white),
    trackVisibility: MaterialStateProperty.all(true),
    interactive: true,
    thumbVisibility: MaterialStateProperty.all(true),
    thickness: MaterialStateProperty.all(5),
  ),
);