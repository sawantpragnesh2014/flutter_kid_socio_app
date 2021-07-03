import 'package:flutter/material.dart';
import 'package:flutter_kid_socio_app/models/user.dart';
import 'package:flutter_kid_socio_app/shared/styles.dart';

class AppBarView extends StatelessWidget {
  final User user;

  AppBarView({this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(user?.name, style: TextStyles.blackText),
            CircleAvatar(
              backgroundImage: user?.photoUrl == null ?AssetImage('assets/google_logo.png'):NetworkImage(user.photoUrl + '?width=400&height400'),
              radius: 40.0,
            ),
          ]),
    );
  }
}
