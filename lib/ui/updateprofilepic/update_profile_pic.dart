import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_kid_socio_app/blocs/auth_bloc.dart';
import 'package:flutter_kid_socio_app/blocs/bloc_provider.dart';
import 'package:flutter_kid_socio_app/blocs/login_bloc.dart';
import 'package:flutter_kid_socio_app/models/parent.dart';
import 'package:flutter_kid_socio_app/shared/add_pic.dart';
import 'package:flutter_kid_socio_app/shared/app_bar_new.dart';
import 'package:flutter_kid_socio_app/shared/styles.dart';
import 'package:flutter_kid_socio_app/utils/image_utils.dart';

class UpdateProfilePic extends StatefulWidget {
  @override
  _UpdateProfilePicState createState() => _UpdateProfilePicState();
}

class _UpdateProfilePicState extends State<UpdateProfilePic> {

  late LoginBloc _loginBloc;
  late AuthBloc _authBloc;
  File? image;

  @override
  void initState() {
    super.initState();
    _loginBloc = CustomBlocProvider.getBloc<LoginBloc>()!;
    _loginBloc.startBroadCast();
    _authBloc = CustomBlocProvider.getBloc<AuthBloc>()!;
    setFileImage(_loginBloc.parent!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBarNew(height: 120.0,),
        body: AddPic(
          onActionBtnHit: (val) {
            /*Image image = Image.memory(base64Decode(val));*/
            print('image is $val');
            if(val.isEmpty){
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('No pic selected',style: AppStyles.errorText ,),
                ),
              );
              return;
            }
            _loginBloc.uploadParentPic(_loginBloc.parent!.id,val).then((value) => {
              Navigator.pop(context)
            });
          },
          btnStyle: AppStyles.stylePinkButton,
            image:image)
    );
  }

  @override
  void dispose() {
    super.dispose();
    print('dispose called add pro pic');
    _loginBloc.dispose();
  }

  Future<void> setFileImage(Parent user) async {
    if(image != null){
      return;
    }
    image = await ImageUtils.getFile('parent_profile_pic');
    if(image == null){
      image = await ImageUtils.getFileByUrl('parent_profile_pic',await CustomBlocProvider.getBloc<LoginBloc>()!.fetchParentPic(user.id));
    }
    if(image == null){
      return;
    }
    setState(() {
    });
  }
}

