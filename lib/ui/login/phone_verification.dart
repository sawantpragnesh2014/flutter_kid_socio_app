import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_kid_socio_app/blocs/auth_bloc.dart';
import 'package:flutter_kid_socio_app/blocs/bloc_provider.dart';
import 'package:flutter_kid_socio_app/blocs/login_bloc.dart';
import 'package:flutter_kid_socio_app/models/parent.dart';
import 'package:flutter_kid_socio_app/shared/action_button.dart';
import 'package:flutter_kid_socio_app/shared/app_bar.dart';
import 'package:flutter_kid_socio_app/shared/app_bar_new.dart';
import 'package:flutter_kid_socio_app/shared/form_validators.dart';
import 'package:flutter_kid_socio_app/shared/size_config.dart';
import 'package:flutter_kid_socio_app/shared/styles.dart';
import 'package:flutter_kid_socio_app/ui/login/otp_screen.dart';
import 'package:flutter_kid_socio_app/ui/login/otp_screen_new.dart';

class PhoneVerification extends StatefulWidget {
  @override
  _PhoneVerificationState createState() => _PhoneVerificationState();
}

class _PhoneVerificationState extends State<PhoneVerification> {
  final formKey = GlobalKey<FormState>();
  User? user;

  late LoginBloc _loginBloc;
  late AuthBloc _authBloc;

  Widget get _phoneNumber {
    return TextFormField(
      initialValue: user?.phoneNumber,
      keyboardType: TextInputType.number,
      inputFormatters: [
        LengthLimitingTextInputFormatter(10),
      ],
      decoration: AppStyles.textInputDecoration.copyWith(hintText: 'Phone No.',prefixIcon: Padding(padding: EdgeInsets.all(15), child: Text('+91 ',style: AppStyles.editTextStyle,)),),
      validator: (val) => FormValidators.validateMobile(val!),
      onChanged: (val){
        setState(() {
          _loginBloc.phoneNo = val;
        });
      },
    );
  }

  get _phoneVerificationView {
   return Padding(
     padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
     child: Form(
       key: formKey,
       child: Container(
         child: SingleChildScrollView(
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.stretch,
             children: [
               Text(
                   "Phone Number Verification ",
                   style: AppStyles.blackTextBold16
               ),
               SizedBox(height: 20.0,),
               Text(
                   "Please confirm your phone number ",
                   style: AppStyles.blackTextRegular16
               ),
               SizedBox(height: 20.0,),
               _phoneNumber,
               SizedBox(height: 20.0,),
               ActionButtonView(btnName: "Continue",onBtnHit: (){
                 print('Action btn hit');
                 if(formKey.currentState!.validate()) {
                   Navigator.pushReplacement(context, MaterialPageRoute(
                       builder: (context) => OtpScreenNew()));
                 }
               },),
             ],
           ),
         ),
       ),
     ),
   );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('didChangeDependencies');
    _loginBloc = CustomBlocProvider.getBloc<LoginBloc>()!;
    _authBloc = CustomBlocProvider.getBloc<AuthBloc>()!;
    user = _authBloc.getUser;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBarNew(height: 120.0,),
      body: _phoneVerificationView,
    );
  }
}
