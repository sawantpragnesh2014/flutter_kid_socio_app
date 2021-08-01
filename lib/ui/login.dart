import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kid_socio_app/blocs/auth_bloc.dart';
import 'package:flutter_kid_socio_app/blocs/bloc_provider.dart';
import 'package:flutter_kid_socio_app/models/parent.dart';
import 'package:flutter_kid_socio_app/shared/colors.dart';
import 'package:flutter_kid_socio_app/shared/loading.dart';
import 'package:flutter_kid_socio_app/shared/styles.dart';

import 'home.dart';

class Login extends StatefulWidget {
  bool loading = false;

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {


  @override
  Widget build(BuildContext context) {
    print('Login page ${widget.loading}');
    return  (widget.loading) ? Loading()
        : Scaffold(
          body: Align(alignment: Alignment.center,
            child: Container(
              padding: EdgeInsets.fromLTRB(20.0, 60.0, 20.0, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                      'Login Account',
                      style: TextStyles.redText
                  ),
                  SizedBox(height: 20.0,),
                  Text(
                      'Hello, welcome back to KidsSocio',
                      style: TextStyles.kSubTitleStyle
                  ),
                  SizedBox(height: 20.0,),
                  loginButton(Colors.white, 'google_logo.png', 'google', TextStyles.googleTextStyle),
                  SizedBox(height: 10.0,),
                  loginButton(AppColors.color16499f, 'facebook_logo.png', 'facebook', TextStyles.facebookTextStyle),
                ],
              ),
            )
            )
        );
  }

  Future<Parent> onGoogleSignIn(BuildContext context) async {
    Parent user = await CustomBlocProvider.getBloc<AuthBloc>().handleSignIn();
    print(user.uid);
    /*Parent user = bloc.getUser();
    var userSignedIn = Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                Home(user:user,googleSignIn: googleSignIn)));*/
    return user;
  }

  Widget loginButton(Color bgColor,String logoPath,String btnText,TextStyle textStyle){
    return TextButton(
        onPressed:() async {
          setState(() {
            widget.loading = true;
          });
          if(btnText.contains("facebook")){
              await CustomBlocProvider.getBloc<AuthBloc>().loginFromFaceBook();
          }else if(btnText.contains("google")){
             await onGoogleSignIn(context);
          }
        },
        style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            backgroundColor: bgColor
        ),
        child: Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image(image: AssetImage('assets/$logoPath'), height: 35),
                SizedBox(width: 10.0,),
                Text('Login with $btnText',
                    style: textStyle
                ),
              ],
            )
        )
    );
  }
}
