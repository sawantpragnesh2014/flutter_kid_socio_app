
import 'package:flutter_kid_socio_app/utils/time_utils.dart';

class SendRequest{

  final int id;
  final int senderId;
  final int receiverId;
  final int statusId;
  final RequestSummary requestSummary;

  SendRequest({this.id = 0, required this.senderId, required this.receiverId, this.statusId = 0, required this.requestSummary});

  Map toJson() => {
        'requestId': id,
        'senderId': senderId,
        'recieverId': receiverId,
        'statusId': statusId,
        "createdDate": TimeUtils.getDateInYyyyMmDd(DateTime.now()),
        "approvalDate": TimeUtils.getDateInYyyyMmDd(DateTime.now()),
        "requestSummary": requestSummary
      };
}

class RequestSummary{

  final int id;
  final int fromTime;
  final int toTime;

  RequestSummary({this.id = 0, this.fromTime = 0, this.toTime = 0});

  Map toJson() => {
    "requestId": id,
    "requestDateAndTime": TimeUtils.getDateInYyyyMmDd(DateTime.now()),
    "fromTime": fromTime,
    "toTime": toTime
  };
}