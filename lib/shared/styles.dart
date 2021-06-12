import 'package:flutter/material.dart';

const redText = TextStyle(
    color: Color(0xFFef4138),
    fontSize: 30.0
);

const blackText = TextStyle(
    color: Color(0xFF676767),
    fontSize: 30.0
);

const blackTextSmall = TextStyle(
    color: Color(0xFF676767),
    fontSize: 15.0
);

const kTitleStyle = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
    color: Colors.black);

const kSubTitleStyle = TextStyle(
    fontSize: 15.0,
    color: Colors.black);

const textInputDecoration = InputDecoration(
  fillColor: Color(0xFFf3f3f3),
  filled: true,
  enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white)
  ),
  focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white)
  ),
);