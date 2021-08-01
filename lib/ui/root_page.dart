import 'package:flutter/material.dart';
import 'package:flutter_kid_socio_app/blocs/auth_bloc.dart';
import 'package:flutter_kid_socio_app/blocs/bloc_provider.dart';
import 'package:flutter_kid_socio_app/blocs/login_bloc.dart';
import 'package:flutter_kid_socio_app/models/parent.dart';
import 'package:flutter_kid_socio_app/services/api_response.dart';
import 'package:flutter_kid_socio_app/shared/colors.dart';
import 'package:flutter_kid_socio_app/shared/loading.dart';
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

                return isLoggedIn?handleLoggedInState():Login();
              }
              return Loading();
          }
      );
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
        future: CustomBlocProvider.getBloc<LoginBloc>().fetchParent(CustomBlocProvider.getBloc<AuthBloc>().getUser.uid),
        builder: (context, snapshot) {
          print('Connection state ${snapshot.connectionState}');
          if (snapshot.connectionState == ConnectionState.waiting) {
            print('data loading');
            return Loading();
          } else {
            if (snapshot.hasData) {
              print('data found');
              Parent parent = snapshot.data;
              print('parent is ${parent}');
              CustomBlocProvider.getBloc<AuthBloc>().setUser(parent);
              return Home();
            }else if(snapshot.hasError){
              print(snapshot.error.toString());
              return Text(snapshot.error.toString());
            }else{
              print('data empty ${snapshot.data}');
              return RegistrationForm();
            }
          }
        },
    );
  }

}
