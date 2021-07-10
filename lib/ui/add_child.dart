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
import 'package:flutter_kid_socio_app/ui/interest_view.dart';
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
  String dob;
  String type = 'form';
  TextEditingController dateCtl = TextEditingController();

  DateTime currentDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(2005),
        lastDate: DateTime.now());

    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
        /*dob = currentDate.toString();
        dateCtl.text = currentDate.toIso8601String();*/
      });
  }

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
    return InkWell(
      onTap: () async {
        await _selectDate(context);
        dateCtl.text =  '${currentDate.day}/${currentDate.month}/${currentDate.year}';
      },
      child: IgnorePointer(
        child: TextFormField(
          controller: dateCtl,
          initialValue: dob,
          decoration: TextStyles.textInputDecoration.copyWith(hintText: 'Date of birth',suffixIcon: Icon(Icons.calendar_today_sharp),),
          validator: (val) => FormValidators.validateName(val),
          onChanged: (val){
            setState(() {
              dob = val;
            });
          },
        ),
      ),
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

  Widget get _addChildView{
    if(type.contains('form')) {
      return _childForm;
    }else if(type.contains('interests')) {
      return _interests;
    }else if(type.contains('profile_pic')) {
      return _addProfilePic;
    }
     return Container();
  }

  Widget get _childForm{
    return
      Form(
        key: formKey,
        child: Container(
        height: SizeConfig.blockSizeVertical*80,
        child: SingleChildScrollView(
        child:Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
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
    ))));
  }

  Widget get _interests{
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
              'Enter your child\'s interests',
              style: TextStyles.kSubTitleStyle
          ),
          SizedBox(height: 20.0,),
          InterestView()
        ],
      ),
    );
  }

  Widget get _addProfilePic{
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
              'Add a child to continue',
              style: TextStyles.kSubTitleStyle
          ),
          SizedBox(height: 20.0,),
          CircleAvatar(
            backgroundImage: AssetImage('assets/google_logo.png'),
            radius: 120.0,
          ),
          SizedBox(height: 30.0,),
          Center(
            child: Text(
                'Add a profile photo',
                style: TextStyles.kSubTitleStyle
            ),
          ),
        ],
      ),
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
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBarView( user:user, height:150.0),
        body: Padding(
          padding: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 0.0),
          child: _addChildView,
      ),
        bottomSheet: BottomNav(textName: 'Continue',bgColor: AppColors.color16499f,onNavHit: (){
          /*Navigator.pop(context);*/
          setState(() {
            if(type.contains('form') && (formKey.currentState.validate())) {
              type = 'interests';
            }else if(type.contains('interests')) {
              type = 'profile_pic';
            }
          });
        },),
      ),
    );
  }

}
