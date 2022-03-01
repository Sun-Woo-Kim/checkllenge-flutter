import 'package:flutter/material.dart';

class ColorTheme {
  static const Color gray900 = Color(0xff333333);
  static const Color gray800 = Color(0xff666666);
  static const Color gray700 = Color(0xff999999);
  static const Color gray600 = Color(0xffBABABA);
  static const Color gray500 = Color(0xffCCCCCC);
  static const Color gray400 = Color(0xffDDDDDD);
  static const Color gray300 = Color(0xffEEEEEE);
  static const Color gray200 = Color(0xffFAFAFA);

  static const Color white = Color(0xff333333);

  static const Color error = Color(0xffED1D1D);
  static const Color green = Color(0xff12E54D);

  static const Color point100 = Color(0xffFFE5DB);
  static const Color point200 = Color(0xffFFD4C3);
  static const Color point300 = Color(0xffFA9A76);
  static const Color point400 = Color(0xffF28860);
  static const Color point500 = Color(0xffEA7244);

  static const Color sub100 = Color(0xffE9FFF7);
  static const Color sub200 = Color(0xff9FF1D4);
  static const Color sub300 = Color(0xff52DCAA);
  static const Color sub400 = Color(0xff28927F);
  static const Color sub500 = Color(0xff1B6457);

  static const MaterialColor point = MaterialColor(
    _pointPrimaryValue,
    <int, Color>{
      100: const Color(0xffFFE5DB),
      200: const Color(0xffFFD4C3),
      300: const Color(0xffFA9A76),
      400: const Color(_pointPrimaryValue),
      500: const Color(0xffEA7244),
    },
  );
  static const int _pointPrimaryValue = 0xffF28860;
}
