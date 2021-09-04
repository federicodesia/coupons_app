import 'package:flutter/material.dart';

const double cPadding = 16.0;

// Bottom Navigation Bar
double cBottomNavigationBarCurve = 24.0;
double cBottomNavigationBarOptionSize = 78.0;
Color cBottomNavigationBarOptionColor = Color(0xFFD3D3E8);

// Floating Action Button
double cFloatingActionButtonHeight = (cBottomNavigationBarOptionSize - (cBottomNavigationBarCurve / 2)) + (cBottomNavigationBarOptionSize / 2);

Color cTextColor = Color(0xFF303030);
Color cLightColor = cTextColor.withOpacity(0.48);

// Text
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

TextStyle cHeaderTextStyle = TextStyle(
  fontSize: 18.0,
  fontFamily: "Poppins",
  color: cTextColor,
  fontWeight: FontWeight.w400
);

// Cards
BorderRadius cCardBorderRadius = BorderRadius.circular(18.0);
Color cDarkCardTextColor = Colors.white;
Color cLightCardTextColor = Color(0xFF30286A);

// Coupons
const double cCouponPadding = 24.0;
const double cCouponTopSizeFactor = 0.48;