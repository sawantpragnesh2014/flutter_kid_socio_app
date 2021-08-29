import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_kid_socio_app/blocs/auth_bloc.dart';
import 'package:flutter_kid_socio_app/blocs/bloc_provider.dart';
import 'package:flutter_kid_socio_app/blocs/login_bloc.dart';
import 'package:flutter_kid_socio_app/services/api_response.dart';
import 'package:flutter_kid_socio_app/shared/action_button.dart';
import 'package:flutter_kid_socio_app/shared/app_bar.dart';
import 'package:flutter_kid_socio_app/shared/app_bar_new.dart';
import 'package:flutter_kid_socio_app/shared/form_validators.dart';
import 'package:flutter_kid_socio_app/shared/loading.dart';
import 'package:flutter_kid_socio_app/shared/styles.dart';
import 'package:flutter_kid_socio_app/ui/login/add_profile_pic.dart';

import '../home/home.dart';

class OtpScreenNew extends StatefulWidget {
  @override
  _OtpScreenNewState createState() => _OtpScreenNewState();
}

class _OtpScreenNewState extends State<OtpScreenNew> {
  LoginBloc _loginBloc;
  AuthBloc _authBloc;
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
                  style: TextStyles.blackTextBoldSmall
              ),
              SizedBox(height: 20.0,),
              Text(
                  "Please enter the verification code sent to +91*******918 ",
                  style: TextStyles.blackTextRegular
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
        decoration: TextStyles.textInputDecoration.copyWith(),
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
  void didChangeDependencies() {
        super.didChangeDependencies();
    _loginBloc = CustomBlocProvider.getBloc<LoginBloc>();
    _authBloc = CustomBlocProvider.getBloc<AuthBloc>();
  }

  @override
  void dispose() {
    super.dispose();
    _loginBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBarNew(height: 120.0,),
      body: StreamBuilder<ApiResponse<String>>(
        stream: _loginBloc.parentStream,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            switch(snapshot.data.status){
              case Status.LOADING:
                return Loading();
                break;
              case Status.COMPLETED:
                Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) => Home()));
                break;
              case Status.ERROR:
                break;
            }
          }
          return _otpScreen;
        }
      ),
    );
  }
}
