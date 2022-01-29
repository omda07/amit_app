import 'package:amit_app/shared/resources/color_manager.dart';
import 'package:amit_app/shared/resources/fonts_manager.dart';
import 'package:amit_app/shared/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

var defualtColor = ColorManager.swatch;
ThemeData lightTheme = ThemeData(
  backgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    actionsIconTheme: IconThemeData(
      color: defualtColor,
    ),
    iconTheme: IconThemeData(color: defualtColor),
    // backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    backgroundColor: Colors.white,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      fontFamily: FontConstants.fontFamily,
      color: Colors.black,
      fontSize: FontSize.s20,
      fontWeight: FontWeight.bold,
    ),
  ),
  scaffoldBackgroundColor: Colors.white,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defualtColor,
    elevation: AppSize.s18,
    backgroundColor: Colors.white,
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      fontSize: FontSize.s16,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    subtitle1: TextStyle(
      fontSize: FontSize.s14,
      fontWeight: FontWeight.w600,
      color: Colors.black,
      height: 1.3,
    ),
  ),
  iconTheme: IconThemeData(color: defualtColor),
  fontFamily: FontConstants.fontFamily,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s16),
      ),
      padding: EdgeInsets.zero,
    ),
  ),
  primarySwatch: Colors.deepOrange,
);
