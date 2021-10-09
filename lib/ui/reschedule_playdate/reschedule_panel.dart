import 'package:flutter/material.dart';
import 'package:flutter_kid_socio_app/models/child.dart';
import 'package:flutter_kid_socio_app/models/child_timings.dart';
import 'package:flutter_kid_socio_app/shared/action_button.dart';
import 'package:flutter_kid_socio_app/shared/colors.dart';
import 'package:flutter_kid_socio_app/shared/styles.dart';
import 'package:flutter_kid_socio_app/utils/time_utils.dart';

class ReschedulePanel extends StatefulWidget {
  final Child child;

  ReschedulePanel({this.child});

  @override
  _ReschedulePanelState createState() => _ReschedulePanelState();
}

class _ReschedulePanelState extends State<ReschedulePanel> {
  TimeOfDay initialTime;
  int initialTimeSpan;
  ChildTimings childTimings;

  @override
  void initState() {
    super.initState();
    DateTime newDate = DateTime.now();
    DateTime formatedDate = newDate.subtract(Duration(hours: newDate.hour, minutes: newDate.minute, seconds: newDate.second, milliseconds: newDate.millisecond, microseconds: newDate.microsecond));
    initialTime = TimeOfDay.fromDateTime(formatedDate);

    initialTimeSpan = /*TimeSpan(totalMilliseconds: (*/formatedDate.millisecondsSinceEpoch /** 1000).toDouble())*/;

    childTimings = ChildTimings(childId: 0,day: 'Monday',fromTime: initialTimeSpan,toTime: initialTimeSpan);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Reschedule',style: AppStyles.blackTextBold16,),
          SizedBox(height: 8.0,),
          Row(
            children: [
              Expanded(flex: 1,child: _fromTime(childTimings)),
              SizedBox(width: 8.0,),
              Text('to',style: AppStyles.blackTextRegular16,),
              SizedBox(width: 8.0,),
              Expanded(flex:1,child: _toTime(childTimings)),
            ],
          ),
          SizedBox(height: 8.0,),
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

  /*_time(String time) {
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
  }*/

  Widget _fromTime(ChildTimings childTimings) {
    return GestureDetector(
      onTap: () async{
        childTimings.fromTime = await _selectTime(context);
        print('time is ${childTimings.fromTime}');
        setState(() {
        });
      },
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: AppColors.colorC4C4C4,
          borderRadius: BorderRadius.all(Radius.circular(18)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(TimeUtils.getDisplayTime(childTimings.fromTime),style: AppStyles.blackTextRegular16,textAlign: TextAlign.center,),
        ),
      ),
    );
  }

  Widget _toTime(ChildTimings childTimings) {
    return GestureDetector(
      onTap: () async{
        childTimings.toTime = await _selectTime(context);
        print('time is ${childTimings.toTime}');
        setState(() {
        });
      },
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: AppColors.colorC4C4C4,
          borderRadius: BorderRadius.all(Radius.circular(18)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(TimeUtils.getDisplayTime(childTimings.toTime),style: AppStyles.blackTextRegular16,textAlign: TextAlign.center,),
        ),
      ),
    );
  }

  Future<int> _selectTime(BuildContext context) async {
    final TimeOfDay pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(), builder: (BuildContext context, Widget child) {
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
        child: child,
      );});

    pickedTime.replacing(hour: pickedTime.hourOfPeriod);

    final now = new DateTime.now();
    DateTime dateTime = DateTime(now.year, now.month, now.day, pickedTime.hour, pickedTime.minute);


    return /*TimeSpan(totalMilliseconds: (*/dateTime.millisecondsSinceEpoch /** 1000).toDouble())*/;
  }
}
