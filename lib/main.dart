import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kid_socio_app/blocs/add_child_bloc.dart';
import 'package:flutter_kid_socio_app/blocs/auth_bloc.dart';
import 'package:flutter_kid_socio_app/blocs/child_bloc.dart';
import 'package:flutter_kid_socio_app/blocs/login_bloc.dart';
import 'package:flutter_kid_socio_app/ui/home/dashboard.dart';
import 'package:flutter_kid_socio_app/ui/searchplaydate/search_playdates.dart';
import 'package:flutter_kid_socio_app/ui/login/add_profile_pic.dart';
import 'package:flutter_kid_socio_app/shared/styles.dart';
import 'package:flutter_kid_socio_app/ui/choose_plan.dart';
import 'package:flutter_kid_socio_app/ui/login/connect_facebook_google.dart';
import 'package:flutter_kid_socio_app/ui/home/home.dart';
import 'package:flutter_kid_socio_app/ui/add_child/add_child.dart';
import 'package:flutter_kid_socio_app/ui/home/home_new.dart';
import 'package:flutter_kid_socio_app/ui/add_child/interest_view.dart';
import 'package:flutter_kid_socio_app/ui/login/login.dart';
import 'package:flutter_kid_socio_app/ui/on_boarding.dart';
import 'package:flutter_kid_socio_app/ui/login/otp_screen.dart';
import 'package:flutter_kid_socio_app/ui/login/otp_screen_new.dart';
import 'package:flutter_kid_socio_app/ui/payment_gateway.dart';
import 'package:flutter_kid_socio_app/ui/login/phone_verification.dart';
import 'package:flutter_kid_socio_app/ui/login/privacy_policy.dart';
import 'package:flutter_kid_socio_app/ui/login/registration_form.dart';
import 'package:flutter_kid_socio_app/ui/root_page.dart';

import 'blocs/bloc_provider.dart';
import 'models/child.dart';
import 'models/parent.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  CustomBlocProvider.setBloc(AuthBloc());
  CustomBlocProvider.setBloc(LoginBloc());
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
        debugShowCheckedModeBanner: false,
        home: RootPage(),
    );
  }
}

