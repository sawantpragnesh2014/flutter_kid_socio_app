import 'package:flutter/material.dart';
import 'package:flutter_kid_socio_app/blocs/bloc_provider.dart';
import 'package:flutter_kid_socio_app/blocs/send_accept_request_bloc.dart';
import 'package:flutter_kid_socio_app/models/child.dart';
import 'package:flutter_kid_socio_app/models/nearby_playdate.dart';
import 'package:flutter_kid_socio_app/models/playdate_request.dart';
import 'package:flutter_kid_socio_app/shared/action_button.dart';
import 'package:flutter_kid_socio_app/shared/child_info_two.dart';
import 'package:flutter_kid_socio_app/shared/styles.dart';
import 'package:flutter_kid_socio_app/shared/time_and_hobbies.dart';
import 'package:flutter_kid_socio_app/ui/reschedule_playdate/reschedule_playdate.dart';

class SendRequestPanel extends StatefulWidget {

  final NearbyPlaydate? childAll;
  final PlayDateRequest? incomingPlayDateRequest;
  late final Child child;
  final String panelType;
  final VoidCallback? callback;

  SendRequestPanel({this.childAll,this.incomingPlayDateRequest,required this.child,required this.panelType,this.callback});

  @override
  _SendRequestPanelState createState() => _SendRequestPanelState();
}

class _SendRequestPanelState extends State<SendRequestPanel> {
  late SendAcceptRequestBloc _sendRequestBloc;

  Widget get _timeAndHobbies {
    return TimeAndHobbies(hobbiesName: (widget.panelType.contains('accept_request')? widget.incomingPlayDateRequest!.hobbiesName: widget.childAll!.hobbiesName), fromTime: '2:36 p.m',toTime: '4:36 p.m',);
  }

  Widget get _actionButtonView {
    if (widget.panelType.contains('send_request')) {
      return ActionButtonView(
        btnName: "Send Request",
        onBtnHit: () async {
          String? res = await _sendRequestBloc.sendRequest(widget.childAll!.childId, widget.child.id);
          Navigator.pop(context);
        },
      );
    } else {
      return Row(
      children: [
        Expanded(
          flex: 1,
          child: ActionButtonView(
            btnName: "Accept",
            onBtnHit: () async {
              await _sendRequestBloc.approveRequest(widget.incomingPlayDateRequest!.requestId, SendAcceptRequestBloc.ACCEPT);
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => ReschedulePlayDate(playDateRequest: widget.incomingPlayDateRequest!)));
            },
            buttonStyle: AppStyles.stylePinkButton,
          ),
        ),
        Expanded(
          flex: 1,
          child: ActionButtonView(
            btnName: "Decline",
            onBtnHit: () async {
              String? res = await _sendRequestBloc.approveRequest(widget.incomingPlayDateRequest!.requestId, SendAcceptRequestBloc.REJECT);
              /*widget.callback!();*/
              Navigator.pop(context);
            },
          ),
        )
      ],
    );
    }
  }

  @override
  void dispose() {
    super.dispose();
    _sendRequestBloc.dispose();
  }

  @override
  void initState() {
    super.initState();
    CustomBlocProvider.setBloc(SendAcceptRequestBloc());
    _sendRequestBloc = CustomBlocProvider.getBloc<SendAcceptRequestBloc>()!;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 1,
              child: ((widget.panelType.contains('accept_request'))? (ChildInfoTwo( playDateRequest : widget.incomingPlayDateRequest,)): (ChildInfoTwo(childAll: widget.childAll,)))
          ),
          Expanded(
              flex: 1,
              child: _timeAndHobbies
          ),
          SizedBox(height: 12.0),
          _actionButtonView,
        ],
      ),
    );
  }
}
