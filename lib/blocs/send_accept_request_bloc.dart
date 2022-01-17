import 'dart:async';

import 'package:flutter_kid_socio_app/blocs/bloc.dart';
import 'package:flutter_kid_socio_app/models/nearby_playdate.dart';
import 'package:flutter_kid_socio_app/models/playdate_request.dart';
import 'package:flutter_kid_socio_app/models/send_request.dart';
import 'package:flutter_kid_socio_app/repositories/send_accept_request_repository.dart';
import 'package:flutter_kid_socio_app/services/api_response.dart';

class SendAcceptRequestBloc extends Bloc{

  late SendAcceptRequestRepository sendAcceptRequestRepository;

  static const int PENDING = 0;
  static const int ACCEPT = 1;
  static const int REJECT = 2;
  static const int RESCHEDULE = 3;

  late StreamController<ApiResponse<List<PlayDateRequest>>> outgoingRequestsController;

  Stream<ApiResponse<List<PlayDateRequest>>> get outgoingRequestsStream => outgoingRequestsController.stream;
  StreamSink<ApiResponse<List<PlayDateRequest>>> get outgoingRequestsSink => outgoingRequestsController.sink;

  SendAcceptRequestBloc(){
    sendAcceptRequestRepository = SendAcceptRequestRepository();
    outgoingRequestsController = StreamController<ApiResponse<List<PlayDateRequest>>>.broadcast();
  }

  Future<String>? sendRequest(int nearbyPlayDateId, int childId){
    try {
      return sendAcceptRequestRepository.sendRequest(SendRequest(senderId: childId,receiverId: nearbyPlayDateId,requestSummary: RequestSummary()));
    }catch(e){
      print('Error is $e');
    }
    return null;
  }

   approveRequest(int requestId, int status){
    try {
      sendAcceptRequestRepository.approveRequest(requestId,status);
    }catch(e){
      print('Error is $e');
    }
  }

  Future<List<PlayDateRequest>?>? getIncomingRequestList(int childId){
    try {
      return sendAcceptRequestRepository.getIncomingRequestList(childId);
    }catch(e){
      print('Error is $e');
    }
    return null;
  }

   getOutgoingRequestList(int childId) async {
     outgoingRequestsSink.add(ApiResponse.loading(''));
    try {
      List<PlayDateRequest>? result = await sendAcceptRequestRepository.getOutgoingRequestList(childId);
       outgoingRequestsSink.add(ApiResponse.completed(result));
    }catch(e){
      print('Error is $e');
      outgoingRequestsSink.add(ApiResponse.error(e.toString()));
    }
  }

  @override
  void dispose() {
    outgoingRequestsController.close();
  }

}