import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_kid_socio_app/models/child.dart';
import 'package:flutter_kid_socio_app/models/child_timings.dart';
import 'package:flutter_kid_socio_app/shared/action_button.dart';
import 'package:flutter_kid_socio_app/shared/colors.dart';
import 'package:flutter_kid_socio_app/shared/form_validators.dart';
import 'package:flutter_kid_socio_app/shared/styles.dart';
import 'package:flutter_kid_socio_app/utils/time_utils.dart';

typedef StringValue = void Function(String);

class AddSchedule extends StatefulWidget {
  final StringValue onActionBtnHit;
  final Child child;

  AddSchedule({this.onActionBtnHit,this.child});

  @override
  _AddScheduleState createState() => _AddScheduleState();
}

class _AddScheduleState extends State<AddSchedule> {

  List<ChildTimings> scheduleDaysList;
  List<ChildTimings> finalscheduleDaysList;
  Map<String,ChildTimings> timeMap;

  bool _agree = true;
  int _value = 10;
  /*TimeOfDay selectedTime = TimeOfDay.now();*/
  TimeOfDay initialTime;


  // DateTime currentDate = DateTime.now();

  get _listSchedules {
    return Container(
      height: 400,
      child: ListView.builder(
          itemCount: scheduleDaysList.length,
          itemBuilder: (context,index){
            return scheduleDaysListView(scheduleDaysList[index]);
          }),
    );
  }

  Future<TimeOfDay> _selectTime(BuildContext context) async {
    final TimeOfDay pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(), builder: (BuildContext context, Widget child) {
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
        child: child,
      );});

      pickedTime.replacing(hour: pickedTime.hourOfPeriod);

      return pickedTime;
  }

  scheduleDaysListView(ChildTimings childTimings) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0,16.0,0,0),
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: InkWell(
                  onTap: (){
                    setState(() {
                      childTimings.isSelected = !childTimings.isSelected;
                    });
                  },
                  child: Text(childTimings.day,style: childTimings.isSelected ? AppStyles.redTextBold18 : AppStyles.blackTextBold18,))
          ),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Expanded(flex: 1,child: _fromTime(childTimings)),
                SizedBox(width: 8.0,),
                Text('to',style: AppStyles.blackTextRegular16,),
                SizedBox(width: 8.0,),
                Expanded(flex:1,child: _toTime(childTimings)),
              ],
            ),
          )
        ],
      ),
    );
  }

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

  Widget get _useSavedAddressCheckBox {
    return FormField<bool>(
      initialValue: _agree,
      builder: (FormFieldState<bool> state) {
        return Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Checkbox(
                  value: state.value,
                  onChanged: (bool val) => setState(() {
                    _agree = val;
                    state.didChange(val);
                  }),
                  activeColor: AppColors.color7059E1,
                  checkColor: Colors.white,
                ),
                Text('Use saved address',style: AppStyles.blackTextMedium14,)
              ],
            ),
            state.errorText == null
                ? Text("") : Text(state.errorText, style: TextStyle(color: Colors.red)),
          ],
        );
      },
      // 7
      validator: (val) => _validateTerms(_agree),
    );
  }

  String _validateTerms(bool agree) {
    return agree?null:"You must agree before proceeding";
  }

  get _addressPicker {
    return TextFormField(
      /*initialValue: user?.firstName,*/
      decoration: AppStyles.textInputDecoration.copyWith(hintText: 'Address',prefixIcon: Icon(Icons.gps_fixed)),
      validator: (val) => FormValidators.validateName(val),
      onChanged: (val){
        setState(() {
          // _loginBloc.firstName = val;
        });
      },
    );
  }

  get _slider {
    return Slider(
      value: _value.toDouble(),
      min: 0.0,
      max: 90.0,
      divisions: 9,
      activeColor: AppColors.colorFFC138,
      inactiveColor: AppColors.colorC4C4C4,
      label: '$_value km',
      onChanged: (val) {
        setState(() {
          _value = val.round();
          print('addres val is $_value');
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();
    DateTime newDate = DateTime.now();
    DateTime formatedDate = newDate.subtract(Duration(hours: newDate.hour, minutes: newDate.minute, seconds: newDate.second, milliseconds: newDate.millisecond, microseconds: newDate.microsecond));
    initialTime = TimeOfDay.fromDateTime(formatedDate);

    scheduleDaysList = [
      ChildTimings(childId: widget.child.id,day: 'Monday',fromTime: initialTime,toTime: initialTime),
      ChildTimings(childId: widget.child.id,day: 'Tuesday',fromTime: initialTime,toTime: initialTime),
      ChildTimings(childId: widget.child.id,day: 'Wednesday',fromTime: initialTime,toTime: initialTime),
      ChildTimings(childId: widget.child.id,day: 'Thursday',fromTime: initialTime,toTime: initialTime),
      ChildTimings(childId: widget.child.id,day: 'Friday',fromTime: initialTime,toTime: initialTime),
      ChildTimings(childId: widget.child.id,day: 'Saturday',fromTime: initialTime,toTime: initialTime),
      ChildTimings(childId: widget.child.id,day: 'Sunday',fromTime: initialTime,toTime: initialTime)
    ];

    /*timeMap = {
      'Monday': ChildTimings(childId: widget.child.id,day: 'Monday',fromTime: initialTime,toTime: initialTime),
      'Tuesday': ChildTimings(childId: widget.child.id,day: 'Tuesday',fromTime: initialTime,toTime: initialTime),
      'Wednesday': ChildTimings(childId: widget.child.id,day: 'Wednesday',fromTime: initialTime,toTime: initialTime),
      'Thursday': ChildTimings(childId: widget.child.id,day: 'Thursday',fromTime: initialTime,toTime: initialTime),
      'Friday': ChildTimings(childId: widget.child.id,day: 'Friday',fromTime: initialTime,toTime: initialTime),
      'Saturday': ChildTimings(childId: widget.child.id,day: 'Saturday',fromTime: initialTime,toTime: initialTime),
      'Sunday': ChildTimings(childId: widget.child.id,day: 'Sunday',fromTime: initialTime,toTime: initialTime),
    };*/
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
                'Schedule',
                style: AppStyles.blackTextBold16
            ),
            SizedBox(height: 24.0,),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                      'Day',
                      style: AppStyles.blackTextRegular16
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                      'Time',
                      style: AppStyles.blackTextRegular16
                  ),
                ),
              ],
            ),
            _listSchedules,
            Text(
                'Preferred Area',
                style: AppStyles.blackTextRegular16
            ),
            _useSavedAddressCheckBox,
            _addressPicker,
            SizedBox(height:8.0),
            Text(
                'Visible in',
                style: AppStyles.blackTextRegular16
            ),
            _slider,
            SizedBox(height:8.0),
            ActionButtonView(
              btnName: 'Continue',
              onBtnHit: (){
                widget.onActionBtnHit('');
                finalscheduleDaysList = scheduleDaysList.where((i) => i.isSelected).toList();
                print('finalscheduleDaysList is $finalscheduleDaysList');
              },
              buttonStyle: AppStyles.stylePinkButton,
            ),
            SizedBox(height:30.0),
          ],
        )
    );
  }

}
