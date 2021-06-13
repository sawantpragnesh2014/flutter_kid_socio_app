import 'package:flutter/material.dart';
import 'package:flutter_kid_socio_app/shared/colors.dart';
import 'package:flutter_kid_socio_app/shared/styles.dart';
import 'package:flutter_kid_socio_app/ui/bottom_nav.dart';

class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  String firstName;

  String lastName;

  String email;

  Widget genderButton(String text){
    return Expanded(
      child: Container(
        child: TextButton(
          onPressed: (){
            setState(() {
              /*cardNumber = val;*/
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.fromLTRB(20.0, 60.0, 20.0, 0.0),
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
            TextFormField(
              decoration: TextStyles.textInputDecoration.copyWith(hintText: 'First Name'),
              validator: (val) => val.isEmpty?'Enter a valid name':null,
              onChanged: (val){
                setState(() {
                  firstName = val;
                });
              },
            ),
            SizedBox(height: 20.0,),
            TextFormField(
              decoration: TextStyles.textInputDecoration.copyWith(hintText: 'Last Name'),
              validator: (val) => val.isEmpty?'Enter a valid last name':null,
              onChanged: (val){
                setState(() {
                  lastName = val;
                });
              },
            ),
            SizedBox(height: 20.0,),
            TextFormField(
              decoration: TextStyles.textInputDecoration.copyWith(hintText: 'Email'),
              validator: (val) => val.isEmpty?'Enter a valid email':null,
              onChanged: (val){
                setState(() {
                  email = val;
                });
              },
            ),
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
            TextFormField(
              decoration: TextStyles.textInputDecoration.copyWith(hintText: 'Password'),
              validator: (val) => val.isEmpty?'Enter a valid password':null,
              onChanged: (val){
                setState(() {
                  /*cardNumber = val;*/
                });
              },
            ),
          ],
        ),
      ),
      bottomSheet: BottomNav(textName: 'Continue',bgColor: AppColors.color16499f,onNavHit: (){
        print('Reg hit');
      },),
    );
  }
}
