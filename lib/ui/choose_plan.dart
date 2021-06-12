import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kid_socio_app/shared/styles.dart';
import 'package:flutter_kid_socio_app/ui/payment_gateway.dart';

class ChoosePlan extends StatefulWidget {

  final FirebaseUser user;

  ChoosePlan(this.user);

  @override
  _ChoosePlanState createState() => _ChoosePlanState();
}

class _ChoosePlanState extends State<ChoosePlan> {
  String email = "";
  Widget cardView(String txt1, String txt2, String txt3, Color color) {
    return Container(
      height: 150,
      width: 150,
      child: Card(
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(txt1, style: TextStyle(fontSize: 30.0, color: Colors.white)),
              Text(txt2, style: TextStyle(fontSize: 10.0, color: Colors.white)),
              Text(txt3, style: TextStyle(fontSize: 20.0, color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      body: Padding(
        padding: EdgeInsets.fromLTRB(15.0, 50.0, 15.0, 0.0),
        child: Container(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Chetan', style: blackText),
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/google_logo.png'),
                    radius: 40.0,
                  ),
                ]),
            SizedBox(
              height: 10.0,
            ),
            Text('Choose your plan', style: redText),
            SizedBox(
              height: 10.0,
            ),
            Text('Choose a plan that works \nbest for you',
                style: blackTextSmall),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                cardView('Trial', '3 playdates', 'for 1 week',Colors.red[300]),
                cardView('Rs 500', 'Unlimited Playdates', 'for 1 month',Color(0xFFe6e6e6),),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                cardView('Rs 1500', 'Unlimited playdates', 'for 3 months',Color(0xFF16499f)),
                cardView('Rs 5000', 'unlimited playdates', 'for 1 year',Color(0xFFfbaf43)),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            TextFormField(
              decoration: textInputDecoration.copyWith(hintText: 'Have a coupon?'),
              validator: (val) => val.isEmpty?'Enter a valid coupon':null,
              onChanged: (val){
                setState(() {
                  email = val;
                });
              },
            ),
          ],
        )
        ),
      ),
      bottomSheet: Container(
        height: 100.0,
        width: double.infinity,
        color: Color(0xFF16499f),
        child: GestureDetector(
          onTap: () => print('Get Started'),
          child: Padding(
              padding: EdgeInsets.only(bottom: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Continue',
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                  SizedBox(width: 10.0,),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Color(0xFFfbaf43),
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    child: Icon(Icons.arrow_forward_ios,size: 30.0,color: Colors.white,),
                  ),
                  SizedBox(width: 10.0,),
                ],
              )
          ),
        ),
      )
    );
  }
}
