import 'package:flutter/material.dart';
import 'package:flutter_kid_socio_app/blocs/auth_bloc.dart';
import 'package:flutter_kid_socio_app/blocs/bloc_provider.dart';
import 'package:flutter_kid_socio_app/models/parent.dart';
import 'package:flutter_kid_socio_app/shared/colors.dart';
import 'package:flutter_kid_socio_app/shared/styles.dart';

class AppBarView extends StatelessWidget implements PreferredSizeWidget {
  final double height;

  AppBarView({this.height});

  @override
  Widget build(BuildContext context) {
    Parent user = CustomBlocProvider.getBloc<AuthBloc>().getUser;
    return Container(
      decoration: BoxDecoration(
          color: AppColors.color7059E1,
          borderRadius: new BorderRadius.only(
            bottomLeft: const Radius.circular(40.0),
            bottomRight: const Radius.circular(40.0),
          )),
      padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Hello, ${user?.firstName?? 'Dummy Name'}', style: TextStyles.whiteTextBold),
                  SizedBox(height: 8.0,),
                  Text('35/150 days',style: TextStyles.whiteTextMedium,)
                ],
              ),
            ),
            Expanded(
              flex: 1,
                child: Icon(Icons.notifications)
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  color: AppColors.colorFFC107,
                  borderRadius: BorderRadius.all(Radius.circular(60.0))
                ),
                child: CircleAvatar(
                  backgroundImage: user?.photoUrl == null ?AssetImage('assets/google_logo.png'):NetworkImage(user.photoUrl + '?width=400&height400'),
                  radius: 30.0,
                ),
              ),
            ),
          ]),
    );
  }

  @override
  Size get preferredSize =>  Size.fromHeight(height??120.0);
}
