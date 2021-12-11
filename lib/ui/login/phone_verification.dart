import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_kid_socio_app/blocs/auth_bloc.dart';
import 'package:flutter_kid_socio_app/blocs/bloc_provider.dart';
import 'package:flutter_kid_socio_app/blocs/login_bloc.dart';
import 'package:flutter_kid_socio_app/blocs/phone_verification_bloc.dart';
import 'package:flutter_kid_socio_app/services/api_response.dart';
import 'package:flutter_kid_socio_app/shared/action_button.dart';
import 'package:flutter_kid_socio_app/shared/app_bar_new.dart';
import 'package:flutter_kid_socio_app/shared/error_page.dart';
import 'package:flutter_kid_socio_app/shared/form_validators.dart';
import 'package:flutter_kid_socio_app/shared/loading.dart';
import 'package:flutter_kid_socio_app/shared/size_config.dart';
import 'package:flutter_kid_socio_app/shared/styles.dart';
import 'package:flutter_kid_socio_app/ui/login/otp_screen_new.dart';
import 'package:sms_autofill/sms_autofill.dart';

class PhoneVerification extends StatefulWidget {
  @override
  _PhoneVerificationState createState() => _PhoneVerificationState();
}

class _PhoneVerificationState extends State<PhoneVerification> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _phoneNumberController = TextEditingController();
  final SmsAutoFill _autoFill = SmsAutoFill();
  User? user;

  late LoginBloc _loginBloc;
  late AuthBloc _authBloc;
  late PhoneVerificationBloc _phoneVerificationBloc;

  Widget get _phoneNumber {
    return TextFormField(
      /*controller: _phoneNumberController,*/
      initialValue: user?.phoneNumber ?? '',
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

  Widget get _phoneVerificationView {
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
               ActionButtonView(btnName: "Continue",onBtnHit: () async {
                 print('Action btn hit');
                 if(formKey.currentState!.validate()) {
                   _phoneVerificationBloc.verifyPhoneNo(_loginBloc.phoneNo);
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
  void initState() {
    super.initState();
    CustomBlocProvider.setBloc(PhoneVerificationBloc());
    _loginBloc = CustomBlocProvider.getBloc<LoginBloc>()!;
    _authBloc = CustomBlocProvider.getBloc<AuthBloc>()!;
    _phoneVerificationBloc = CustomBlocProvider.getBloc<PhoneVerificationBloc>()!;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('didChangeDependencies');
    user = _authBloc.getUser;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBarNew(height: 120.0,),
      body: StreamBuilder<ApiResponse<void>>(
          stream: _phoneVerificationBloc.phoneVerificationStream,
          builder: (context, snapshot) {
            if(snapshot.hasData){
              switch(snapshot.data!.status) {
                case Status.LOADING:
                  return Loading();

                case Status.COMPLETED:
                Future.delayed(Duration.zero, () {
                  Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) => OtpScreenNew()));
                });
                  break;

                case Status.ERROR:
                default:
                Future.delayed(Duration.zero, ()
                {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(snapshot.data!.message ?? 'Some error occured',style: AppStyles.errorText ,),
                    ),
                  );
                });
              }
            }
            return _phoneVerificationView;
          }
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _phoneVerificationBloc.dispose();
  }
}
