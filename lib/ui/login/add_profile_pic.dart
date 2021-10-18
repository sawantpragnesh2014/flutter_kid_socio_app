import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_kid_socio_app/blocs/auth_bloc.dart';
import 'package:flutter_kid_socio_app/blocs/bloc_provider.dart';
import 'package:flutter_kid_socio_app/blocs/login_bloc.dart';
import 'package:flutter_kid_socio_app/models/parent.dart';
import 'package:flutter_kid_socio_app/services/api_response.dart';
import 'package:flutter_kid_socio_app/shared/action_button.dart';
import 'package:flutter_kid_socio_app/shared/add_pic.dart';
import 'package:flutter_kid_socio_app/shared/app_bar_new.dart';
import 'package:flutter_kid_socio_app/shared/error_page.dart';
import 'package:flutter_kid_socio_app/shared/loading.dart';
import 'package:flutter_kid_socio_app/shared/styles.dart';
import 'package:flutter_kid_socio_app/ui/home/home.dart';
import 'package:flutter_kid_socio_app/ui/home/home_new.dart';
import 'package:image_picker/image_picker.dart';

import '../../shared/app_bar.dart';


class AddProfilePic extends StatefulWidget {

  @override
  _AddProfilePicState createState() => _AddProfilePicState();

}

class _AddProfilePicState extends State<AddProfilePic> {

  late LoginBloc _loginBloc;
  late AuthBloc _authBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loginBloc = CustomBlocProvider.getBloc<LoginBloc>()!;
    _authBloc = CustomBlocProvider.getBloc<AuthBloc>()!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBarNew(height: 120.0,),
      body: StreamBuilder<ApiResponse<int>>(
          stream: _loginBloc.parentStream,
          builder: (context, snapshot) {
            if(snapshot.hasData){
              switch(snapshot.data!.status){
                case Status.LOADING:
                  return Loading();
                case Status.COMPLETED:
                  print('create parent completed');
                  _loginBloc.parent!.id = snapshot.data!.data!;
                  print('calling home screen now');
                  Future.delayed(Duration.zero, () {
                    Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) => HomeNew()));
                  });
                  break;
                case Status.ERROR:
                  return ErrorPage(
                    errorMessage: snapshot.data!.message,
                    onRetryPressed: () => _loginBloc.createParent(_loginBloc.generateParentObject(_authBloc.getUser!.uid)),
                  );
                default:
                  return ErrorPage(
                    errorMessage: 'Some error occured',
                    onRetryPressed: () => _loginBloc.createParent(_loginBloc.generateParentObject(_authBloc.getUser!.uid)),
                  );
              }
            }
            return AddPic(
              onActionBtnHit: (val){
                /*_loginBloc.photoUrl = val;*/
              _loginBloc.createParent(_loginBloc.generateParentObject(_authBloc.getUser!.uid));
                /*Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) => HomeNew()));*/

              },
              photoUrl: _loginBloc.photoUrl,
            btnStyle: AppStyles.stylePinkButton,);
          }
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _loginBloc.dispose();
  }
}
