import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kid_socio_app/models/user.dart';
import 'package:flutter_kid_socio_app/services/user_repository.dart';
import 'package:flutter_kid_socio_app/ui/choose_plan.dart';
import 'package:flutter_kid_socio_app/ui/connect_facebook_google.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'home.dart';

class Login extends StatefulWidget {
  bool loading = false;

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {


  @override
  Widget build(BuildContext context) {
    return  (widget.loading) ? Loading()
        : Align(alignment: Alignment.center,
          child: ConnectFacebookGoogle(itemClick: () {
            onGoogleSignIn(context);
            setState(() {
              widget.loading = true;
            });
          },
          )
        );
  }

  Widget Loading() {
    return Container(
      color: Colors.brown[100],
      child: Center(
        child: SpinKitDoubleBounce(
          color: Colors.brown,
          size: 50.0,
        ),
      ),

    );
  }

  void onGoogleSignIn(BuildContext context) async {
    User user = await AuthProvider.of(context).auth.handleSignIn();
    print(user.uid);
    /*User user = bloc.getUser();
    var userSignedIn = Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                Home(user:user,googleSignIn: googleSignIn)));*/
  }
}
