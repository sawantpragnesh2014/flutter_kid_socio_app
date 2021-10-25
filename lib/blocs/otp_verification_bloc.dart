import 'dart:async';

import 'package:flutter_kid_socio_app/services/api_response.dart';
import 'package:flutter_kid_socio_app/services/auth.dart';

import 'bloc.dart';

class OtpVerificationBloc extends Bloc{

  late StreamController<ApiResponse<bool>> otpVerificationController;

  Stream<ApiResponse<bool>> get otpVerificationStream => otpVerificationController.stream;
  StreamSink<ApiResponse<bool>> get otpVerificationSink => otpVerificationController.sink;
  
  late Auth _auth;
  
  OtpVerificationBloc(){
    _auth = Auth();
    otpVerificationController = StreamController<ApiResponse<bool>>.broadcast();
  }
  
  @override
  void dispose() {
    otpVerificationController.close();
  }

  verifyOtp(String otp) async {
    print('verifying otp no');
    otpVerificationSink.add(ApiResponse.loading(''));
    try {
       bool result = await _auth.signInWithPhoneNumber(otp);
       otpVerificationSink.add(ApiResponse.completed(result));
    } catch(e){
      otpVerificationSink.add(ApiResponse.error(e.toString()));
      print("Failed to sign in: " + e.toString());
    }
  }
}