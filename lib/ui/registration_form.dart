import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_kid_socio_app/blocs/auth_bloc.dart';
import 'package:flutter_kid_socio_app/blocs/bloc_provider.dart';
import 'package:flutter_kid_socio_app/blocs/login_bloc.dart';
import 'package:flutter_kid_socio_app/models/parent.dart';
import 'package:flutter_kid_socio_app/shared/app_bar.dart';
import 'package:flutter_kid_socio_app/shared/colors.dart';
import 'package:flutter_kid_socio_app/shared/form_validators.dart';
import 'package:flutter_kid_socio_app/shared/gender_view.dart';
import 'package:flutter_kid_socio_app/shared/size_config.dart';
import 'package:flutter_kid_socio_app/shared/styles.dart';
import 'package:flutter_kid_socio_app/ui/phone_verification.dart';
import 'package:flutter_kid_socio_app/ui/privacy_policy.dart';

class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final formKey = GlobalKey<FormState>();
  // print(list['age']); //32


  bool _agree = true;
  Parent user;

  LoginBloc _loginBloc;
  AuthBloc _authBloc;

    Widget get _lastName {
    return TextFormField(
      initialValue: user?.lastName,
      decoration: TextStyles.textInputDecoration.copyWith(hintText: 'Last Name'),
      validator: (val) => FormValidators.validateName(val),
      onChanged: (val){
        setState(() {
          _loginBloc.lastName = val;
        });
      },
    );
  }

  Widget get _firstName {
    return TextFormField(
      initialValue: user?.firstName,
      decoration: TextStyles.textInputDecoration.copyWith(hintText: 'First Name'),
      validator: (val) => FormValidators.validateName(val),
      onChanged: (val){
        setState(() {
          _loginBloc.firstName = val;
        });
      },
    );
  }

  Widget get _email {
    return TextFormField(
      initialValue: user?.email,
      decoration: TextStyles.textInputDecoration.copyWith(hintText: 'Email'),
      validator: (val) => FormValidators.validateEmail(val),
      onChanged: (val){
        setState(() {
          _loginBloc.email = val;
        });
      },
    );
  }

  Widget get _pinCode {
    return TextFormField(
      initialValue: user?.phoneNo,
      keyboardType: TextInputType.number,
      inputFormatters: [
        LengthLimitingTextInputFormatter(6),
      ],
      decoration: TextStyles.textInputDecoration.copyWith(hintText: 'Pincode'),
      validator: (val) => FormValidators.validateMobile(val),
      onChanged: (val){
        setState(() {
          _loginBloc.phoneNo = val;
        });
      },
    );
  }

  Widget get _address {
    return TextFormField(
      initialValue: user?.phoneNo,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      decoration: TextStyles.textInputDecoration.copyWith(hintText: 'Address'),
      validator: (val) => FormValidators.validateName(val),
      onChanged: (val){
        setState(() {
          _loginBloc.phoneNo = val;
        });
      },
    );
  }


  Widget get _buildAgreeToTermsField {
    return FormField<bool>(
      initialValue: _agree,
      builder: (FormFieldState<bool> state) {
        return Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Checkbox(
                  value: state.value,
                  onChanged: (bool val) => setState(() {
                    _agree = val;
                    state.didChange(val);
                  }),
                  activeColor: AppColors.color7059E1,
                  checkColor: Colors.white,
                ),
                RichText(
                    text: TextSpan(
                        children: [
                          TextSpan(text: 'By continuing you agree to the ',style: TextStyles.blackTextMedium),
                          TextSpan(
                              text: '\nT & C',
                              style: TextStyles.hyperlinkStyle,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  print('Terms of Service');
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) => Policy()));
                                }),
                          TextSpan(text: ' and ',style: TextStyles.blackTextMedium),
                          TextSpan(
                              text: 'Privacy Policy',
                              style: TextStyles.redTextSmall,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  print('Privacy Policy');
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) => Policy()));
                                }),
                        ]
                    )
                )
              ],
            ),
            state.errorText == null
                ? Text("")
                : Text(state.errorText, style: TextStyle(color: Colors.red)),
          ],
        );
      },
      // 7
      validator: (val) => _validateTerms(_agree),
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
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => PhoneVerification()));
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
    _loginBloc.firstName =  user?.firstName;
    _loginBloc.lastName =  user?.lastName;
    _loginBloc.email =  user?.email;
    _loginBloc.gender =  user?.gender?? 'Male';
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
                  /*Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              'Registration',
                              style: TextStyles.redText
                          ),
                          SizedBox(height: 20.0,),
                          Text(
                              'Parent Info',
                              style: TextStyles.hyperlinkStyle
                          ),
                          SizedBox(height: 5.0,),
                          Text(
                              'Enter your details below',
                              style: TextStyles.kSubTitleStyle
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap:(){
                        },
                        child: CircleAvatar(
                          *//*backgroundImage: NetworkImage(user?.photoUrl + '?width=400&height400'),*//*
                          radius: 40.0,
                        ),
                      )
                    ],
                  ),*/
                  Text(
                      "Parent's Registration",
                      style: TextStyles.blackTextBoldSmall
                  ),
                  SizedBox(height: 20.0,),
                  _firstName,
                  SizedBox(height: 20.0,),
                  _lastName,
                  SizedBox(height: 20.0,),
                  _email,
                  SizedBox(height: 20.0,),
                  _address,
                  SizedBox(height: 20.0,),
                  _pinCode,
                  SizedBox(height: 20.0,),
                  GenderView(callback: (value){
                      print('gender is $value');
                      return _loginBloc.gender = value;
                  },),
                  SizedBox(height: 20.0,),
                  _buildAgreeToTermsField,
                  _actionButton,
                ],
              ),
            ),
          ),
        ),
      ),
      /*bottomSheet: BottomNav(textName: 'Continue',bgColor: AppColors.color16499f,onNavHit: (){
        if(formKey.currentState.validate()) {
          print('Reg hit');
          Parent parent = _loginBloc.createParentByFormFields(user.uid);
          print('Parent created is $parent');
          _authBloc.setUser(parent);
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => OTPScreen()));
        }
      },),*/
    );
  }

  String _validateTerms(bool agree) {
    return agree?null:"You must agree before proceeding";
  }


}
