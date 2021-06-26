import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_kid_socio_app/models/user.dart';
import 'package:flutter_kid_socio_app/shared/colors.dart';
import 'package:flutter_kid_socio_app/shared/form_validators.dart';
import 'package:flutter_kid_socio_app/shared/size_config.dart';
import 'package:flutter_kid_socio_app/shared/styles.dart';
import 'package:flutter_kid_socio_app/services/user_repository.dart';
import 'package:flutter_kid_socio_app/ui/bottom_nav.dart';

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

  bool _agree = true;
  User user;

  Widget get _lastName {
    return TextFormField(
      initialValue: user?.name,
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
      initialValue: user?.name,
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

  Widget genderButton(String text){
    return Expanded(
      child: Container(
        child: TextButton(
          onPressed: (){
            setState(() {
              gender = text;
            });
          },
          child: Text(text,style: TextStyles.editTextStyle,),
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // <-- Radius
            ),
            backgroundColor: AppColors.colore6e6e6,
          ),
        ),
      ),
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
                          TextSpan(text: 'I agree to the ',style: TextStyles.editTextStyle),
                          TextSpan(
                              text: 'privacy policy',
                              style: TextStyles.hyperlinkStyle,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  print('Terms of Service"');
                                }),
                          TextSpan(text: ' & ',style: TextStyles.editTextStyle),
                          TextSpan(
                              text: '\nterms and conditions',
                              style: TextStyles.hyperlinkStyle,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  print('Terms of Service"');
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
    user = AuthProvider.of(context).auth.getUser;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.0, 60.0, 20.0, 0.0),
          child: Form(
            key: formKey,
            child: Container(
              height: SizeConfig.blockSizeVertical*80,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Text(
                        'Registration',
                        style: TextStyles.redText
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  Text(
                    'Enter your details below',
                    style: TextStyles.kSubTitleStyle
                  ),
                  SizedBox(height: 20.0,),
                  _firstName,
                  SizedBox(height: 20.0,),
                  _lastName,
                  SizedBox(height: 20.0,),
                  _email,
                  SizedBox(height: 20.0,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      genderButton('Male'),
                      SizedBox(width: 20.0,),
                      genderButton('Female')
                    ],
                  ),
                  SizedBox(height: 20.0,),
                  _phoneNumber,
                  SizedBox(height: 20.0,),
                  _buildAgreeToTermsField
                ],
              ),
            ),
          ),
        ),
      ),
      bottomSheet: BottomNav(textName: 'Continue',bgColor: AppColors.color16499f,onNavHit: (){
        if(formKey.currentState.validate()) {
          print('Reg hit');
        }
      },),
    );
  }

  String _validateTerms(bool agree) {
    return agree?null:"You must agree before proceeding";
  }
}
