import 'package:flutter/material.dart';
import 'package:flutter_kid_socio_app/blocs/auth_bloc.dart';
import 'package:flutter_kid_socio_app/blocs/bloc_provider.dart';
import 'package:flutter_kid_socio_app/blocs/login_bloc.dart';
import 'package:flutter_kid_socio_app/models/parent.dart';
import 'package:flutter_kid_socio_app/services/api_response.dart';
import 'package:flutter_kid_socio_app/shared/error_page.dart';
import 'package:flutter_kid_socio_app/shared/loading.dart';
import 'package:flutter_kid_socio_app/shared/splash_screen.dart';
import 'package:flutter_kid_socio_app/ui/home/home.dart';
import 'package:flutter_kid_socio_app/ui/home/home_new.dart';
import 'package:flutter_kid_socio_app/ui/login/registration_form.dart';
import 'home/home.dart';

import 'login/login.dart';
import 'on_boarding.dart';

class RootPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final Auth auth = AuthProvider.of(context).auth;
    return StreamBuilder<Parent>(
        stream: CustomBlocProvider.getBloc<AuthBloc>().onAuthStateChanged,
        builder: (BuildContext context, AsyncSnapshot<Parent> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final bool isLoggedIn = snapshot.hasData;
            CustomBlocProvider.getBloc<AuthBloc>().setUser(snapshot.data);
            print('Auth changed $isLoggedIn');

            return isLoggedIn ? handleLoggedInState() : OnBoarding();
          }
          return SplashScreen();
        });
  }

  /*handleLoggedInState() {
    print('uid of user is ${CustomBlocProvider.getBloc<AuthBloc>().getUser.uid}');
    CustomBlocProvider.getBloc<LoginBloc>().fetchParent(CustomBlocProvider.getBloc<AuthBloc>().getUser.uid);
    return StreamBuilder<ApiResponse<Parent>>(
        stream: CustomBlocProvider.getBloc<LoginBloc>().parentStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            switch (snapshot.data.status) {
              case Status.LOADING:
                return Loading();
                break;
              case Status.COMPLETED:
                Parent parent = snapshot.data.data;
                if(parent.phoneNo == null){
                  return RegistrationForm();
                } else{
                  return Home();
                }
                break;
              case Status.ERROR:
                return Text(snapshot.data.message);
                break;
            }
          }
          return Container();

        },
    );*/


    /*bool isRegistered = true;
    if(isRegistered){
      return Home();
    }
    return RegistrationForm();
  }*/

  handleLoggedInState() {
    print('uid of user is ${CustomBlocProvider.getBloc<AuthBloc>().getUser.uid}');

    return FutureBuilder<Parent>(

      future: CustomBlocProvider.getBloc<LoginBloc>()
          .fetchParent(CustomBlocProvider.getBloc<AuthBloc>().getUser.uid),

      builder: (context, snapshot) {

        print('Connection state ${snapshot.connectionState}');
        print('Connection snapshot.hasError ${snapshot.hasError}');

        if (snapshot.connectionState == ConnectionState.waiting) {
          print('data loading');
          return Loading();
        } else {
          if (snapshot.hasData) {
            print('data found');
            Parent parent = snapshot.data;
            print('parent is ${parent}');
            CustomBlocProvider.getBloc<AuthBloc>().setUser(parent);
            return HomeNew();
          } else if (snapshot.hasError) {
            return ErrorPage(
              errorMessage: snapshot.error.toString(),
              onRetryPressed: () => handleLoggedInState(),
            );
          } else {
            print('data empty ${snapshot.data}');
            return RegistrationForm();
          }
        }
      },
    );
  }
}
