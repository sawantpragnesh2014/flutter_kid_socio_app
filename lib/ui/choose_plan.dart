import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kid_socio_app/blocs/auth_bloc.dart';
import 'package:flutter_kid_socio_app/blocs/bloc_provider.dart';
import 'package:flutter_kid_socio_app/shared/app_bar.dart';
import 'package:flutter_kid_socio_app/shared/colors.dart';
import 'package:flutter_kid_socio_app/shared/size_config.dart';
import 'package:flutter_kid_socio_app/shared/styles.dart';
import 'package:flutter_kid_socio_app/ui/payment_gateway.dart';

import 'bottom_nav.dart';

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
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset : false,
      body: Padding(
        padding: EdgeInsets.fromLTRB(15.0, 50.0, 15.0, 0.0),
        child: Container(
            height: SizeConfig.blockSizeVertical*80,
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppBarView(user: CustomBlocProvider.getBloc<AuthBloc>().getUser,),
            SizedBox(
              height: 10.0,
            ),
            Text('Choose your plan', style: TextStyles.redText),
            SizedBox(
              height: 10.0,
            ),
            Text('Choose a plan that works \nbest for you',
                style: TextStyles.blackTextSmall),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                cardView('Trial', '3 playdates', 'for 1 week',Colors.red[300]),
                cardView('Rs 500', 'Unlimited Playdates', 'for 1 month',AppColors.colore6e6e6,),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                cardView('Rs 1500', 'Unlimited playdates', 'for 3 months',AppColors.color16499f),
                cardView('Rs 5000', 'unlimited playdates', 'for 1 year',AppColors.colorfbaf43),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            TextFormField(
              decoration: TextStyles.textInputDecoration.copyWith(hintText: 'Have a coupon?'),
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
      bottomSheet: BottomNav(textName: "Get Started",bgColor:AppColors.coloref4138,onNavHit: (){
        print('Hello Pragnesh');
      },)
    );
  }
}
