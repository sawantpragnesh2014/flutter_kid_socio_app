import 'package:flutter/material.dart';
import 'package:flutter_kid_socio_app/blocs/auth_bloc.dart';
import 'package:flutter_kid_socio_app/blocs/bloc_provider.dart';
import 'package:flutter_kid_socio_app/blocs/child_bloc.dart';
import 'package:flutter_kid_socio_app/models/child.dart';
import 'package:flutter_kid_socio_app/models/parent.dart';
import 'package:flutter_kid_socio_app/services/api_response.dart';
import 'package:flutter_kid_socio_app/shared/app_bar.dart';
import 'package:flutter_kid_socio_app/shared/error_page.dart';
import 'package:flutter_kid_socio_app/shared/loading.dart';
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
    CustomBlocProvider.getBloc<ChildBloc>().getAllChildren(CustomBlocProvider.getBloc<AuthBloc>().getUser.id ?? 0);
  }

  @override
  void dispose() {
    super.dispose();
    CustomBlocProvider.getBloc<ChildBloc>().dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ApiResponse<List<Child>>>(
        stream: CustomBlocProvider.getBloc<ChildBloc>().childListStream,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            switch(snapshot.data.status){
              case Status.LOADING:
                return Loading();
                break;
              case Status.COMPLETED:
                print('child list is ${snapshot.data.data}');
                List<Child> childList = snapshot.data.data ?? [];
                return SafeArea(
                  child: Scaffold(
                    resizeToAvoidBottomInset: false,
                    appBar: AppBarView(height: 150.0,),
                    body: childList.isEmpty? DashboardEmpty():Dashboard(childList: childList,),
                  ),
                );
                break;
              case Status.ERROR:
                return ErrorPage(
                  errorMessage: snapshot.data.message,
                  onRetryPressed: () => CustomBlocProvider.getBloc<ChildBloc>().getAllChildren(CustomBlocProvider.getBloc<AuthBloc>().getUser.id ?? 0),
                );
                break;
            }
          }
          return Loading();
        }
    );
  }
}
