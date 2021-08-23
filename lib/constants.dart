import 'package:flutter/material.dart';

// Bottom Navigation Bar
double cBottomNavigationBarCurve = 24.0;
double cBottomNavigationBarOptionSize = 78.0;
Color cBottomNavigationBarOptionColor = Color(0xFFD3D3E8);

// Floating Action Button
double cFloatingActionButtonHeight = (cBottomNavigationBarOptionSize - (cBottomNavigationBarCurve / 2)) + (cBottomNavigationBarOptionSize / 2);

Color cTextColor = Color(0xFF303030);
Color cLightColor = cTextColor.withOpacity(0.48);

TextStyle cTabTextStyle = TextStyle(
  fontSize: 18.0,
  fontFamily: "Poppins",
  fontWeight: FontWeight.w500
);

TextStyle cTextStyle = TextStyle(
  fontSize: 12.0,
  fontFamily: "Poppins",
  color: cLightColor,
  fontWeight: FontWeight.w400
);