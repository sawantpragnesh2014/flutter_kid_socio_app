import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kid_socio_app/blocs/auth_bloc.dart';
import 'package:flutter_kid_socio_app/blocs/child_bloc.dart';
import 'package:flutter_kid_socio_app/blocs/login_bloc.dart';
import 'package:flutter_kid_socio_app/ui/choose_plan.dart';
import 'package:flutter_kid_socio_app/ui/connect_facebook_google.dart';
import 'package:flutter_kid_socio_app/ui/home.dart';
import 'package:flutter_kid_socio_app/ui/add_child.dart';
import 'package:flutter_kid_socio_app/ui/login.dart';
import 'package:flutter_kid_socio_app/ui/on_boarding.dart';
import 'package:flutter_kid_socio_app/ui/on_boarding_two.dart';
import 'package:flutter_kid_socio_app/ui/otp_screen.dart';
import 'package:flutter_kid_socio_app/ui/payment_gateway.dart';
import 'package:flutter_kid_socio_app/ui/privacy_policy.dart';
import 'package:flutter_kid_socio_app/ui/registration_form.dart';
import 'package:flutter_kid_socio_app/ui/root_page.dart';

import 'blocs/bloc_provider.dart';
import 'models/user.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  CustomBlocProvider.setBloc(AuthBloc());
  CustomBlocProvider.setBloc(ChildBloc());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: RootPage(),
    );
  }
}

