import 'package:flutter/material.dart';
import 'package:flutter_kid_socio_app/models/child.dart';
import 'package:flutter_kid_socio_app/shared/styles.dart';
import 'package:flutter_kid_socio_app/utils/image_utils.dart';

import 'colors.dart';

class ChildInfo extends StatefulWidget {
  final Child? child;

  ChildInfo({this.child});

  @override
  _ChildInfoState createState() => _ChildInfoState();
}

class _ChildInfoState extends State<ChildInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: 80.0,
            width: 80.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: widget.child?.photoUrl == null ?AssetImage('assets/google_logo.png'):AssetImage('assets/default_profile_picture.png'),
                fit: BoxFit.contain,
              ),
              borderRadius: BorderRadius.all( Radius.circular(60.0)),
              border: Border.all(
                color: AppColors.colorEB4C57,
                width: 8.0,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('${widget.child!.firstName}',style: AppStyles.redTextBoldLarge,),
              RichText(
                  text: TextSpan(
                      children: [
                        TextSpan(text: 'Playdates ',style: AppStyles.blackTextMedium14),
                        TextSpan(
                          text: '20',
                          style: AppStyles.blackTextBold16,),
                      ]
                  )
              ),
              Text('100',style: AppStyles.blackTextBold24,),
            ],
          )

        ],
      ),
    );
  }
}
