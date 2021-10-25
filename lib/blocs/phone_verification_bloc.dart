import 'dart:async';

import 'package:flutter_kid_socio_app/services/api_response.dart';
import 'package:flutter_kid_socio_app/services/auth.dart';

import 'bloc.dart';

class PhoneVerificationBloc extends Bloc{

  late StreamController<ApiResponse<void>> phoneVerificationController;

  Stream<ApiResponse<void>> get phoneVerificationStream => phoneVerificationController.stream;
  StreamSink<ApiResponse<void>> get phoneVerificationSink => phoneVerificationController.sink;
  
  late Auth _auth;
  
  PhoneVerificationBloc(){
    _auth = Auth();
    phoneVerificationController = StreamController<ApiResponse<void>>.broadcast();
  }
  
  @override
  void dispose() {
    phoneVerificationController.close();
  }

  verifyPhoneNo(String phoneNo) async {
    print('verifying phone no');
    phoneVerificationSink.add(ApiResponse.loading(''));
    try {
       void result = await _auth.verifyPhoneNumber('+91$phoneNo');
       phoneVerificationSink.add(ApiResponse.completed(result));
    } catch(e){
      phoneVerificationSink.add(ApiResponse.error(e.toString()));
    }
  }
}