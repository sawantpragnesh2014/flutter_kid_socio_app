import 'package:flutter/material.dart';
import 'package:flutter_kid_socio_app/models/child.dart';
import 'package:flutter_kid_socio_app/shared/action_button.dart';
import 'package:flutter_kid_socio_app/shared/app_bar.dart';
import 'package:flutter_kid_socio_app/shared/child_info.dart';
import 'package:flutter_kid_socio_app/shared/styles.dart';
import 'package:flutter_kid_socio_app/ui/add_child/interest_view.dart';
import 'package:flutter_kid_socio_app/ui/searchplaydate/nearby_playdates.dart';

class Preference extends StatefulWidget {
  final Child child;
  final List<Child> nearbyPlayDateList;

  Preference({this.child,this.nearbyPlayDateList});

  @override
  _PreferenceState createState() => _PreferenceState();
}

class _PreferenceState extends State<Preference> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBarView(height: 150.0,),
      body: Padding(
        padding: AppStyles.getPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 1,
              child: ChildInfo(child: widget.child,),
            ),
            SizedBox(height: 12.0,),
            Text('Preference',style: AppStyles.blackTextBold18,),
            SizedBox(height: 12.0,),
            Expanded(
                flex: 2,
                child: SingleChildScrollView(child: InterestView())
            ),
            SizedBox(height: 12.0,),
            ActionButtonView(
              btnName: "Done",
              onBtnHit: (){
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => NearbyPlayDates(child: widget.child, nearbyPlayDatesList: widget.nearbyPlayDateList,)));
              },
              buttonStyle: AppStyles.stylePinkButton,
            ),
          ]
        )
      ),

    );
  }
}
