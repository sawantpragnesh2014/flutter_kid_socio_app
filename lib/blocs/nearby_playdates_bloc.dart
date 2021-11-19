import 'dart:async';

import 'package:flutter_kid_socio_app/models/child.dart';
import 'package:flutter_kid_socio_app/models/nearby_playdate.dart';
import 'package:flutter_kid_socio_app/repositories/child_repository.dart';
import 'package:flutter_kid_socio_app/services/api_response.dart';

import 'bloc.dart';

class NearbyPlaydatesBloc extends Bloc{
  late ChildRepository childRepository;

  late StreamController<ApiResponse<List<NearbyPlaydate>>?> nearbyPlaydatesController;

  Stream<ApiResponse<List<NearbyPlaydate>>?> get nearbyPlaydatesListStream => nearbyPlaydatesController.stream;

  StreamSink<ApiResponse<List<NearbyPlaydate>>?> get nearbyPlaydatesListSink => nearbyPlaydatesController.sink;

  List<NearbyPlaydate>? nearbyPlaydatesList;

  NearbyPlaydatesBloc(){
    nearbyPlaydatesController = StreamController<ApiResponse<List<NearbyPlaydate>>>.broadcast();
    childRepository = ChildRepository();
  }

  getAllChildren(int parentId, int childId) async {
    nearbyPlaydatesListSink.add(ApiResponse.loading('message'));
    try{
      nearbyPlaydatesList = await childRepository.fetchNearbyPlaydatesList(parentId.toString(),childId.toString());
      nearbyPlaydatesListSink.add(ApiResponse.completed(nearbyPlaydatesList));
    }catch(e){
      nearbyPlaydatesListSink.add(ApiResponse.error('$e'));
    }
  }

  @override
  void dispose() {
    nearbyPlaydatesController.close();
  }
}