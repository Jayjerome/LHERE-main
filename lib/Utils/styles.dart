import 'package:flutter/material.dart';

class TextStyles {
  static final TextStyles _instance = TextStyles._internal();

  factory TextStyles() {
    return _instance;
  }
  TextStyles._internal();

  TextStyle get actionText =>
      const TextStyle(fontSize: 17, color: Color(0xffC70C4A));

  TextStyle get body => const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      );
  TextStyle get bodyBold => const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      );

  TextStyle get categoryText => const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      );

  TextStyle get subtitle1 => TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      height: 1.25,
      color: Colors.black.withOpacity(0.65));
  TextStyle get subtitle1Light => TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      height: 1.25,
      color: Colors.white.withOpacity(0.65));

  TextStyle get bodyLight =>
      TextStyle(fontSize: 16, color: Colors.white.withOpacity(0.9));
  TextStyle get bodyLightBold => const TextStyle(
      fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold);
  TextStyle get subtitle2Light => TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Colors.white.withOpacity(0.5));
  TextStyle get subtitle2 => TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Colors.black.withOpacity(0.65));
  TextStyle get tileSubtitle => TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: Colors.black.withOpacity(0.9));
  TextStyle get title => const TextStyle(
      fontSize: 22, fontWeight: FontWeight.w600, color: Color(0xff464040));
  TextStyle get titleLight => const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      );
  TextStyle get largeText => const TextStyle(
      fontSize: 40, fontWeight: FontWeight.w900, color: Color(0xff464040));
  TextStyle get headerText => const TextStyle(
      fontSize: 30, fontWeight: FontWeight.bold, color: Color(0xff464040));
  TextStyle get tileTitle => const TextStyle(
      fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black);
  TextStyle get unSelectedTabText => TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.black.withOpacity(0.65));
  TextStyle get selectedTabText => const TextStyle(
      fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xffC70C4A));
  TextStyle get unSelectedNavText => TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.bold,
      color: Colors.black.withOpacity(0.75));
  TextStyle get selectedNavText => const TextStyle(
      fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xffC70C4A));

  TextStyle get smallBody => const TextStyle(
      fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black);
}
