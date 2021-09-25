import 'package:flutter/material.dart';
import 'package:flutter_kid_socio_app/blocs/auth_bloc.dart';
import 'package:flutter_kid_socio_app/blocs/bloc_provider.dart';
import 'package:flutter_kid_socio_app/blocs/child_bloc.dart';
import 'package:flutter_kid_socio_app/models/child.dart';
import 'package:flutter_kid_socio_app/models/parent.dart';
import 'package:flutter_kid_socio_app/shared/app_bar.dart';
import 'package:flutter_kid_socio_app/ui/home/dashboard.dart';
import 'package:flutter_kid_socio_app/ui/home/dashboard_empty.dart';

class HomeNew extends StatefulWidget {
  @override
  _HomeNewState createState() => _HomeNewState();
}

class _HomeNewState extends State<HomeNew> {
  Parent user;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    user = CustomBlocProvider.getBloc<AuthBloc>().getUser;
  }

  @override
  void initState() {
    super.initState();
    CustomBlocProvider.setBloc(ChildBloc());
  }

  @override
  void dispose() {
    super.dispose();
    CustomBlocProvider.getBloc<ChildBloc>().dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Child>>(
        stream: CustomBlocProvider.getBloc<ChildBloc>().childListStream,
        builder: (context, snapshot) {
          List<Child> childList = snapshot.data ?? [];
          return SafeArea(
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBarView(height: 150.0,),
              body: childList.isEmpty? DashboardEmpty():Dashboard(childList: childList,),
            ),
          );
        }
    );
  }
}
