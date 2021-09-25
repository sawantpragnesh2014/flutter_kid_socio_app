import 'package:flutter/material.dart';
import 'package:flutter_kid_socio_app/models/child.dart';
import 'package:flutter_kid_socio_app/shared/action_button.dart';
import 'package:flutter_kid_socio_app/shared/app_bar.dart';
import 'package:flutter_kid_socio_app/shared/child_info_two.dart';
import 'package:flutter_kid_socio_app/shared/colors.dart';
import 'package:flutter_kid_socio_app/shared/styles.dart';
import 'package:flutter_kid_socio_app/shared/time_and_hobbies.dart';
import 'package:flutter_kid_socio_app/ui/reschedule_playdate/reschedule_panel.dart';

class ReschedulePlayDate extends StatefulWidget {

  final Child child;

  ReschedulePlayDate({this.child});

  @override
  _ReschedulePlayDateState createState() => _ReschedulePlayDateState();
}

class _ReschedulePlayDateState extends State<ReschedulePlayDate> {
  Widget get _locationView {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Location',style: AppStyles.greenTextBold16,),
        Text('The Bombay Bronx Breach Candy, Cumballa Hill, Mumbai South, Mumbai',style: AppStyles.blackTextMedium14,),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBarView(
          height: 150.0,
        ),
        body: Padding(
            padding: AppStyles.getPadding,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 1,
                    child: ChildInfoTwo(
                      child: widget.child,
                    ),
                  ),
                  SizedBox(height: 12.0,),
                  Expanded(
                      flex:1,
                      child: TimeAndHobbies()
                  ),
                  SizedBox(height: 12.0,),
                  Expanded(
                      flex: 1,
                      child: _locationView
                  ),
                  SizedBox(height: 12.0,),
                  ActionButtonView(
                    btnName: "Reschedule",
                    onBtnHit: (){
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(height: 12.0,),
                  ActionButtonView(
                    btnName: "Cancel playdate",
                    onBtnHit: (){
                      Navigator.pop(context);
                    },
                    buttonStyle: AppStyles.stylePinkButton,
                  ),
                ]
            )
        )
    );
  }

  void showSendRequestPanel(Child child) {
    showModalBottomSheet(context: context, builder: (context){
      return Container(
        color: AppColors.colorF4F4F4,
        padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 30.0),
        child: ReschedulePanel(child: child),
      );
    });
  }
}
