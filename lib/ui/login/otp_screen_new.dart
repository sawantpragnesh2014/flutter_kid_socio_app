import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_kid_socio_app/shared/action_button.dart';
import 'package:flutter_kid_socio_app/shared/app_bar_new.dart';
import 'package:flutter_kid_socio_app/shared/form_validators.dart';
import 'package:flutter_kid_socio_app/shared/styles.dart';
import 'package:flutter_kid_socio_app/ui/login/add_profile_pic.dart';

class OtpScreenNew extends StatefulWidget {
  @override
  _OtpScreenNewState createState() => _OtpScreenNewState();
}

class _OtpScreenNewState extends State<OtpScreenNew> {
  int _firstDigit;
  int _secondDigit;
  int _thirdDigit;
  int _fourthDigit;

  Widget get _otpScreen{
    return Padding(
      padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
      child: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                  "OTP Verification ",
                  style: AppStyles.blackTextBold16
              ),
              SizedBox(height: 20.0,),
              Text(
                  "Please enter the verification code sent to +91*******918 ",
                  style: AppStyles.blackTextRegular16
              ),
              SizedBox(height: 20.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(flex:1,child: otp(0)),
                  Expanded(flex:1,child: otp(1)),
                  Expanded(flex:1,child: otp(2)),
                  Expanded(flex:1,child: otp(3)),
                ],
              ),
              SizedBox(height: 30.0,),
              ActionButtonView(btnName: "Continue",onBtnHit: (){
                print('Action btn hit $_firstDigit$_secondDigit$_thirdDigit$_fourthDigit');
                Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) => AddProfilePic()));
                /*_loginBloc.createParent(_authBloc.getUser);*/
              },),
            ],
          ),
        ),
      ),
    );
  }

  Widget otp(int pos) {
    return Container(
      margin: EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
      child: TextFormField(
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        autofocus: true,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
        ],
        decoration: AppStyles.textInputDecoration.copyWith(),
        validator: (val) => FormValidators.validateMobile(val),
        onChanged: (val) {
          print('Value on key hit $val ${val.isEmpty}');
          if(val.isEmpty) {
            FocusScope.of(context).previousFocus();
            actionClear(pos);
          }else{
            FocusScope.of(context).nextFocus();
            actionEnter(pos,int.parse(val));
          }
        },
      ),
    );
  }

  void actionClear(int pos){
    switch(pos){
      case 0:
        _firstDigit = null;
        break;
      case 1:
        _secondDigit = null;
        break;
      case 2:
        _thirdDigit = null;
        break;
      case 3:
        _fourthDigit = null;
        break;
    }
  }

  void actionEnter(int pos,int currentDigit){
    switch(pos){
      case 0:
        _firstDigit = currentDigit;
        break;
      case 1:
        _secondDigit = currentDigit;
        break;
      case 2:
        _thirdDigit = currentDigit;
        break;
      case 3:
        _fourthDigit = currentDigit;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBarNew(height: 120.0,),
      body: _otpScreen
    );
  }
}
