import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kid_socio_app/blocs/add_child_bloc.dart';
import 'package:flutter_kid_socio_app/blocs/auth_bloc.dart';
import 'package:flutter_kid_socio_app/blocs/bloc_provider.dart';
import 'package:flutter_kid_socio_app/blocs/child_bloc.dart';
import 'package:flutter_kid_socio_app/blocs/login_bloc.dart';
import 'package:flutter_kid_socio_app/models/child.dart';
import 'package:flutter_kid_socio_app/models/parent.dart';
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
import 'package:image_picker/image_picker.dart';

class AddChild extends StatefulWidget {
  @override
  _AddChildState createState() => _AddChildState();

}

class _AddChildState extends State<AddChild> {
  Parent user;
  final formKey = GlobalKey<FormState>();
  String firstName;
  String lastName;
  String schoolName;
  String email;
  String gender;
  String dob;
  File _image;
  TextEditingController dateCtl = TextEditingController();
  final _picker = ImagePicker();

  DateTime currentDate = DateTime.now();

  _imgFromCamera() async {
    final pickedFile = await _picker.getImage(source: ImageSource.camera,);
    final File image = File(pickedFile.path);

    setState(() {
      _image = image;
    });
  }

  _imgFromGallery() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery,);
    final File image = File(pickedFile.path);
    setState(() {
      _image = image;
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        }
    );
  }

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
          validator: (val) => FormValidators.validateDob(val),
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
          schoolName = val;
        });
      },
    );
  }

  Widget _addChildView(Type type){
    switch(type){
      case Type.FORM:
        return _childForm;
      case Type.INTEREST:
        return _interests;
      case Type.PROFILE:
        return _addProfilePic;
      default:
        return Container();
    }
  }

  Widget get _childForm{
    return
      Form(
        key: formKey,
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
    )));
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
          GestureDetector(
            onTap: (){
              _showPicker(context);
            },
            child: CircleAvatar(
              backgroundImage: _image != null
                  ? FileImage(_image) : AssetImage('assets/google_logo.png'),
              radius: 120.0,
            ),
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
    return StreamBuilder(
      initialData: Type.FORM,
      stream: CustomBlocProvider.getBloc<AddChildBloc>().childListStream,
      builder: (context, snapshot) {
        Type type = snapshot.data;
        return SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBarView(user: user, height: 150.0),
            body: Padding(
              padding: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 0.0),
              child: Container(
                  height: SizeConfig.blockSizeVertical * 67,
                  child: _addChildView(type)
              ),
            ),
            bottomSheet: BottomNav(textName: 'Continue',
              bgColor: AppColors.color16499f,
              onNavHit: () {
                /*Navigator.pop(context);*/
                  print('${type.toString()}');

                  switch(type){
                    case Type.FORM:
                      if (!(formKey.currentState.validate())) {
                        CustomBlocProvider.getBloc<AddChildBloc>().childListSink.add(Type.INTEREST);
                      }
                      break;
                    case Type.INTEREST:
                      CustomBlocProvider.getBloc<AddChildBloc>().childListSink.add(Type.PROFILE);
                      break;
                    case Type.PROFILE:
                    default:
                    CustomBlocProvider.getBloc<ChildBloc>().addChild(
                        Child(name: (firstName + ' ' + lastName),
                            dob: dob,
                            gender: gender,
                            schoolName: schoolName,
                            photoUrl: _upload()
                        ));
                    Navigator.pop(context);
                    break;
                  }
              },),
          ),
        );
      }
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    CustomBlocProvider.getBloc<ChildBloc>().dispose();
    CustomBlocProvider.getBloc<AddChildBloc>().dispose();
  }

  String _upload() {
    if (_image == null) return null;
    String base64Image = base64Encode(_image.readAsBytesSync());
    String fileName = _image.path.split("/").last;
    return base64Image;
  }

}
