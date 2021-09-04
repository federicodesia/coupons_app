import 'package:flutter/material.dart';

class SizeHelper {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double defaultSize;
  static late Orientation orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
  }
}

// Get the proportionate height as per screen size
double getHeight(double inputHeight) {
  double screenHeight = SizeHelper.screenHeight;
  return (inputHeight / 797.71) * screenHeight;
}

// Get the proportionate height as per screen size
double getWidth(double inputWidth) {
  double screenWidth = SizeHelper.screenWidth;
  return (inputWidth / 411.42) * screenWidth;
}