import 'dart:async';

import 'package:flutter_kid_socio_app/models/child.dart';
import 'package:flutter_kid_socio_app/repositories/child_repository.dart';
import 'package:flutter_kid_socio_app/services/api_response.dart';

import 'bloc.dart';

class NearbyPlaydatesBloc extends Bloc{
  late ChildRepository childRepository;

  late StreamController<ApiResponse<List<Child>>?> nearbyPlaydatesController;

  Stream<ApiResponse<List<Child>>?> get nearbyPlaydatesListStream => nearbyPlaydatesController.stream;

  StreamSink<ApiResponse<List<Child>>?> get nearbyPlaydatesListSink => nearbyPlaydatesController.sink;

  List<Child>? nearbyPlaydatesList;

  NearbyPlaydatesBloc(){
    nearbyPlaydatesController = StreamController<ApiResponse<List<Child>>>.broadcast();
    childRepository = ChildRepository();
  }

  getAllChildren(int parentId) async {
    nearbyPlaydatesListSink.add(ApiResponse.loading('message'));
    try{
      nearbyPlaydatesList = await childRepository.fetchAllChildByParentId(parentId.toString());
      nearbyPlaydatesListSink.add(ApiResponse.completed(nearbyPlaydatesList));
    }catch(e){
      nearbyPlaydatesListSink.add(ApiResponse.error('Error'));
    }
  }

  @override
  void dispose() {
    nearbyPlaydatesController.close();
  }
}