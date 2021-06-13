import 'package:flutter/material.dart';
import 'package:flutter_kid_socio_app/shared/colors.dart';
import 'package:flutter_kid_socio_app/shared/styles.dart';

class Payment extends StatefulWidget {
  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  int count = 0;

  String cardNumber ="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.fromLTRB(20.0, 60.0, 20.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text(
                'Payment Details',
                  style: TextStyles.redText
              ),
            ),
            SizedBox(height: 20.0,),
            Text(
              'CARD NUMBER',
              style: TextStyle(
                  letterSpacing: 2.0,
                  color: Colors.grey
              ),
            ),
            SizedBox(height: 20.0,),
            TextFormField(
              decoration: TextStyles.textInputDecoration.copyWith(hintText: 'Valid Card Number'),
              validator: (val) => val.isEmpty?'Enter a card number':null,
              onChanged: (val){
                setState(() {
                  cardNumber = val;
                });
              },
            ),
            SizedBox(height: 20.0,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'EXPIRATION DATE',
                      style: TextStyle(
                          letterSpacing: 2.0,
                          color: Colors.grey
                      ),
                    ),
                    SizedBox(height: 20.0,),
                    Container(
                      width: 100,
                      child: TextFormField(
                        decoration: TextStyles.textInputDecoration.copyWith(hintText: 'MM/YY'),
                        validator: (val) => val.isEmpty?'Enter month year':null,
                        onChanged: (val){
                          setState(() {
                            cardNumber = val;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 20.0,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'CV CODE',
                      style: TextStyle(
                          letterSpacing: 2.0,
                          color: Colors.grey
                      ),
                    ),
                    SizedBox(height: 20.0,),
                    Container(
                      width: 100,
                      child: TextFormField(
                        decoration: TextStyles.textInputDecoration.copyWith(hintText: 'CVC'),
                        validator: (val) => val.isEmpty?'Enter CVC':null,
                        onChanged: (val){
                          setState(() {
                            cardNumber = val;
                          });
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 20.0,),
            Text(
              'CARD OWNER',
              style: TextStyle(
                  letterSpacing: 2.0,
                  color: Colors.grey
              ),
            ),
            SizedBox(height: 20.0,),
            TextFormField(
              decoration: TextStyles.textInputDecoration.copyWith(hintText: 'Card Owner Name'),
              validator: (val) => val.isEmpty?'Enter a card number':null,
              onChanged: (val){
                setState(() {
                  cardNumber = val;
                });
              },
            ),
            SizedBox(height: 20.0,),
            Center(
              child: TextStyles.ElevatedButtonStyle('Confirm Payment'),
            ),

          ],
        ),
      ),
    );
  }
}
