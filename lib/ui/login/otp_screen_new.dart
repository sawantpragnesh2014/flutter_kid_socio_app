import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_kid_socio_app/blocs/bloc_provider.dart';
import 'package:flutter_kid_socio_app/blocs/login_bloc.dart';
import 'package:flutter_kid_socio_app/blocs/otp_verification_bloc.dart';
import 'package:flutter_kid_socio_app/services/api_response.dart';
import 'package:flutter_kid_socio_app/shared/action_button.dart';
import 'package:flutter_kid_socio_app/shared/app_bar_new.dart';
import 'package:flutter_kid_socio_app/shared/error_page.dart';
import 'package:flutter_kid_socio_app/shared/form_validators.dart';
import 'package:flutter_kid_socio_app/shared/loading.dart';
import 'package:flutter_kid_socio_app/shared/styles.dart';
import 'package:flutter_kid_socio_app/ui/login/add_profile_pic.dart';
import 'package:flutter_kid_socio_app/ui/login/phone_verification.dart';

class OtpScreenNew extends StatefulWidget {
  @override
  _OtpScreenNewState createState() => _OtpScreenNewState();
}

class _OtpScreenNewState extends State<OtpScreenNew> {
  int? _firstDigit;
  int? _secondDigit;
  int? _thirdDigit;
  int? _fourthDigit;
  int? _fifthDigit;
  int? _sixthDigit;
  late OtpVerificationBloc _otpVerificationBloc;

  String? _otp;

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
                  "Please enter the verification code sent to +91*******${CustomBlocProvider.getBloc<LoginBloc>()!.phoneNo.substring(CustomBlocProvider.getBloc<LoginBloc>()!.phoneNo.length - 3)} ",
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
                  Expanded(flex:1,child: otp(4)),
                  Expanded(flex:1,child: otp(5)),
                ],
              ),
              SizedBox(height: 30.0,),
              ActionButtonView(btnName: "Continue",onBtnHit: (){
                print('Action btn hit $_firstDigit$_secondDigit$_thirdDigit$_fourthDigit$_fifthDigit$_sixthDigit');
                if(_validateOtp) {
                /*Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) => AddProfilePic()));*/
                  _otpVerificationBloc.verifyOtp(_otp!);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Enter correct otp.'),
                    ),
                  );
                  print('Wrong otp');
                }
                /*_loginBloc.createParent(_authBloc.getUser);*/
              },),
            ],
          ),
        ),
      ),
    );
  }

  bool get _validateOtp {
     if(_firstDigit != null && _secondDigit != null && _thirdDigit != null && _fourthDigit != null && _fifthDigit != null && _sixthDigit != null){
       _otp = '$_firstDigit$_secondDigit$_thirdDigit$_fourthDigit$_fifthDigit$_sixthDigit';
       return true;
     }
     return false;
  }

  Widget otp(int pos) {
    return Container(
      margin: EdgeInsets.fromLTRB(6.0, 0.0, 6.0, 0.0),
      child: TextFormField(
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        autofocus: true,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
        ],
        decoration: AppStyles.textInputDecoration.copyWith(),
        validator: (val) => FormValidators.validateMobile(val!),
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
      case 4:
        _fifthDigit = null;
        break;
      case 5:
        _sixthDigit = null;
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
      case 4:
        _fifthDigit = currentDigit;
        break;
      case 5:
        _sixthDigit = currentDigit;
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    CustomBlocProvider.setBloc(OtpVerificationBloc());
    _otpVerificationBloc = CustomBlocProvider.getBloc<OtpVerificationBloc>()!;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBarNew(height: 120.0,),
      body: StreamBuilder<ApiResponse<void>>(
          stream: _otpVerificationBloc.otpVerificationStream,
          builder: (context, snapshot) {
            if(snapshot.hasData){
              switch(snapshot.data!.status) {
                case Status.LOADING:
                  return Loading();

                case Status.COMPLETED:
                  Future.delayed(Duration.zero, () {
                    Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) => AddProfilePic()));
                  });
                  break;

                case Status.ERROR:
                default:
                  return ErrorPage(
                    errorMessage: snapshot.data!.message ?? 'Some error occured',
                    onRetryPressed: () => callPhoneVerificationScreen(),
                  );
              }
            }
            return _otpScreen;
          }
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _otpVerificationBloc.dispose();
  }

  callPhoneVerificationScreen() {
    Future.delayed(Duration.zero, () {
      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => PhoneVerification()));
    });
  }
}
