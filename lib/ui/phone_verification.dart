import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_kid_socio_app/blocs/auth_bloc.dart';
import 'package:flutter_kid_socio_app/blocs/bloc_provider.dart';
import 'package:flutter_kid_socio_app/blocs/login_bloc.dart';
import 'package:flutter_kid_socio_app/models/parent.dart';
import 'package:flutter_kid_socio_app/shared/app_bar.dart';
import 'package:flutter_kid_socio_app/shared/form_validators.dart';
import 'package:flutter_kid_socio_app/shared/size_config.dart';
import 'package:flutter_kid_socio_app/shared/styles.dart';
import 'package:flutter_kid_socio_app/ui/otp_screen.dart';

class PhoneVerification extends StatefulWidget {
  @override
  _PhoneVerificationState createState() => _PhoneVerificationState();
}

class _PhoneVerificationState extends State<PhoneVerification> {
  final formKey = GlobalKey<FormState>();
  Parent user;

  LoginBloc _loginBloc;
  AuthBloc _authBloc;

  Widget get _phoneNumber {
    return TextFormField(
      initialValue: user?.phoneNo,
      keyboardType: TextInputType.number,
      inputFormatters: [
        LengthLimitingTextInputFormatter(10),
      ],
      decoration: TextStyles.textInputDecoration.copyWith(hintText: 'Phone No.',prefixIcon: Padding(padding: EdgeInsets.all(15), child: Text('+91 ',style: TextStyles.editTextStyle,)),),
      validator: (val) => FormValidators.validateMobile(val),
      onChanged: (val){
        setState(() {
          _loginBloc.phoneNo = val;
        });
      },
    );
  }

  Widget get _actionButton {
      return Padding(
        padding: EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 0.0),
        child: SizedBox(
          height: 60.0,
          width: double.infinity,
          child: ElevatedButton(
            style: TextStyles.stylePurpleButton,
            onPressed: () {
              if(formKey.currentState.validate()) {
                print('Reg hit');
                Parent parent = _loginBloc.createParentByFormFields(user.uid);
                print('Parent created is $parent');
                _authBloc.setUser(parent);
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => OTPScreen()));
              }
            },
            child: Text(
              'Continue',
              style: TextStyles.whiteTextBold,
            ),
          ),
        ),
      );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('didChangeDependencies');
    _loginBloc = CustomBlocProvider.getBloc<LoginBloc>();
    _authBloc = CustomBlocProvider.getBloc<AuthBloc>();
    user = _authBloc.getUser;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBarView(height: 120.0,),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
        child: Form(
          key: formKey,
          child: Container(
            height: SizeConfig.blockSizeVertical*80,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                      "Phone Number Verification ",
                      style: TextStyles.blackTextBoldSmall
                  ),
                  SizedBox(height: 20.0,),
                  Text(
                      "Please confirm your phone number ",
                      style: TextStyles.blackTextRegular
                  ),
                  SizedBox(height: 20.0,),
                  _phoneNumber,
                  SizedBox(height: 20.0,),
                  _actionButton,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
