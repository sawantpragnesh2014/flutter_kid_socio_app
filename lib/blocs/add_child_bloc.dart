import 'dart:async';

import 'package:flutter_kid_socio_app/models/child.dart';
import 'package:flutter_kid_socio_app/models/child_hobbies.dart';
import 'package:flutter_kid_socio_app/models/child_timings.dart';
import 'package:flutter_kid_socio_app/repositories/child_repository.dart';
import 'package:flutter_kid_socio_app/services/api_response.dart';

import 'bloc.dart';

class AddChildBloc extends Bloc{

  late int _childId;

  late String _firstName;
  late String _lastName;
  late String _schoolName;
  late String _gender;
  late String _dob;
  late String _photoUrl;
  late List<String> hobbies;
  late List<ChildTimings> finalscheduleDaysList;
  late List<ChildHobbies> _selectedHobbiesList;

  late ChildRepository childRepository;

 late StreamController childViewController;
  Stream get childViewStream => childViewController.stream;

  StreamSink get childViewSink => childViewController.sink;
  late StreamController<ApiResponse<List<ChildHobbies>>> childInterestsController;


  Stream<ApiResponse<List<ChildHobbies>>> get childInterestsStream => childInterestsController.stream;

  StreamSink<ApiResponse<List<ChildHobbies>>> get childInterestsSink => childInterestsController.sink;

  AddChildBloc(){
    print('AddChildBloc called');
    childInterestsController = StreamController<ApiResponse<List<ChildHobbies>>>.broadcast();
     childViewController = StreamController<Type>.broadcast();
    childRepository = ChildRepository();
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

  set selectedHobbiesList(List<ChildHobbies> value) {
    _selectedHobbiesList = value;
  }

  Future<Child?> addChild(int parentId) async {
    try {
      Child child = Child(firstName: _firstName,
          lastName: _lastName,
          parentId: parentId,
          dob: _dob,
          schoolName: _schoolName,
          photoUrl: _photoUrl,
          gender: _gender);
      return childRepository.createChild(child);
    } catch(e){
      print(e);
      childViewSink.add(Type.FORM);
      return null;
    }
    /*getAllChildren();*/

  }

  Future<void> addChildHobbies() async {
    List<int> hobbiesId = fetchHobbiesId();
    String hobbiesName = fetchHobbiesName();
    ChildHobbiesDto childHobbiesDto = ChildHobbiesDto(childId: _childId,hobbies: hobbiesId,hobbiesName: hobbiesName);

    try {
      return childRepository.createChildHobbies(childHobbiesDto);
    } catch(e){
      print(e);
      return null;
    }

  }

  Future<void> addChildTimings() async {
    try {
      return childRepository.createChildTimings(finalscheduleDaysList);
    } catch(e){
      print(e);
    }
  }

  List<int> fetchHobbiesId() {
    List<int> hobbiesIdList = [];
    for(int i = 0; i < _selectedHobbiesList.length; i++){
      hobbiesIdList.add(_selectedHobbiesList[i].id);
    }

    return hobbiesIdList;
  }

  String fetchHobbiesName() {
    String hobbiesName = '';
    for(int i = 0; i < _selectedHobbiesList.length; i++){
      hobbiesName +=  (_selectedHobbiesList[i].name +',');
    }
    return hobbiesName;
  }

  set dob(String value) {
    _dob = value;
  }

  set gender(String value) {
    _gender = value;
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

  set childId(int value) {
    _childId = value;
  }

  int get childId => _childId;

  @override
  void dispose() {
    childViewController.close();
    childInterestsController.close();
  }

  open(){
    childViewController = StreamController<Type>.broadcast();
  }

  void setChildIdInFinalScheduleDaysList() {
    for(int i = 0; i < finalscheduleDaysList.length; i++){
      finalscheduleDaysList[i].childId = _childId;
    }
  }
}

enum Type{
  FORM,
  INTEREST,
  PROFILE,
  SCHEDULE,
  LOADING
}