import 'package:flutter/material.dart';
import 'package:flutter_kid_socio_app/blocs/add_child_bloc.dart';
import 'package:flutter_kid_socio_app/blocs/bloc_provider.dart';
import 'package:flutter_kid_socio_app/blocs/preference_bloc.dart';
import 'package:flutter_kid_socio_app/models/child.dart';
import 'package:flutter_kid_socio_app/models/child_hobbies.dart';
import 'package:flutter_kid_socio_app/services/api_response.dart';
import 'package:flutter_kid_socio_app/shared/action_button.dart';
import 'package:flutter_kid_socio_app/shared/app_bar.dart';
import 'package:flutter_kid_socio_app/shared/child_info.dart';
import 'package:flutter_kid_socio_app/shared/error_page.dart';
import 'package:flutter_kid_socio_app/shared/hobbies_list_view.dart';
import 'package:flutter_kid_socio_app/shared/loading.dart';
import 'package:flutter_kid_socio_app/shared/styles.dart';
import 'package:flutter_kid_socio_app/ui/add_child/interest_view.dart';
import 'package:flutter_kid_socio_app/ui/searchplaydate/nearby_playdates.dart';

class Preference extends StatefulWidget {
  final Child child;
  final List<Child> nearbyPlayDateList;
  List<ChildHobbies> childHobbiesList;

  Preference({this.child, this.nearbyPlayDateList});

  @override
  _PreferenceState createState() => _PreferenceState();
}

class _PreferenceState extends State<Preference> {
  PreferenceBloc _preferenceBloc;
  List<ChildHobbies> childHobbiesList;

  @override
  void initState() {
    super.initState();
    CustomBlocProvider.setBloc(PreferenceBloc());
    _preferenceBloc = CustomBlocProvider.getBloc<PreferenceBloc>();
    _preferenceBloc.fetchChildHobbiesMaster();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBarView(height: 150.0,),
    body: Padding(
    padding: AppStyles.getPadding,
    child: StreamBuilder<ApiResponse<List<ChildHobbies>>>(
    stream: _preferenceBloc.childInterestsStream,
    builder: (context, snapshot) {
      print('Hobbies master stream called');
      if (snapshot.hasData) {
        switch (snapshot.data.status) {
          case Status.LOADING:
            return Loading();
            break;
          case Status.COMPLETED:
            childHobbiesList = snapshot.data.data ?? [];
            return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 1,
                    child: ChildInfo(child: widget.child,),
                  ),
                  SizedBox(height: 12.0,),
                  Text('Preference', style: AppStyles.blackTextBold18,),
                  SizedBox(height: 12.0,),
                  Expanded(
                      flex: 2,
                      child: SingleChildScrollView(
                          child: HobbiesListView(
                            childHobbiesList: childHobbiesList,
                          )
                      )
                  ),
                  SizedBox(height: 12.0,),
                  ActionButtonView(
                    btnName: "Done",
                    onBtnHit: () {
                      Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (context) =>
                          NearbyPlayDates(child: widget.child,
                            nearbyPlayDatesList: widget.nearbyPlayDateList,)));
                    },
                    buttonStyle: AppStyles.stylePinkButton,
                  ),
                ]
            );
            break;
          case Status.ERROR:
            return ErrorPage(
              errorMessage: snapshot.data.message,
              onRetryPressed: () => _preferenceBloc.fetchChildHobbiesMaster(),
            );
            break;
        }
      }
      return Loading();
    }),

    ));
    }

@override
  void dispose() {
    super.dispose();
    _preferenceBloc.dispose();
  }
  }
