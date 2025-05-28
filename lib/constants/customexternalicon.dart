import 'package:flutter/material.dart';
import 'package:user_appointment/constants/colors.dart';
import 'package:user_appointment/constants/styles.dart';

Widget defaultTitle(String title, String seeTitle) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(title, style: kTitleStyle),
      TextButton(
        child: Text(
          seeTitle,
          style: const TextStyle(
            color: (MyColors.yellow01),
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () {},
      ),
    ],
  );
}

class MyFlutterApp {
  MyFlutterApp._();

  static const _kFontFam = 'MyFlutterApp';
  static const String? _kFontPkg = null;

  static const IconData chat = IconData(
    0xe800,
    fontFamily: _kFontFam,
    fontPackage: _kFontPkg,
  );
}
