import 'package:flutter/material.dart';
import 'package:flutter_kid_socio_app/ui/choose_plan.dart';
import 'package:flutter_kid_socio_app/ui/connect_facebook_google.dart';
import 'package:flutter_kid_socio_app/ui/login.dart';
import 'package:flutter_kid_socio_app/ui/on_boarding.dart';
import 'package:flutter_kid_socio_app/ui/on_boarding_two.dart';
import 'package:flutter_kid_socio_app/ui/payment_gateway.dart';
import 'package:flutter_kid_socio_app/ui/registration_form.dart';

void main() {
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
      home: ConnectFacebookGoogle(),
    );
  }
}

