import 'package:flutter/material.dart';
import 'package:flutter_kid_socio_app/blocs/bloc_provider.dart';
import 'package:flutter_kid_socio_app/blocs/send_accept_request_bloc.dart';
import 'package:flutter_kid_socio_app/models/nearby_playdate.dart';
import 'package:flutter_kid_socio_app/models/playdate_request.dart';
import 'package:flutter_kid_socio_app/services/api_response.dart';
import 'package:flutter_kid_socio_app/shared/app_bar.dart';
import 'package:flutter_kid_socio_app/shared/error_page.dart';
import 'package:flutter_kid_socio_app/shared/loading.dart';
import 'package:flutter_kid_socio_app/shared/styles.dart';

class OutgoingRequest extends StatefulWidget {

  final int childId;

  OutgoingRequest({required this.childId});

  @override
  _OutgoingRequestState createState() => _OutgoingRequestState();
}

class _OutgoingRequestState extends State<OutgoingRequest> {

  late SendAcceptRequestBloc _sendAcceptRequestBloc;
  late List<PlayDateRequest> outgoingPlayDateRequest;

  @override
  void initState() {
    super.initState();
    CustomBlocProvider.setBloc(SendAcceptRequestBloc());
    _sendAcceptRequestBloc = CustomBlocProvider.getBloc<SendAcceptRequestBloc>()!;
    _sendAcceptRequestBloc.getOutgoingRequestList(widget.childId);
  }

  @override
  void dispose() {
    super.dispose();
    _sendAcceptRequestBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBarView(height: 130.0,),
        body: Padding(
          padding: AppStyles.getPadding,
          child: StreamBuilder<ApiResponse<List<PlayDateRequest>>>(
              stream: _sendAcceptRequestBloc.outgoingRequestsStream,
              builder: (context, snapshot) {
                print('Hobbies master stream called');
                if (snapshot.hasData) {
                  switch (snapshot.data!.status) {
                    case Status.LOADING:
                      return Loading();
                    case Status.COMPLETED:
                      outgoingPlayDateRequest = snapshot.data!.data ?? [];
                      return ListView.builder(
                          itemCount: outgoingPlayDateRequest.length,
                          itemBuilder: (context, index) {
                            return childListView(outgoingPlayDateRequest[index],);
                          });
                    case Status.ERROR:
                    default:
                      return ErrorPage(
                        errorMessage: snapshot.data!.message,
                        onRetryPressed: () => _sendAcceptRequestBloc.getOutgoingRequestList(widget.childId),
                      );
                      break;
                  }
                }
                return Loading();
              }),

        ));
  }

  Widget childListView(PlayDateRequest outgoingPlayDateRequest) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
      child: Card(
        child: ListTile(
          onTap: () {},
          contentPadding: EdgeInsets.all(8.0),
          title: RichText(
              text: TextSpan(
                  children: [
                    TextSpan(text: '${outgoingPlayDateRequest.firstName}, ',
                        style: AppStyles.blackTextBold16),
                    TextSpan(
                      text: '2:36 p.m',
                      style: AppStyles.editTextStyle,),
                  ]
              )
          ),
          subtitle: Text(
            'Breach Candy, Cumbala Hill', style: AppStyles.blackTextMedium11,),
          leading: CircleAvatar(
            backgroundImage: outgoingPlayDateRequest.photoUrl == null ? AssetImage(
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
