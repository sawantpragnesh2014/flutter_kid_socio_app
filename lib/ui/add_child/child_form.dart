import 'package:flutter/material.dart';
import 'package:flutter_kid_socio_app/blocs/bloc_provider.dart';
import 'package:flutter_kid_socio_app/blocs/child_bloc.dart';
import 'package:flutter_kid_socio_app/shared/action_button.dart';
import 'package:flutter_kid_socio_app/shared/form_validators.dart';
import 'package:flutter_kid_socio_app/shared/gender_view.dart';
import 'package:flutter_kid_socio_app/shared/styles.dart';

class ChildForm extends StatefulWidget {
  final VoidCallback callback;

  ChildForm({this.callback});

  @override
  _ChildFormState createState() => _ChildFormState();
}

class _ChildFormState extends State<ChildForm> {
  final formKey = GlobalKey<FormState>();
  TextEditingController dateCtl = TextEditingController();
  DateTime currentDate = DateTime.now();

  ChildBloc _childBloc;

  Widget get _firstName {
    return TextFormField(
      decoration: TextStyles.textInputDecoration.copyWith(hintText: 'First Name'),
      validator: (val) => FormValidators.validateName(val),
      onChanged: (val){
        setState(() {
          _childBloc.firstName = val;
        });
      },
    );
  }

  Widget get _lastName {
    return TextFormField(
      decoration: TextStyles.textInputDecoration.copyWith(hintText: 'Last Name'),
      validator: (val) => FormValidators.validateName(val),
      onChanged: (val){
        setState(() {
          _childBloc.lastName = val;
        });
      },
    );
  }

  Widget get _dob {
    return InkWell(
      onTap: () async {
        await _selectDate(context);
        dateCtl.text =  '${currentDate.day}/${currentDate.month}/${currentDate.year}';
      },
      child: IgnorePointer(
        child: TextFormField(
          controller: dateCtl,
          decoration: TextStyles.textInputDecoration.copyWith(hintText: 'Date of birth',suffixIcon: Icon(Icons.calendar_today_sharp),),
          validator: (val) => FormValidators.validateDob(val),
          onChanged: (val){
            setState(() {
              _childBloc.dob = val;
            });
          },
        ),
      ),
    );
  }

  Widget get _schoolName {
    return TextFormField(
      decoration: TextStyles.textInputDecoration.copyWith(hintText: 'School'),
      validator: (val) => FormValidators.validateName(val),
      onChanged: (val){
        setState(() {
          _childBloc.schoolName = val;
        });
      },
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(2005),
        lastDate: DateTime.now());

    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
        /*dob = currentDate.toString();
        dateCtl.text = currentDate.toIso8601String();*/
      });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _childBloc = CustomBlocProvider.getBloc<ChildBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: SingleChildScrollView(
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                    'Enter Kid\'s details',
                    style: TextStyles.blackTextBoldSmall
                ),
                SizedBox(height: 24.0,),
                _firstName,
                SizedBox(height: 24.0,),
                _lastName,
                SizedBox(height: 24.0,),
                _dob,
                SizedBox(height: 24.0,),
                _schoolName,
                SizedBox(height: 24.0,),
                GenderView(callback: (value){
                  print('gender is $value');
                  return _childBloc.gender = value;
                },),
                SizedBox(height: 24.0,),
                ActionButtonView(btnName: "Continue",onBtnHit: (){
                  if (formKey.currentState.validate()) {
                    // CustomBlocProvider.getBloc<AddChildBloc>().childListSink.add(Type.INTEREST);
                    widget.callback();
                  }
                },buttonStyle: TextStyles.stylePinkButton,),
              ],
            )
        )
    );
  }
}


