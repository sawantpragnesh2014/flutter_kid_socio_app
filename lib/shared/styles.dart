import 'package:flutter/material.dart';

import 'colors.dart';

class TextStyles {

  static const String opn_sans = 'OpenSans';

  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight semibold = FontWeight.w600;

  static const redText = TextStyle(
      color: AppColors.coloref4138,
      fontFamily: opn_sans,
      fontWeight: regular,
      fontSize: 30.0
  );

  static const redTextSmall = TextStyle(
      color: AppColors.coloref4138,
      fontFamily: opn_sans,
      fontWeight: regular,
      fontSize: 14.0
  );

  static const blackText = TextStyle(
    color: AppColors.color676767,
    fontFamily: opn_sans,
    fontWeight: semibold,
    fontSize: 30.0,
  );

  static const blackTextSmall = TextStyle(
      color: AppColors.color676767,
      fontFamily: opn_sans,
      fontWeight: light,
      fontSize: 15.0,
  );

  static const paragraphText = TextStyle(
      color: AppColors.color676767,
      fontFamily: opn_sans,
      fontWeight: light,
      fontSize: 15.0,
    wordSpacing: 8.0,
  );

  static const kTitleStyle = TextStyle(
      fontSize: 20.0,
      fontFamily: opn_sans,
      fontWeight: semibold,
      color: AppColors.color676767);

  static const kSubTitleStyle = TextStyle(
      fontSize: 15.0,
      fontFamily: opn_sans,
      fontWeight: regular,
      color: AppColors.color676767);

  static const editTextStyle = TextStyle(
      fontSize: 16.0,
      fontFamily: opn_sans,
      fontWeight: regular,
      color: AppColors.color676767);

  static const genderTextStyle = TextStyle(
      fontSize: 14.0,
      fontFamily: opn_sans,
      fontWeight: regular,
      color: AppColors.color676767);

  static const hyperlinkStyle = TextStyle(
      fontSize: 14.0,
      fontFamily: opn_sans,
      fontWeight: regular,
      color: AppColors.color16499f);

  static const facebookTextStyle = TextStyle(
      fontSize: 20.0,
      fontFamily: opn_sans,
      fontWeight: semibold,
      color: Colors.white);

  static const googleTextStyle = TextStyle(
      fontSize: 20.0,
      fontFamily: opn_sans,
      fontWeight: semibold,
      color: AppColors.color676767);

  static const textInputDecoration = InputDecoration(
    fillColor: AppColors.colorf3f3f3,
    filled: true,
    hintStyle: editTextStyle,
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.colore6e6e6),
        borderRadius: BorderRadius.all(Radius.circular(16)),
    ),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.colore6e6e6),
        borderRadius: BorderRadius.all(Radius.circular(16)),
    ),
  );

  static ElevatedButtonStyle(String text) => ElevatedButton(
    style: ElevatedButton.styleFrom(
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // <-- Radius
      ),
      primary: AppColors.coloref4138,
    ),
    onPressed: () {},
    child: Text(
      text,
      style: TextStyle(color: Colors.white,fontSize: 20.0,fontFamily: opn_sans,fontWeight: regular),
    ),
  );

}