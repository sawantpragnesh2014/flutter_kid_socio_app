import 'dart:async';

import 'package:flutter_kid_socio_app/blocs/bloc.dart';
import 'package:flutter_kid_socio_app/models/child.dart';
import 'package:flutter_kid_socio_app/models/nearby_playdate.dart';
import 'package:flutter_kid_socio_app/models/playdate_request.dart';
import 'package:flutter_kid_socio_app/models/send_request.dart';
import 'package:flutter_kid_socio_app/repositories/send_accept_request_repository.dart';
import 'package:flutter_kid_socio_app/services/api_response.dart';

class UpcomingPlaydateBloc extends Bloc{

  late SendAcceptRequestRepository sendAcceptRequestRepository;

  late StreamController<ApiResponse<List<Child>>> upcomingPlaydateController;

  Stream<ApiResponse<List<Child>>> get upcomingPlaydateStream => upcomingPlaydateController.stream;
  StreamSink<ApiResponse<List<Child>>> get upcomingPlaydateSink => upcomingPlaydateController.sink;

  UpcomingPlaydateBloc(){
    sendAcceptRequestRepository = SendAcceptRequestRepository();
    upcomingPlaydateController = StreamController<ApiResponse<List<Child>>>.broadcast();
  }

  getUpcomingPlayDateList(int childId) async {
    upcomingPlaydateSink.add(ApiResponse.loading(''));
    try {
      List<Child>? result = await sendAcceptRequestRepository.getUpcomingPlaydateList(childId);
      upcomingPlaydateSink.add(ApiResponse.completed(result));
    }catch(e){
      print('Error is $e');
      upcomingPlaydateSink.add(ApiResponse.error(e.toString()));
    }
  }

  @override
  void dispose() {
    upcomingPlaydateController.close();
  }

}