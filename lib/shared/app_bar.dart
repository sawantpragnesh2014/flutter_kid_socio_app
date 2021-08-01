import 'package:flutter/material.dart';
import 'package:flutter_kid_socio_app/models/parent.dart';
import 'package:flutter_kid_socio_app/shared/styles.dart';

class AppBarView extends StatelessWidget implements PreferredSizeWidget {
  final Parent user;
  final double height;

  AppBarView({this.user,this.height});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 0.0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(user?.firstName, style: TextStyles.blackText),
            CircleAvatar(
              backgroundImage: user?.photoUrl == null ?AssetImage('assets/google_logo.png'):NetworkImage(user.photoUrl + '?width=400&height400'),
              radius: 40.0,
            ),
          ]),
    );
  }

  @override
  Size get preferredSize =>  Size.fromHeight(height);
}
