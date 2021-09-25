import 'dart:async';

import 'package:flutter_kid_socio_app/models/child.dart';
import 'package:flutter_kid_socio_app/repositories/child_repository.dart';

import 'bloc.dart';

class ChildBloc extends Bloc{

  String _firstName;
  String _lastName;
  String _schoolName;
  String _email;
  String _gender;
  String _dob;
  String _photoUrl;

final ChildRepository childRepository = ChildRepository();

StreamController childController = StreamController<List<Child>>.broadcast();

Stream get childListStream => childController.stream;

  List<Child> childList = [];

  void addChild(){
    Child child = Child(name: _firstName,dob: _dob,schoolName: _schoolName,photoUrl: _photoUrl,gender: _gender);
    childList.add(child);
    /*childList.add(child);
    childList.add(child);
    childList.add(child);*/
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

  set dob(String value) {
    _dob = value;
  }

  set gender(String value) {
    _gender = value;
  }

  set email(String value) {
    _email = value;
  }

  set schoolName(String value) {
    _schoolName = value;
  }

  set lastName(String value) {
    _lastName = value;
  }

  set firstName(String value) {
    _firstName = value;
  }

  set photoUrl(String value) {
    _photoUrl = value;
  }
}