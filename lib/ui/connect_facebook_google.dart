import 'package:flutter/material.dart';
import 'package:flutter_kid_socio_app/shared/colors.dart';
import 'package:flutter_kid_socio_app/shared/styles.dart';

class ConnectFacebookGoogle extends StatelessWidget {

  Widget loginButton(Color bgColor,String logoPath,String btnText,TextStyle textStyle){
    return TextButton(
        onPressed:() => itemClick(),
        style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            backgroundColor: bgColor
        ),
        child: Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image(image: AssetImage('assets/$logoPath'), height: 35),
                SizedBox(width: 10.0,),
                Text('Login with $btnText',
                    style: textStyle
                ),
              ],
            )
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20.0, 60.0, 20.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          loginButton(Colors.white, 'google_logo.png', 'google', TextStyles.googleTextStyle),
          SizedBox(height: 10.0,),
          loginButton(AppColors.color16499f, 'facebook_logo.png', 'facebook', TextStyles.facebookTextStyle),
        ],
      ),
    );
  }


  ConnectFacebookGoogle({this.itemClick});

  final VoidCallback itemClick;

}
