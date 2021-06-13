import 'package:flutter/material.dart';

class ConnectFacebookGoogle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextButton(
          /*onPressed: itemClick('google'),*/
          style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              backgroundColor: Colors.white
          ),
          child: Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image(image: AssetImage('assets/google_logo.png'), height: 35),
                  Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text('Sign in with Google',
                          style: TextStyle(color: Colors.grey, fontSize: 25)))
                  ],
                )
              )
            )
        ],
      ),
    );
  }


  /*ConnectFacebookGoogle(this.itemClick);

  final VoidCallback itemClick;*/

}
