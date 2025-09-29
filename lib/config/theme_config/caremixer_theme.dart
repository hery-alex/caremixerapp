import 'package:flutter/material.dart';

class CaremixerTheme {

   static ThemeData primaryThemeData = themeData(primaryColorScheme,primaryTextTheme);


   static ColorScheme primaryColorScheme =  ColorScheme(
      primary: Color(0xffffd8cf),
      onPrimary: Color(0xff6b1300),
      secondary: Color(0xff84cc8f), 
      onSecondary:Color(0xfff05226), 
      error: Color(0xffbd3b27), 
      onError:  Color(0xffc1e0c7),
      surface:Color(0xffe2f7e6) , 
      onSurface: Color(0xff345136),
      brightness: Brightness.light
    );

    
   static TextTheme primaryTextTheme = const TextTheme(
     displayLarge :TextStyle(
      fontSize: 40
     ),
     displayMedium :TextStyle(
      fontSize: 38
     ),
     displaySmall :TextStyle(
      fontSize: 36
     ),
     headlineLarge: TextStyle(
      fontSize: 34
     ),
     headlineMedium:TextStyle(
      fontSize: 32
     ),
     headlineSmall: TextStyle(
      fontSize: 30
     ),
     titleLarge: TextStyle(
      fontSize: 28
     ),
    titleMedium: TextStyle(
      fontSize: 26
     ),
     titleSmall: TextStyle(
      fontSize: 24
     ),
     labelLarge: TextStyle(
      fontSize: 22
     ),
     labelMedium: TextStyle(
      fontSize: 20
     ),
     labelSmall: TextStyle(
      fontSize: 18
     ),
     bodyLarge: TextStyle(
      fontSize: 16,
     ),
     bodyMedium: TextStyle(
      fontSize: 14,
     ),
     bodySmall: TextStyle(
      fontSize: 12,
     ),
   ); 

   static ThemeData themeData(ColorScheme colorScheme,TextTheme textTheme) {
    return ThemeData(
      colorScheme: colorScheme,
      textTheme: textTheme
    );
  }
}