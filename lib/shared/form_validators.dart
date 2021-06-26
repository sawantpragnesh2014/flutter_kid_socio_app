import 'package:flutter/material.dart';

class FormValidators{

  static String validateEmail(String email) {
    RegExp regex = RegExp(r'\w+@\w+\.\w+'); // translates to word@word.word
    if (email.isEmpty)
      return 'We need an email address';
    else if (!regex.hasMatch(email))
      return "That doesn't look like an email address";
    else
      return null;
  }

  static String validateName(String name) {
    RegExp regex = new RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$");
    if (name.isEmpty)
      return 'Enter a name';
    else if (!regex.hasMatch(name))
      return "Enter a valid name";
    else
      return null;
  }

  static String validateMobile(String name) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10}$)';
    RegExp regExp = new RegExp(pattern);

    if (name.isEmpty)
      return 'Enter a name';
    else if (!regExp.hasMatch(name))
      return "Enter a valid name";
    else
      return null;
  }

}