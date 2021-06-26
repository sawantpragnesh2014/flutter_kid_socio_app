import 'package:flutter/material.dart';
import 'package:flutter_kid_socio_app/models/user.dart';
import 'package:flutter_kid_socio_app/services/user_repository.dart';
import 'package:flutter_kid_socio_app/ui/registration_form.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'home.dart';
import 'login.dart';

class RootPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Auth auth = AuthProvider.of(context).auth;
    return StreamBuilder<User>(
          stream: auth.onAuthStateChanged,
          builder: (BuildContext context,AsyncSnapshot<User> snaphot){
              if(snaphot.connectionState == ConnectionState.active){
                final bool isLoggedIn = snaphot.hasData;
                auth.setUser(snaphot.data);
                return isLoggedIn? RegistrationForm():Login();
              }
              return Loading();
          }
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
