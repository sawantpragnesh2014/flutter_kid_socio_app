import 'package:flutter/material.dart';
import 'package:flutter_kid_socio_app/blocs/bloc_provider.dart';
import 'package:flutter_kid_socio_app/blocs/send_accept_request_bloc.dart';
import 'package:flutter_kid_socio_app/blocs/upcoming_playdate_bloc.dart';
import 'package:flutter_kid_socio_app/models/child.dart';
import 'package:flutter_kid_socio_app/models/nearby_playdate.dart';
import 'package:flutter_kid_socio_app/models/playdate_request.dart';
import 'package:flutter_kid_socio_app/services/api_response.dart';
import 'package:flutter_kid_socio_app/shared/app_bar.dart';
import 'package:flutter_kid_socio_app/shared/error_page.dart';
import 'package:flutter_kid_socio_app/shared/loading.dart';
import 'package:flutter_kid_socio_app/shared/styles.dart';

class UpcomingPlaydateView extends StatefulWidget {

  final int childId;

  UpcomingPlaydateView({required this.childId});

  @override
  _UpcomingPlaydateViewState createState() => _UpcomingPlaydateViewState();
}

class _UpcomingPlaydateViewState extends State<UpcomingPlaydateView> {

  late UpcomingPlaydateBloc _upcomingPlaydateBloc;
  late List<Child> upcomingPlaydateList;

  @override
  void initState() {
    super.initState();
    CustomBlocProvider.setBloc(UpcomingPlaydateBloc());
    _upcomingPlaydateBloc = CustomBlocProvider.getBloc<UpcomingPlaydateBloc>()!;
    _upcomingPlaydateBloc.getUpcomingPlayDateList(widget.childId);
  }

  @override
  void dispose() {
    super.dispose();
    _upcomingPlaydateBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBarView(height: 130.0,),
        body: Padding(
          padding: AppStyles.getPadding,
          child: StreamBuilder<ApiResponse<List<Child>>>(
              stream: _upcomingPlaydateBloc.upcomingPlaydateStream,
              builder: (context, snapshot) {
                print('Hobbies master stream called');
                if (snapshot.hasData) {
                  switch (snapshot.data!.status) {
                    case Status.LOADING:
                      return Loading();
                    case Status.COMPLETED:
                      upcomingPlaydateList = snapshot.data!.data ?? [];
                      return ListView.builder(
                          itemCount: upcomingPlaydateList.length,
                          itemBuilder: (context, index) {
                            return childListView(upcomingPlaydateList[index],);
                          });
                    case Status.ERROR:
                    default:
                      return ErrorPage(
                        errorMessage: snapshot.data!.message,
                        onRetryPressed: () => _upcomingPlaydateBloc.getUpcomingPlayDateList(widget.childId),
                      );
                      break;
                  }
                }
                return Loading();
              }),

        ));
  }

  Widget childListView(Child upcomingPlaydateList) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
      child: Card(
        child: ListTile(
          onTap: () {},
          contentPadding: EdgeInsets.all(8.0),
          title: RichText(
              text: TextSpan(
                  children: [
                    TextSpan(text: '${upcomingPlaydateList.firstName}, ',
                        style: AppStyles.blackTextBold16),
                    TextSpan(
                      text: '2:36 p.m',
                      style: AppStyles.editTextStyle,),
                  ]
              )
          ),
          subtitle: Text(
            '${upcomingPlaydateList.address}', style: AppStyles.blackTextMedium11,),
          leading: CircleAvatar(
            backgroundImage: upcomingPlaydateList.photoUrl == null ? AssetImage(
                'assets/google_logo.png') : AssetImage(
                'assets/default_profile_picture.png'),
            radius: 40.0,
          ),
          trailing: Image.asset('assets/icon_msg.png', fit: BoxFit.cover),
        ),
      ),
    );
  }
}
