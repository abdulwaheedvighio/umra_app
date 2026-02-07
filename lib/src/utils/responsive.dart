import 'package:flutter/material.dart';

class Responsive {
  // Screen width & height
  static double width(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double height(BuildContext context) =>
      MediaQuery.of(context).size.height;

  // Device type checks
  static bool isMobile(BuildContext context) =>
      width(context) < 600;

  static bool isTablet(BuildContext context) =>
      width(context) >= 600 && width(context) < 1024;

  static bool isDesktop(BuildContext context) =>
      width(context) >= 1024;

  // Responsive width & height (percentage based)
  static double wp(BuildContext context, double percent) =>
      width(context) * percent / 100;

  static double hp(BuildContext context, double percent) =>
      height(context) * percent / 100;

  // Responsive text size
  static double sp(BuildContext context, double size) {
    double baseWidth = 375; // iPhone X base
    return size * (width(context) / baseWidth);
  }

  // Responsive padding
  static EdgeInsets padding(BuildContext context) {
    return EdgeInsets.symmetric(
      horizontal: wp(context, 4),
      vertical: hp(context, 2),
    );
  }
  static bool isLandscape(BuildContext context) =>
      MediaQuery.of(context).orientation == Orientation.landscape;
}
