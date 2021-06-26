import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kid_socio_app/blocs/login_bloc.dart';
import 'package:flutter_kid_socio_app/models/user.dart';
import 'package:flutter_kid_socio_app/ui/bottom_nav.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();

}

class _HomeState extends State<Home> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /*Home(User user,GoogleSignIn googleSignIn){
      _user = user;
      _googleSignIn = googleSignIn;
    }*/
    print('hello');
    return Scaffold(
              body: Container(
                child: Text('Welcome user with uid'),
              ),
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

}
