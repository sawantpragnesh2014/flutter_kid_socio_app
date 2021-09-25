import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kid_socio_app/blocs/auth_bloc.dart';
import 'package:flutter_kid_socio_app/blocs/bloc_provider.dart';
import 'package:flutter_kid_socio_app/models/parent.dart';
import 'package:flutter_kid_socio_app/shared/app_bar.dart';
import 'package:flutter_kid_socio_app/shared/app_bar_new.dart';
import 'package:flutter_kid_socio_app/shared/colors.dart';
import 'package:flutter_kid_socio_app/shared/loading.dart';
import 'package:flutter_kid_socio_app/shared/styles.dart';

import '../home/home.dart';

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
          appBar: AppBarNew(height: 120.0,),
          body: Align(alignment: Alignment.center,
            child: Container(
              padding: EdgeInsets.fromLTRB(30.0, 60.0, 30.0, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                      'Login to your existing account',
                      style: AppStyles.blackTextBold24
                  ),
                  SizedBox(height: 20.0,),
                  SizedBox(height: 20.0,),
                  loginButton(AppColors.colorDADADA, 'google_logo.png', 'Google', AppStyles.blackTextBold16),
                  SizedBox(height: 10.0,),
                  Text(
                      'Or with',
                      style: AppStyles.blackTextMedium14,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10.0,),
                  loginButton(AppColors.colorDADADA, 'facebook_logo.png', 'Facebook', AppStyles.blackTextBold16),
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
          if(btnText.contains("Facebook")){
              await CustomBlocProvider.getBloc<AuthBloc>().loginFromFaceBook();
          }else if(btnText.contains("Google")){
             await onGoogleSignIn(context);
          }
        },
        style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            backgroundColor: bgColor
        ),
        child: Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image(image: AssetImage('assets/$logoPath'), height: 35),
                SizedBox(width: 8.0,),
                Text('$btnText',
                    style: textStyle
                ),
              ],
            )
        )
    );
  }
}
