import 'package:flutter/material.dart';
import 'package:flutter_kid_socio_app/models/child.dart';
import 'package:flutter_kid_socio_app/shared/action_button.dart';
import 'package:flutter_kid_socio_app/shared/colors.dart';
import 'package:flutter_kid_socio_app/shared/styles.dart';

class ReschedulePanel extends StatefulWidget {
  final Child child;

  ReschedulePanel({this.child});

  @override
  _ReschedulePanelState createState() => _ReschedulePanelState();
}

class _ReschedulePanelState extends State<ReschedulePanel> {
  TimeOfDay selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Reschedule',style: AppStyles.blackTextBold16,),
          Expanded(
              flex: 1,
              child: Row(
                children: [
                  _time('${selectedTime.hour}:${selectedTime.minute}'),
                  SizedBox(width: 8.0,),
                  Text('to',style: AppStyles.blackTextRegular16,),
                  SizedBox(width: 8.0,),
                  _time('${selectedTime.hour}:${selectedTime.minute}'),
                ],
              ),
          ),
      ActionButtonView(
        btnName: "Accept",
        onBtnHit: (){
          Navigator.pop(context);
        },
        buttonStyle: AppStyles.stylePinkButton,
      ),
        ],
      ),
    );
  }

  _time(String time) {
    return GestureDetector(
      onTap: (){
        _selectTime(context);
        setState(() {
          time = '${selectedTime.hour}:${selectedTime.minute}';
        });
      },
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: AppColors.colorC4C4C4,
          borderRadius: BorderRadius.all(Radius.circular(18)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(time,style: AppStyles.blackTextRegular16,),
        ),
      ),
    );
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay pickedTime = await showTimePicker(
        context: context,
        initialTime: selectedTime, builder: (BuildContext context, Widget child) {
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
        child: child,
      );});

    if (pickedTime != null && pickedTime != selectedTime )
      setState(() {
        selectedTime = pickedTime;
      });
  }
}
