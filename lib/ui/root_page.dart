import 'package:flutter/material.dart';
import 'package:flutter_kid_socio_app/blocs/auth_bloc.dart';
import 'package:flutter_kid_socio_app/blocs/bloc_provider.dart';
import 'package:flutter_kid_socio_app/models/user.dart';
import 'package:flutter_kid_socio_app/shared/colors.dart';
import 'package:flutter_kid_socio_app/ui/home.dart';
import 'package:flutter_kid_socio_app/ui/on_boarding_two.dart';
import 'package:flutter_kid_socio_app/ui/registration_form.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'home.dart';

import 'add_child.dart';
import 'login.dart';

class RootPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final Auth auth = AuthProvider.of(context).auth;
    return StreamBuilder<Parent>(
          stream: CustomBlocProvider.getBloc<AuthBloc>().onAuthStateChanged,
          builder: (BuildContext context,AsyncSnapshot<Parent> snapshot){
              if(snapshot.connectionState == ConnectionState.active){
                final bool isLoggedIn = snapshot.hasData;
                CustomBlocProvider.getBloc<AuthBloc>().setUser(snapshot.data);
                print('Auth changed $isLoggedIn');
                return isLoggedIn? RegistrationForm():Login();
              }
              return Loading();
          }
      );
    }

  Widget Loading() {
    return Container(
      color: Colors.white,
      child: Center(
        child: SpinKitDoubleBounce(
          color: Colors.red[900],
          size: 50.0,
        ),
      ),

    );
  }

}
