import 'package:flutter/material.dart';

class FormValidators{
  static final RegExp regexName = RegExp(r"/^[a-z ,.'-]+$/i");
  static final RegExp regexEmail = RegExp(r'\w+@\w+\.\w+'); // translates to word@word.word
  static final RegExp regexNumber = RegExp(r'(^(?:[+0]9)?[0-9]{10}$)');
  static final RegExp regexPinCode = RegExp(r"^[a-z0-9][a-z0-9\- ]{0,10}[a-z0-9]$", caseSensitive: false);

  static String? validateEmail(String? email) {
    if (email!.isEmpty)
      return 'We need an email address';
    else if (!regexEmail.hasMatch(email))
      return "That doesn't look like an email address";
    else
      return null;
  }

  static String? validateName(String name) {
    print('Match for $name is ${regexName.hasMatch(name)}');
    if (name.isEmpty) {
      return 'Enter a name';
    } /*else if (!regexName.hasMatch(name)) {
      return "Enter a valid name";
    }*/ else{
      return null;
    }
  }

  static String? validateMobile(String name) {
    if (name.isEmpty)
      return 'Enter a mobile number';
    else if (!regexNumber.hasMatch(name))
      return "Invalid mobile number";
    else
      return null;
  }

  static String? validatePinCode(String zip) {
    if (zip.isEmpty)
      return 'Enter a pin code';
    else if (!regexPinCode.hasMatch(zip))
      return "Invalid pin code";
    else
      return null;
  }

  static String? validateDob(String name) {
    if (name.isEmpty)
      return 'Enter date of birth';
    else
      return null;
  }

}