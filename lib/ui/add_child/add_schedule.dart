import 'package:flutter/material.dart';
import 'package:flutter_kid_socio_app/shared/action_button.dart';
import 'package:flutter_kid_socio_app/shared/colors.dart';
import 'package:flutter_kid_socio_app/shared/form_validators.dart';
import 'package:flutter_kid_socio_app/shared/styles.dart';

typedef StringValue = void Function(String);

class AddSchedule extends StatefulWidget {
  final StringValue onActionBtnHit;

  AddSchedule({this.onActionBtnHit});

  @override
  _AddScheduleState createState() => _AddScheduleState();
}

class _AddScheduleState extends State<AddSchedule> {

  List<String> scheduleDaysList = ['Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday'];
  bool _agree = true;
  int _value = 10;
  TimeOfDay selectedTime = TimeOfDay.now();


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

  scheduleDaysListView(String day) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0,16.0,0,0),
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: Text(day,style: AppStyles.blackTextBold18,)
          ),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                _time('${selectedTime.hour}:${selectedTime.minute}'),
                SizedBox(width: 8.0,),
                Text('to',style: AppStyles.blackTextRegular16,),
                SizedBox(width: 8.0,),
                _time('${selectedTime.hour}:${selectedTime.minute}'),
              ],
            ),
          )
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
            ActionButtonView(btnName: 'Continue',onBtnHit: (){widget.onActionBtnHit('');},buttonStyle: AppStyles.stylePinkButton,),
            SizedBox(height:30.0),
          ],
        )
    );
  }
}
