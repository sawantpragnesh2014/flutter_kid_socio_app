import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kid_socio_app/blocs/auth_bloc.dart';
import 'package:flutter_kid_socio_app/blocs/bloc_provider.dart';
import 'package:flutter_kid_socio_app/blocs/login_bloc.dart';
import 'package:flutter_kid_socio_app/models/user.dart';
import 'package:flutter_kid_socio_app/shared/colors.dart';
import 'package:flutter_kid_socio_app/shared/styles.dart';
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
              body: Center(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Welcome ${CustomBlocProvider.getBloc<AuthBloc>().getUser?.name}',style: TextStyles.kTitleStyle,),
                      SizedBox(height: 20.0,),
                      TextButton(
                          onPressed:(){
                            CustomBlocProvider.getBloc<AuthBloc>().signOut();
                            Navigator.pop(context);
                          },
                          style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              backgroundColor: AppColors.coloref4138
                          ),
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                              child: Text('Log out',
                                  style: TextStyles.facebookTextStyle
                              )
                          )
                      )

                    ],
                  ),
                ),
              ),
            );
  }

}
