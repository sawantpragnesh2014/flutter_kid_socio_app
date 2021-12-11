import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_kid_socio_app/services/api_response.dart';
import 'package:flutter_kid_socio_app/services/auth.dart';

import 'bloc.dart';
import 'bloc_provider.dart';

class PhoneVerificationBloc extends Bloc{

  late StreamController<ApiResponse<void>> phoneVerificationController;

  void result;

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
      result = await verifyPhoneNumber('+91$phoneNo');
    } catch(e){
      phoneVerificationSink.add(ApiResponse.error(e.toString()));
    }
  }

  Future<void> verifyPhoneNumber(String phoneNumber) async {
    return await _auth.auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 60),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  PhoneCodeSent codeSent = (String verificationId, [int? forceResendingToken]) async {
    print('Please check your phone for the verification code.');
    Auth.verificationId1 = verificationId;
    CustomBlocProvider.getBloc<PhoneVerificationBloc>()!.phoneVerificationSink.add(ApiResponse.completed(CustomBlocProvider.getBloc<PhoneVerificationBloc>()!.result));
  };

  PhoneVerificationFailed verificationFailed =
      (FirebaseAuthException authException) {
    print('Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}');
    CustomBlocProvider.getBloc<PhoneVerificationBloc>()!.phoneVerificationSink.add(ApiResponse.error('Phone number verification failed. Code: ${authException.code}'));
  };

  PhoneVerificationCompleted verificationCompleted =
      (PhoneAuthCredential phoneAuthCredential) async {
    /*await _auth.signInWithCredential(phoneAuthCredential);*/
    print("Phone number automatically verified and user signed in:");
    CustomBlocProvider.getBloc<PhoneVerificationBloc>()!.phoneVerificationSink.add(ApiResponse.completed(CustomBlocProvider.getBloc<PhoneVerificationBloc>()!.result));
  };

  PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout = (String verificationId) {
    print("verification code: " + verificationId);
    Auth.verificationId1 = verificationId;
  };
}