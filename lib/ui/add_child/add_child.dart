import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_kid_socio_app/blocs/add_child_bloc.dart';
import 'package:flutter_kid_socio_app/blocs/auth_bloc.dart';
import 'package:flutter_kid_socio_app/blocs/bloc_provider.dart';
import 'package:flutter_kid_socio_app/blocs/child_bloc.dart';
import 'package:flutter_kid_socio_app/blocs/login_bloc.dart';
import 'package:flutter_kid_socio_app/models/child.dart';
import 'package:flutter_kid_socio_app/models/parent.dart';
import 'package:flutter_kid_socio_app/shared/action_button.dart';
import 'package:flutter_kid_socio_app/shared/add_pic.dart';
import 'package:flutter_kid_socio_app/shared/loading.dart';
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
  Parent? user;
  late ChildBloc? _childBloc;
  late AddChildBloc? _addChildBloc;
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
      case Type.LOADING:
        return Loading();
      default:
        return Container();
    }
  }

  Widget get _addSchedule {
   return AddSchedule(onActionBtnHit: (val) async {
     _addChildBloc!.finalscheduleDaysList = val;

     _addChildBloc!.childViewSink.add(Type.LOADING);

     Child? child = await _addChildBloc!.addChild(CustomBlocProvider.getBloc<LoginBloc>()!.parent!.id);
      print('Child inserted ${child!.id}');
      _addChildBloc!.childId = child.id;
     _addChildBloc!.setChildIdInFinalScheduleDaysList();

     await _addChildBloc!.addChildHobbies();
     await _addChildBloc!.addChildTimings();

     _childBloc!.getAllChildren(CustomBlocProvider.getBloc<LoginBloc>()!.parent!.id);
     Navigator.pop(context);
   });
  }

  Widget get _interests{
    return InterestView(callback: (val){
      _addChildBloc!.selectedHobbiesList = val;
       _addChildBloc!.childViewSink.add(Type.SCHEDULE);
    },);
  }

  Widget get _childForm{
    return ChildForm(callback: () async {
      print('Form callback');
      _addChildBloc!.childViewSink.add(Type.PROFILE);
    },);
  }

  Widget get _addProfilePic{
    return AddPic(btnStyle: AppStyles.stylePinkButton,onActionBtnHit: (val){
      print('child bloc $_addChildBloc');
      /*_addChildBloc!.photoUrl = val;*/
      _addChildBloc!.childViewSink.add(Type.INTEREST);
    },);
  }

  @override
  void initState() {
    super.initState();
    CustomBlocProvider.setBloc(AddChildBloc());
    _childBloc = CustomBlocProvider.getBloc<ChildBloc>();
    _addChildBloc = CustomBlocProvider.getBloc<AddChildBloc>();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    user = CustomBlocProvider.getBloc<LoginBloc>()!.parent;
  }

  @override
  Widget build(BuildContext context) {
    print('hello');
    return StreamBuilder(
      initialData: Type.FORM,
      stream: _addChildBloc!.childViewStream,
      builder: (context, snapshot) {
        Type type = snapshot.data as Type;
        return SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBarView(height: 130.0),
            body: Padding(
              padding: AppStyles.getPadding,
              child: _addChildView(type),
            )
          ),
        );
      }
    );
  }

  @override
  void dispose() {
    print('Dispose called');
    super.dispose();
    _addChildBloc!.dispose();
  }

}
