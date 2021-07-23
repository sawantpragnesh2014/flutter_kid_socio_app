import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_kid_socio_app/blocs/auth_bloc.dart';
import 'package:flutter_kid_socio_app/blocs/bloc_provider.dart';
import 'package:flutter_kid_socio_app/models/user.dart';
import 'package:flutter_kid_socio_app/shared/colors.dart';
import 'package:flutter_kid_socio_app/shared/form_validators.dart';
import 'package:flutter_kid_socio_app/shared/gender_view.dart';
import 'package:flutter_kid_socio_app/shared/size_config.dart';
import 'package:flutter_kid_socio_app/shared/styles.dart';
import 'package:flutter_kid_socio_app/ui/bottom_nav.dart';
import 'package:flutter_kid_socio_app/ui/otp_screen.dart';
import 'package:flutter_kid_socio_app/ui/privacy_policy.dart';

class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final formKey = GlobalKey<FormState>();
  String firstName;
  String lastName;
  String email;
  String gender;
  // print(list['age']); //32


  bool _agree = true;
  Parent user;

    Widget get _lastName {
    return TextFormField(
      initialValue: (user?.name?.split(' ')?.length > 1)?user?.name?.split(' ')[1]:'',
      decoration: TextStyles.textInputDecoration.copyWith(hintText: 'Last Name'),
      validator: (val) => FormValidators.validateName(val),
      onChanged: (val){
        setState(() {
          lastName = val;
        });
      },
    );
  }

  Widget get _firstName {
    return TextFormField(
      initialValue: user?.name?.split(' ')?.length > 0?user?.name?.split(' ')[0]:'',
      decoration: TextStyles.textInputDecoration.copyWith(hintText: 'First Name'),
      validator: (val) => FormValidators.validateName(val),
      onChanged: (val){
        setState(() {
          firstName = val;
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
          email = val;
        });
      },
    );
  }

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
          /*cardNumber = val;*/
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
                ),
                RichText(
                    text: TextSpan(
                        children: [
                          TextSpan(text: 'By continuing you agree to our ',style: TextStyles.genderTextStyle),
                          TextSpan(
                              text: '\nT & C',
                              style: TextStyles.hyperlinkStyle,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  print('Terms of Service');
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) => Policy()));
                                }),
                          TextSpan(text: ' and ',style: TextStyles.genderTextStyle),
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

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    user = CustomBlocProvider.getBloc<AuthBloc>().getUser;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.fromLTRB(20.0, 60.0, 20.0, 0.0),
        child: Form(
          key: formKey,
          child: Container(
            height: SizeConfig.blockSizeVertical*80,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
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
                          backgroundImage: NetworkImage(user?.photoUrl + '?width=400&height400'),
                          radius: 40.0,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20.0,),
                  _firstName,
                  SizedBox(height: 20.0,),
                  _lastName,
                  SizedBox(height: 20.0,),
                  _email,
                  SizedBox(height: 20.0,),
                  GenderView(callback: (value){
                      print('gender is $value');
                      return gender = value;
                  },),
                  SizedBox(height: 20.0,),
                  _phoneNumber,
                  SizedBox(height: 20.0,),
                  _buildAgreeToTermsField,
                ],
              ),
            ),
          ),
        ),
      ),
      bottomSheet: BottomNav(textName: 'Continue',bgColor: AppColors.color16499f,onNavHit: (){
        if(formKey.currentState.validate()) {
          print('Reg hit');
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => OTPScreen()));
        }
      },),
    );
  }

  String _validateTerms(bool agree) {
    return agree?null:"You must agree before proceeding";
  }


}
