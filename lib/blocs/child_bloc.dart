import 'dart:async';

import 'package:flutter_kid_socio_app/models/child.dart';
import 'package:flutter_kid_socio_app/models/child_hobbies.dart';
import 'package:flutter_kid_socio_app/models/child_timings.dart';
import 'package:flutter_kid_socio_app/repositories/child_repository.dart';
import 'package:flutter_kid_socio_app/services/api_response.dart';

import 'bloc.dart';

class ChildBloc extends Bloc{
late ChildRepository childRepository;

late StreamController<ApiResponse<List<Child>>?> childController;

Stream<ApiResponse<List<Child>>?> get childListStream => childController.stream;

StreamSink<ApiResponse<List<Child>>?> get childListSink => childController.sink;

List<Child>? childList;

ChildBloc(){
  childController = StreamController<ApiResponse<List<Child>>>.broadcast();
  childRepository = ChildRepository();
}

getAllChildren(int parentId) async {
  childListSink.add(ApiResponse.loading('message'));
  try{
    childList = await childRepository.fetchAllChildByParentId(parentId.toString());
    childListSink.add(ApiResponse.completed(childList));
  }catch(e){
    childListSink.add(ApiResponse.error('Error $e'));
  }
}

Future<String?> fetchChildPic(int id) async {
  try {
    await childRepository.fetchChildPic(id);
  } catch(e){
    print(e);
    return null;
  }
}

  @override
  void dispose() {
    childController.close();
  }
}