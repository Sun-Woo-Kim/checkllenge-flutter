import 'package:flutter/material.dart';

class FontTheme {
  static final _fontFamily = "NotoSansCJKkr";

  static final TextStyle h1 = TextStyle(
      fontFamily: _fontFamily, fontWeight: FontWeight.w700, fontSize: 24);

  // ignore: non_constant_identifier_names
  static TextStyle h1_with(Color color) {
    return TextStyle(
        color: color,
        // fontFamily: _fontFamily,
        fontWeight: FontWeight.w700,
        fontSize: 24);
  }

  static final TextStyle h2 = TextStyle(
      fontFamily: _fontFamily, fontWeight: FontWeight.w700, fontSize: 20);
  // ignore: non_constant_identifier_names
  static TextStyle h2_with(Color color) {
    return TextStyle(
        color: color,
        // fontFamily: _fontFamily,
        fontWeight: FontWeight.w700,
        fontSize: 20);
  }

  static final TextStyle h3 = TextStyle(
      fontFamily: _fontFamily, fontWeight: FontWeight.w500, fontSize: 20);
  // ignore: non_constant_identifier_names
  static TextStyle h3_with(Color color) {
    return TextStyle(
        color: color,
        // fontFamily: _fontFamily,
        fontWeight: FontWeight.w500,
        fontSize: 20);
  }

  static final TextStyle h4 = TextStyle(
      fontFamily: _fontFamily, fontWeight: FontWeight.w700, fontSize: 18);
  // ignore: non_constant_identifier_names
  static TextStyle h4_with(Color color) {
    return TextStyle(
        color: color,
        // fontFamily: _fontFamily,
        fontWeight: FontWeight.w700,
        fontSize: 18);
  }

  static final TextStyle h5 = TextStyle(
      fontFamily: _fontFamily, fontWeight: FontWeight.w400, fontSize: 18);
  // ignore: non_constant_identifier_names
  static TextStyle h5_with(Color color) {
    return TextStyle(
        color: color,
        // fontFamily: _fontFamily,
        fontWeight: FontWeight.w400,
        fontSize: 18);
  }

  static final TextStyle h6 = TextStyle(
      fontFamily: _fontFamily, fontWeight: FontWeight.w700, fontSize: 16);
  // ignore: non_constant_identifier_names
  static TextStyle h6_with(Color color) {
    return TextStyle(
        color: color,
        // fontFamily: _fontFamily,
        fontWeight: FontWeight.w700,
        fontSize: 16);
  }

  static final TextStyle p = TextStyle(
      fontFamily: _fontFamily, fontWeight: FontWeight.w400, fontSize: 16);
// ignore: non_constant_identifier_names
  static TextStyle p_with(Color color) {
    return TextStyle(
        color: color,
        // fontFamily: _fontFamily,
        fontWeight: FontWeight.w400,
        fontSize: 16);
  }

  static final TextStyle blockquote1 = TextStyle(
      fontFamily: _fontFamily, fontWeight: FontWeight.w700, fontSize: 14);
// ignore: non_constant_identifier_names
  static TextStyle blockquote1_with(Color color) {
    return TextStyle(
        color: color,
        // fontFamily: _fontFamily,
        fontWeight: FontWeight.w700,
        fontSize: 14);
  }

  static final TextStyle blockquote2 = TextStyle(
      fontFamily: _fontFamily, fontWeight: FontWeight.w400, fontSize: 14);
// ignore: non_constant_identifier_names
  static TextStyle blockquote2_with(Color color) {
    return TextStyle(
        color: color,
        // fontFamily: _fontFamily,
        fontWeight: FontWeight.w400,
        fontSize: 14);
  }

  static final TextStyle blockquote3 = TextStyle(
      fontFamily: _fontFamily, fontWeight: FontWeight.w400, fontSize: 12);
// ignore: non_constant_identifier_names
  static TextStyle blockquote3_with(Color color) {
    return TextStyle(
        color: color,
        // fontFamily: _fontFamily,
        fontWeight: FontWeight.w400,
        fontSize: 12);
  }
}
