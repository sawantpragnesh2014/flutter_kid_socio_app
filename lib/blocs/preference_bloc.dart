import 'dart:async';

import 'package:flutter_kid_socio_app/models/child_hobbies.dart';
import 'package:flutter_kid_socio_app/repositories/child_repository.dart';
import 'package:flutter_kid_socio_app/services/api_response.dart';

import 'bloc.dart';

class PreferenceBloc extends Bloc{
  late StreamController<ApiResponse<List<ChildHobbies>>> childInterestsController;

  Stream<ApiResponse<List<ChildHobbies>>> get childInterestsStream => childInterestsController.stream;
  StreamSink<ApiResponse<List<ChildHobbies>>> get childInterestsSink => childInterestsController.sink;

  late ChildRepository childRepository;

  PreferenceBloc(){
    childRepository = ChildRepository();
    childInterestsController = StreamController<ApiResponse<List<ChildHobbies>>>.broadcast();
  }

  fetchChildHobbiesMaster() async{
    print('fetch hobbies master');
    childInterestsSink.add(ApiResponse.loading('Registering Parent'));
    try{
      List<ChildHobbies>? resultData = await childRepository.fetchHobbiesMaster();
      childInterestsSink.add(ApiResponse.completed(resultData));

    } catch (e) {
      childInterestsSink.add(ApiResponse.error(e.toString()));
    }
  }
  @override
  void dispose() {
    childInterestsController.close();
  }

}