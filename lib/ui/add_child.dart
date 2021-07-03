import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kid_socio_app/blocs/auth_bloc.dart';
import 'package:flutter_kid_socio_app/blocs/bloc_provider.dart';
import 'package:flutter_kid_socio_app/blocs/login_bloc.dart';
import 'package:flutter_kid_socio_app/models/user.dart';
import 'package:flutter_kid_socio_app/shared/app_bar.dart';
import 'package:flutter_kid_socio_app/shared/colors.dart';
import 'package:flutter_kid_socio_app/shared/form_validators.dart';
import 'package:flutter_kid_socio_app/shared/gender_view.dart';
import 'package:flutter_kid_socio_app/shared/size_config.dart';
import 'package:flutter_kid_socio_app/shared/styles.dart';
import 'package:flutter_kid_socio_app/ui/bottom_nav.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AddChild extends StatefulWidget {
  @override
  _AddChildState createState() => _AddChildState();

}

class _AddChildState extends State<AddChild> {
  User user;
  final formKey = GlobalKey<FormState>();
  String firstName;
  String lastName;
  String email;
  String gender;
  // print(list['age']); //32

  Widget get _firstName {
    return TextFormField(
      decoration: TextStyles.textInputDecoration.copyWith(hintText: 'First Name'),
      validator: (val) => FormValidators.validateName(val),
      onChanged: (val){
        setState(() {
          firstName = val;
        });
      },
    );
  }

  Widget get _lastName {
    return TextFormField(
      decoration: TextStyles.textInputDecoration.copyWith(hintText: 'Last Name'),
      validator: (val) => FormValidators.validateName(val),
      onChanged: (val){
        setState(() {
          lastName = val;
        });
      },
    );
  }

  Widget get _dob {
    return TextFormField(
      decoration: TextStyles.textInputDecoration.copyWith(hintText: 'Date of birth'),
      validator: (val) => FormValidators.validateName(val),
      onChanged: (val){
        setState(() {
          lastName = val;
        });
      },
    );
  }

  Widget get _schoolName {
    return TextFormField(
      decoration: TextStyles.textInputDecoration.copyWith(hintText: 'School'),
      validator: (val) => FormValidators.validateName(val),
      onChanged: (val){
        setState(() {
          lastName = val;
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    user = CustomBlocProvider.getBloc<AuthBloc>().getUser;
  }

  @override
  Widget build(BuildContext context) {
    print('hello');
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
                  AppBarView(user: user,),
                  SizedBox(height: 20.0,),
                  Text(
                      'Enter Child\'s details below',
                      style: TextStyles.kSubTitleStyle
                  ),
                  SizedBox(height: 20.0,),
                  _firstName,
                  SizedBox(height: 20.0,),
                  _lastName,
                  SizedBox(height: 20.0,),
                  GenderView(callback: (value){
                    print('gender is $value');
                    return gender = value;
                  },),
                  SizedBox(height: 20.0,),
                  _dob,
                  SizedBox(height: 20.0,),
                  _schoolName,
                  SizedBox(height: 20.0,),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomSheet: BottomNav(textName: 'Continue',bgColor: AppColors.color16499f,onNavHit: (){
        Navigator.pop(context);
      },),
    );
  }

}
