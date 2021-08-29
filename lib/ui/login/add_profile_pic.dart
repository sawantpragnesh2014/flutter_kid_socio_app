import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_kid_socio_app/blocs/auth_bloc.dart';
import 'package:flutter_kid_socio_app/blocs/bloc_provider.dart';
import 'package:flutter_kid_socio_app/shared/action_button.dart';
import 'package:flutter_kid_socio_app/shared/add_pic.dart';
import 'package:flutter_kid_socio_app/shared/app_bar_new.dart';
import 'package:flutter_kid_socio_app/shared/styles.dart';
import 'package:flutter_kid_socio_app/ui/home/home_new.dart';
import 'package:image_picker/image_picker.dart';

import '../../shared/app_bar.dart';


class AddProfilePic extends StatefulWidget {

  @override
  _AddProfilePicState createState() => _AddProfilePicState();

}

class _AddProfilePicState extends State<AddProfilePic> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBarNew(height: 120.0,),
      body: AddPic(onActionBtnHit: (val){
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => HomeNew()));
      },photoUrl: CustomBlocProvider.getBloc<AuthBloc>().getUser?.photoUrl,)
    );
  }


}
