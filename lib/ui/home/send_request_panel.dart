import 'package:flutter/material.dart';
import 'package:flutter_kid_socio_app/models/child.dart';
import 'package:flutter_kid_socio_app/shared/action_button.dart';
import 'package:flutter_kid_socio_app/shared/child_info_two.dart';
import 'package:flutter_kid_socio_app/shared/styles.dart';
import 'package:flutter_kid_socio_app/shared/time_and_hobbies.dart';
import 'package:flutter_kid_socio_app/ui/reschedule_playdate/reschedule_playdate.dart';

class SendRequestPanel extends StatefulWidget {

  final Child child;
  final String panelType;

  SendRequestPanel({this.child,this.panelType});

  @override
  _SendRequestPanelState createState() => _SendRequestPanelState();
}

class _SendRequestPanelState extends State<SendRequestPanel> {
  Widget get _timeAndHobbies {
    return TimeAndHobbies();
  }

  Widget get _actionButtonView {
    if (widget.panelType.contains('send_request')) {
      return ActionButtonView(
        btnName: "Send Request",
        onBtnHit: (){
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
            onBtnHit: (){
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => ReschedulePlayDate(child: widget.child,)));
            },
            buttonStyle: AppStyles.stylePinkButton,
          ),
        ),
        Expanded(
          flex: 1,
          child: ActionButtonView(
            btnName: "Decline",
            onBtnHit: (){
              Navigator.pop(context);
            },
          ),
        )
      ],
    );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 1,
              child: ChildInfoTwo(child: widget.child,)
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
