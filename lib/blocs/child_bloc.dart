import 'dart:async';

import 'package:flutter_kid_socio_app/models/child.dart';
import 'package:flutter_kid_socio_app/repositories/child_repository.dart';

import 'bloc.dart';

class ChildBloc extends Bloc{

final ChildRepository childRepository = ChildRepository();

StreamController childController = StreamController<List<Child>>.broadcast();

Stream get childListStream => childController.stream;

  List<Child> childList = [];

  void addChild(Child child){
    childList.add(child);
    getAllChildren();
  }

  void addChildData(Child child){

  }

getAllChildren(){
  childController.sink.add(childList);
}

  @override
  void dispose() {
    childController.close();
  }

}