import 'package:flutter/material.dart';

import 'colors.dart';

class AppStyles {

  static const String opn_sans = 'OpenSans';
  static const String m_plus_rounded = 'MPlusRounded';
  static const String quicksand = 'Quicksand';

  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight semibold = FontWeight.w600;

  static const FontWeight semi_semi_bold = FontWeight.w700;
  static const FontWeight bold = FontWeight.w800;
  static const FontWeight medium = FontWeight.w500;

  static const redText = TextStyle(
      color: AppColors.coloref4138,
      fontFamily: opn_sans,
      fontWeight: regular,
      fontSize: 30.0
  );

  static const redTextSmall = TextStyle(
      color: AppColors.colorEB4C57,
      fontFamily: m_plus_rounded,
      fontWeight: medium,
      fontSize: 14.0
  );

  static const errorText = TextStyle(
      color: AppColors.colorEB4C57,
      fontFamily: m_plus_rounded,
      fontWeight: regular,
      fontSize: 14.0
  );

  static const redTextBoldLarge = TextStyle(
      color: AppColors.colorEB4C57,
      fontFamily: m_plus_rounded,
      fontWeight: bold,
      fontSize: 24.0
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
      fontFamily: m_plus_rounded,
      fontWeight: regular,
      color: AppColors.color888E9A);

  static const genderTextStyle = TextStyle(
      fontSize: 14.0,
      fontFamily: m_plus_rounded,
      fontWeight: regular,
      color: AppColors.color888E9A);

  static const greyRegularSmall = TextStyle(
      fontSize: 14.0,
      fontFamily: m_plus_rounded,
      fontWeight: regular,
      color: AppColors.color888E9A);

  static const greyBold16 = TextStyle(
      fontSize: 16.0,
      fontFamily: m_plus_rounded,
      fontWeight: bold,
      color: AppColors.color888E9A);

  static const genderTextStyleSelected = TextStyle(
      fontSize: 14.0,
      fontFamily: m_plus_rounded,
      fontWeight: regular,
      color: Colors.white);

  static const interestSelected = TextStyle(
      fontSize: 14.0,
      fontFamily: opn_sans,
      fontWeight: regular,
      color: Colors.white);

  static const hyperlinkStyle = TextStyle(
      fontSize: 14.0,
      fontFamily: m_plus_rounded,
      fontWeight: medium,
      color: AppColors.color7059E1);

  static const purpleTextBold16 = TextStyle(
      fontSize: 16.0,
      fontFamily: m_plus_rounded,
      fontWeight: bold,
      color: AppColors.color7059E1);

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

  static const getPadding = EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 20.0);

  /*static const textInputDecoration = InputDecoration(
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
  );*/

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



  //NEW UI

  static const whiteTextBold16 = TextStyle(
    color: Colors.white,
    fontFamily: m_plus_rounded,
    fontWeight: bold,
    fontSize: 16.0,
  );

  static const whiteTextBold40 = TextStyle(
    color: Colors.white,
    fontFamily: m_plus_rounded,
    fontWeight: bold,
    fontSize: 40.0,
  );

  static const whiteTextMedium14 = TextStyle(
    color: Colors.white,
    fontFamily: m_plus_rounded,
    fontWeight: medium,
    fontSize: 14.0,
  );

  static const blackTextMedium14 = TextStyle(
    color: AppColors.color424242,
    fontFamily: m_plus_rounded,
    fontWeight: medium,
    fontSize: 14.0,
  );

  static const blackTextMedium36 = TextStyle(
    color: AppColors.color424242,
    fontFamily: m_plus_rounded,
    fontWeight: medium,
    fontSize: 36.0,
  );

  static const blackTextMedium11 = TextStyle(
    color: AppColors.color424242,
    fontFamily: m_plus_rounded,
    fontWeight: medium,
    fontSize: 11.0,
  );

  static const blackTextRegular16 = TextStyle(
    color: AppColors.color424242,
    fontFamily: m_plus_rounded,
    fontWeight: regular,
    fontSize: 16.0,
  );

  static const blackTextRegular14 = TextStyle(
    color: AppColors.color424242,
    fontFamily: m_plus_rounded,
    fontWeight: regular,
    fontSize: 14.0,
  );

  static const blackTextSemiSemiBold36 = TextStyle(
    color: AppColors.color424242,
    fontFamily: quicksand,
    fontWeight: semi_semi_bold,
    fontSize: 36.0,
  );

  static const blackTextBold24 = TextStyle(
    color: AppColors.color424242,
    fontFamily: m_plus_rounded,
    fontWeight: bold,
    fontSize: 24.0,
  );

  static const blackTextBold16 = TextStyle(
    color: AppColors.color424242,
    fontFamily: m_plus_rounded,
    fontWeight: bold,
    fontSize: 16.0,
  );

  static const blackTextBold18 = TextStyle(
    color: AppColors.color424242,
    fontFamily: m_plus_rounded,
    fontWeight: bold,
    fontSize: 18.0,
  );

  static const blueTextBold16 = TextStyle(
    color: AppColors.color2AC98A,
    fontFamily: m_plus_rounded,
    fontWeight: bold,
    fontSize: 16.0,
  );

  static const redTextBold18 = TextStyle(
    color: AppColors.colorEB4C57,
    fontFamily: m_plus_rounded,
    fontWeight: bold,
    fontSize: 18.0,
  );

  static const redTextBold16 = TextStyle(
    color: AppColors.colorEB4C57,
    fontFamily: m_plus_rounded,
    fontWeight: bold,
    fontSize: 16.0,
  );

  static const greenTextBold16 = TextStyle(
    color: AppColors.color4CAF50,
    fontFamily: m_plus_rounded,
    fontWeight: bold,
    fontSize: 16.0,
  );

  static elevatedActionButtonPurple(String text) => ElevatedButton(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32), // <-- Radius
      ),
      primary: AppColors.color7059E1,
    ),
    onPressed: () {},
    child: Text(
      text,
      style: whiteTextBold16,
    ),
  );

  static ButtonStyle stylePurpleButton = ElevatedButton.styleFrom(
  shape: RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(32), // <-- Radius
  ),
  primary: AppColors.color7059E1,
  );

  static ButtonStyle stylePinkButton = ElevatedButton.styleFrom(
  shape: RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(32), // <-- Radius
  ),
  primary: AppColors.colorEB4C57,
  );

  static const textInputDecoration = InputDecoration(
    fillColor: AppColors.colorE5E5E5,
    filled: true,
    hintStyle: editTextStyle,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.colorE5E5E5),
      borderRadius: BorderRadius.all(Radius.circular(32)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.colorE5E5E5),
      borderRadius: BorderRadius.all(Radius.circular(32)),
    ),
  );


}