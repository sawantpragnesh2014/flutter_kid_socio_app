import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_kid_socio_app/blocs/add_child_bloc.dart';
import 'package:flutter_kid_socio_app/blocs/auth_bloc.dart';
import 'package:flutter_kid_socio_app/blocs/bloc_provider.dart';
import 'package:flutter_kid_socio_app/blocs/child_bloc.dart';
import 'package:flutter_kid_socio_app/models/child.dart';
import 'package:flutter_kid_socio_app/models/parent.dart';
import 'package:flutter_kid_socio_app/shared/action_button.dart';
import 'package:flutter_kid_socio_app/shared/add_pic.dart';
import 'package:flutter_kid_socio_app/ui/login/add_profile_pic.dart';
import 'package:flutter_kid_socio_app/shared/app_bar.dart';
import 'package:flutter_kid_socio_app/shared/styles.dart';
import 'package:flutter_kid_socio_app/ui/add_child/add_schedule.dart';
import 'package:flutter_kid_socio_app/ui/add_child/child_form.dart';
import 'package:flutter_kid_socio_app/ui/add_child/interest_view.dart';

class AddChild extends StatefulWidget {
  @override
  _AddChildState createState() => _AddChildState();

}

class _AddChildState extends State<AddChild> {
  Parent user;
  ChildBloc _childBloc;
  TextEditingController dateCtl = TextEditingController();

  Widget _addChildView(Type type){
    print('type is $type');
    switch(type){
      case Type.FORM:
        return _childForm;
      case Type.INTEREST:
        return _interests;
      case Type.PROFILE:
        return _addProfilePic;
      case Type.SCHEDULE:
        return _addSchedule;
      default:
        return Container();
    }
  }

  Widget get _addSchedule {
   return AddSchedule(onActionBtnHit: (val){
     _childBloc.addChild();
     Navigator.pop(context);
   },);
  }


  Widget get _childForm{
    return ChildForm(callback: (){
      print('Form callback');
      CustomBlocProvider.getBloc<AddChildBloc>().childListSink.add(Type.PROFILE);
    },);
  }

  Widget get _interests{
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
              'Enter your child\'s interests',
              style: TextStyles.kSubTitleStyle
          ),
          SizedBox(height: 20.0,),
          InterestView(),
          SizedBox(height: 20.0,),
          ActionButtonView(btnName: "Continue",onBtnHit: (){
            CustomBlocProvider.getBloc<AddChildBloc>().childListSink.add(Type.SCHEDULE);
          },buttonStyle: TextStyles.stylePinkButton,),
          SizedBox(height: 30.0,),
        ],
      ),
    );
  }

  Widget get _addProfilePic{
    return AddPic(btnStyle: TextStyles.stylePinkButton,onActionBtnHit: (val){
      _childBloc.photoUrl = val;
      CustomBlocProvider.getBloc<AddChildBloc>().childListSink.add(Type.INTEREST);
    },);
  }

  @override
  void initState() {
    super.initState();
    CustomBlocProvider.setBloc(AddChildBloc());
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    user = CustomBlocProvider.getBloc<AuthBloc>().getUser;
    _childBloc = CustomBlocProvider.getBloc<ChildBloc>();
  }

  @override
  Widget build(BuildContext context) {
    print('hello');
    return StreamBuilder(
      initialData: Type.FORM,
      stream: CustomBlocProvider.getBloc<AddChildBloc>().childListStream,
      builder: (context, snapshot) {
        Type type = snapshot.data;
        return SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBarView(height: 150.0),
            body: Padding(
              padding: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 0.0),
              child: _addChildView(type),
            )
          ),
        );
      }
    );
  }

  @override
  void dispose() {
    super.dispose();
    CustomBlocProvider.getBloc<AddChildBloc>().dispose();
  }

}
