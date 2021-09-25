import 'package:flutter/material.dart';
import 'package:flutter_kid_socio_app/shared/colors.dart';
import 'package:flutter_kid_socio_app/shared/styles.dart';
import 'package:flutter_svg/svg.dart';

class AppBarNew extends StatelessWidget implements PreferredSizeWidget {

  final double height;

  AppBarNew({this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.color7059E1,
      child: Center(
        child: Text('Kid Socio',style: AppStyles.whiteTextBold40,),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
