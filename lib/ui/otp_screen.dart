import 'package:flutter/material.dart';
import 'package:otp_screen/otp_screen.dart';

class OTPScreen extends StatefulWidget {
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {

  // logic to validate otp return [null] when success else error [String]
  Future<String> validateOtp(String otp) async {
    await Future.delayed(Duration(milliseconds: 2000));
    if (otp == "1234") {
      return null;
    } else {
      return "The entered Otp is wrong";
    }
  }

  // action to be performed after OTP validation is success
  void moveToNextScreen(context) {
  /*  Navigator.push(context, MaterialPageRoute(
        builder: (context) => SuccessfulOtpScreen()));*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OtpScreen(
        otpLength: 4,
        validateOtp: validateOtp,
        routeCallback: moveToNextScreen,
        titleColor: Colors.black,
        themeColor: Colors.black,
      ),
    );
  }
}
