import 'package:flutter/material.dart';
import 'package:flutter_kid_socio_app/blocs/add_child_bloc.dart';
import 'package:flutter_kid_socio_app/blocs/bloc_provider.dart';
import 'package:flutter_kid_socio_app/models/child_hobbies.dart';
import 'package:flutter_kid_socio_app/services/api_response.dart';
import 'package:flutter_kid_socio_app/shared/action_button.dart';
import 'package:flutter_kid_socio_app/shared/colors.dart';
import 'package:flutter_kid_socio_app/shared/error_page.dart';
import 'package:flutter_kid_socio_app/shared/hobbies_list_view.dart';
import 'package:flutter_kid_socio_app/shared/loading.dart';
import 'package:flutter_kid_socio_app/shared/styles.dart';

typedef ChildHobbiesValue = void Function(List<ChildHobbies>);

class InterestView extends StatefulWidget {
  final ChildHobbiesValue callback;

  InterestView({required this.callback});

  @override
  _InterestViewState createState() => _InterestViewState();
}

class _InterestViewState extends State<InterestView> {
  late AddChildBloc _addChildBloc;
  List<ChildHobbies>? childHobbiesList;
  List<ChildHobbies>? finalChildHobbiesList;

  @override
  void initState() {
    super.initState();
    /*interestsList.add({'name':'Football','isSelected':false});
    interestsList.add({'name':'Basketball','isSelected':false});
    interestsList.add({'name':'Cricket','isSelected':false});
    interestsList.add({'name':'Tennis','isSelected':false});
    interestsList.add({'name':'Volleyball','isSelected':false});
    interestsList.add({'name':'Table Tennis','isSelected':false});
    interestsList.add({'name':'Badminton','isSelected':false});
    interestsList.add({'name':'Swimming','isSelected':false});
    interestsList.add({'name':'Chess','isSelected':false});
    interestsList.add({'name':'Carrom','isSelected':false});
    interestsList.add({'name':'Cards','isSelected':false});
    interestsList.add({'name':'Dance','isSelected':false});
    interestsList.add({'name':'Arts and Craft','isSelected':false});
    interestsList.add({'name':'PlayArea ','isSelected':false});
    interestsList.add({'name':'Chill Out','isSelected':false});
    interestsList.add({'name':'Reading','isSelected':false});
    interestsList.add({'name':'Movies','isSelected':false});
    interestsList.add({'name':'Video Games','isSelected':false});
    interestsList.add({'name':'Music','isSelected':false});
    interestsList.add({'name':'Baby Sitting','isSelected':false});*/
    _addChildBloc = CustomBlocProvider.getBloc<AddChildBloc>()!;
    _addChildBloc.fetchChildHobbiesMaster();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ApiResponse<List<ChildHobbies>>>(
        stream: _addChildBloc.childInterestsStream,
        builder: (context, snapshot) {
          print('Hobbies master stream called');
          if(snapshot.hasData){
            switch(snapshot.data!.status){
              case Status.LOADING:
                return Loading();
                break;
              case Status.COMPLETED:
                childHobbiesList = snapshot.data!.data ?? [];
                 return Column(
                   crossAxisAlignment: CrossAxisAlignment.stretch,
                   children: [
                     Text(
                         'Enter your child\'s interests',
                         style: AppStyles.kSubTitleStyle
                     ),
                     SizedBox(height: 20.0,),
                     Expanded(
                         flex: 1,
                         child: SingleChildScrollView(
                             child: HobbiesListView(childHobbiesList: childHobbiesList,)
                         )
                     ),
                     SizedBox(height: 20.0,),
                     ActionButtonView(btnName: "Continue",onBtnHit: () async {
                       finalChildHobbiesList = childHobbiesList!.where((i) => i.isSelected).toList();
                       widget.callback(finalChildHobbiesList!);
                       print('finalChildHobbiesList is $finalChildHobbiesList');
                     },buttonStyle: AppStyles.stylePinkButton,),
                     SizedBox(height: 30.0,),
                   ],
                 );

              case Status.ERROR:
              default:
                return ErrorPage(
                  errorMessage: snapshot.data!.message ?? 'Some error occured',
                  onRetryPressed: () => _addChildBloc.fetchChildHobbiesMaster(),
                );
            }
          }
          return Loading();
    }
    );
  }
}

