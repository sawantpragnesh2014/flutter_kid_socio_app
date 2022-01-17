import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_kid_socio_app/blocs/auth_bloc.dart';
import 'package:flutter_kid_socio_app/blocs/bloc_provider.dart';
import 'package:flutter_kid_socio_app/blocs/login_bloc.dart';
import 'package:flutter_kid_socio_app/services/api_response.dart';
import 'package:flutter_kid_socio_app/shared/add_pic.dart';
import 'package:flutter_kid_socio_app/shared/app_bar_new.dart';
import 'package:flutter_kid_socio_app/shared/error_page.dart';
import 'package:flutter_kid_socio_app/shared/loading.dart';
import 'package:flutter_kid_socio_app/shared/styles.dart';
import 'package:flutter_kid_socio_app/ui/home/home_new.dart';

class AddProfilePic extends StatefulWidget {

  @override
  _AddProfilePicState createState() => _AddProfilePicState();

}

class _AddProfilePicState extends State<AddProfilePic> {

  late LoginBloc _loginBloc;
  late AuthBloc _authBloc;

  @override
  void initState() {
    super.initState();
    _loginBloc = CustomBlocProvider.getBloc<LoginBloc>()!;
    _loginBloc.startBroadCast();
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
                  print('loading create parent');
                  return Loading();

                case Status.COMPLETED:
                  print('create parent completed');
                  _loginBloc.parent!.id = snapshot.data!.data!;

                  if((_loginBloc.photoUrl == null || _loginBloc.photoUrl!.isEmpty)  && _authBloc.getUser!.photoURL == null ){
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Select a pic.',style: AppStyles.errorText),
                      ),
                    );
                    break;
                  }

                  _loginBloc.uploadParentPic(_loginBloc.parent!.id,_loginBloc.photoUrl ?? '').then((value) => {
                    Future.delayed(Duration.zero, () {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) => HomeNew()));
                    })
                  });
                  print('calling home screen now');
                  break;

                case Status.ERROR:
                default:
                  return ErrorPage(
                    errorMessage: snapshot.data!.message ?? 'Some error occured',
                    onRetryPressed: () => _loginBloc.createParent(_loginBloc.generateParentObject(_authBloc.getUser!.uid)),
                  );
              }
            }
            return AddPic(
              onActionBtnHit: (val){
              /*Image image = Image.memory(base64Decode(val));*/
              print('image is $val');
                _loginBloc.photoUrl = val;
              _loginBloc.createParent(_loginBloc.generateParentObject(_authBloc.getUser!.uid));
              },
              photoUrl: _authBloc.getUser!.photoURL ?? '',
            btnStyle: AppStyles.stylePinkButton,);
          }
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    print('dispose called add pro pic');
    _loginBloc.dispose();
  }
}
