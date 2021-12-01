import 'package:flutter/material.dart';
import 'package:readingbook/constants/colors.dart';

class TextStyles {
  TextStyles._();

  static var pageHeading = TextStyle(fontWeight: FontWeight.w500, color: ColorConstant.white, fontSize: 24.0);
  static var pageSubHeading = TextStyle(
    fontWeight: FontWeight.w500,
    color: ColorConstant.white,
    letterSpacing: 2,
    fontSize: 21.0,
  );
  static var pageSubHeading1 = TextStyle(fontWeight: FontWeight.w500, color: ColorConstant.white, fontSize: 21.0);
  static var h1Heading = TextStyle(fontWeight: FontWeight.bold, color: ColorConstant.white, fontSize: 18.0);
  static var h1SubHeading = TextStyle(fontWeight: FontWeight.normal, color: ColorConstant.white, fontSize: 18.0);
  static var actionTitle = TextStyle(fontWeight: FontWeight.w600, color: ColorConstant.white, fontSize: 18.0);
  static var actionTitleWhite = TextStyle(fontWeight: FontWeight.w500, color: Colors.white, fontSize: 18.0);
  static var actionTitleBlack = TextStyle(fontWeight: FontWeight.w500, color: Colors.grey, fontSize: 18.0);
  static var actionTitleBlack1 = TextStyle(fontWeight: FontWeight.w600, color: ColorConstant.white, fontSize: 16.0);
  static var paragraphBold = TextStyle(fontWeight: FontWeight.bold, color: ColorConstant.white, fontSize: 14.0);
  static var paragraphdemibold = TextStyle(fontWeight: FontWeight.w600, color: Colors.grey, fontSize: 13.0);
  static var paragraphdemibold1 = TextStyle(fontWeight: FontWeight.w500, color: Colors.white, fontSize: 15.0);
  static var paragraphdemibold2 = TextStyle(fontWeight: FontWeight.w500, color: Colors.grey, fontSize: 15.0);
  static var subText = TextStyle(fontWeight: FontWeight.normal, color: Colors.grey, fontSize: 13.0);
  static var subTextRed = TextStyle(fontWeight: FontWeight.normal, color: Colors.red, fontSize: 13.0);
  static var highlighterOne = TextStyle(fontWeight: FontWeight.normal, color: Colors.grey, fontSize: 14.0);
  static var highlighterTwo = TextStyle(fontWeight: FontWeight.normal, color: ColorConstant.white, fontSize: 15.0);
}
