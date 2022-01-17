import 'dart:async';

import 'package:flutter_kid_socio_app/blocs/bloc.dart';
import 'package:flutter_kid_socio_app/models/parent.dart';
import 'package:flutter_kid_socio_app/repositories/parent_repository.dart';
import 'package:flutter_kid_socio_app/services/api_response.dart';

class LoginBloc extends Bloc {
  late ParentRepository _parentRepository;
  late String _firstName;
  late String _lastName;
  late String _email;
  late String _gender;
  late String _phoneNo;
  String? _photoUrl;
  late String _pinCode;
  late String _addressName;
  late double _lat;
  late double _lon;
  Parent? _parent;

  late StreamController<ApiResponse<int>> _parentController;

  StreamSink<ApiResponse<int>> get parentSink =>
      _parentController.sink;

  Stream<ApiResponse<int>> get parentStream =>
      _parentController.stream;

LoginBloc(){
  _parentRepository = ParentRepository();
  /*_parentController = StreamController<ApiResponse<int>>.broadcast();*/
}

  set firstName(String value) {
    _firstName = value;
  }

  startBroadCast(){
    print('_parentController broadcast started');
    _parentController = StreamController<ApiResponse<int>>.broadcast();
  }

  createParent(Parent parent) async{
  if(_parentController.isClosed){
    print('_parentController broadcast started again');
    _parentController = StreamController<ApiResponse<int>>.broadcast();
  }

  parentSink.add(ApiResponse.loading('Registering Parent'));
  try{
    int resultData = await _parentRepository.createParent(parent);
    parentSink.add(ApiResponse.completed(resultData));

  } catch (e) {
    parentSink.add(ApiResponse.error(e.toString()));
  }
}

/*
fetchParent(String uid) async{
    parentStreamSink.add(ApiResponse.loading("loading"));
    try {
      Parent parent = await _parentRepository.fetchParent(uid: uid);
      parentStreamSink.add(ApiResponse.completed(parent));
    } catch (e){
      parentStreamSink.add(ApiResponse.error("error"));
      print(e);
    }
}
*/

Future<Parent?> fetchParent(String uid) async{
    try {
      return _parentRepository.fetchParent(uid: uid);
    } catch (e){
      print(e);
    }
    return null;
}


  @override
  void dispose() {
  _parentController.close();
  }

  set lastName(String value) {
    _lastName = value;
  }

  set email(String value) {
    _email = value;
  }

  set gender(String value) {
    _gender = value;
  }

  set phoneNo(String value) {
    _phoneNo = value;
  }

  String get phoneNo => _phoneNo;

  set photoUrl(String? value) {
    _photoUrl = value;
  }


  set lat(double value) {
    _lat = double.parse(value.toStringAsFixed(5));
  }

  String? get photoUrl => _photoUrl;

  set pinCode(String value) {
    _pinCode = value;
  }

  Parent generateParentObject(String uid) {
    parent = Parent(uid: uid,firstName: _firstName,lastName: _lastName,gender: _gender,email: _email,phoneNo: _phoneNo,photoUrl: '',address: Address(address: _addressName,pinCode: _pinCode), userLocation: UserLocation(latitude: _lat, longitude: _lon));
    return parent!;
  }

  set addressName(String value) {
    _addressName = value;
  }


  String get addressName => _addressName;

  set parent(Parent? value) {
    _parent = value;
  }

  Parent? get parent => _parent;

  set lon(double value) {
    _lon = double.parse(value.toStringAsFixed(5));
  }

  Future<void> uploadParentPic(int id, String photoUrl) async {
    /*var map = Map<String, dynamic>();
    map['FormFile'] = '$photoUrl';
    map['UserId'] = '$id';*/
    print('uploading parent pic $id');
    try {
      await _parentRepository.uploadParentPic(id, photoUrl);
    }catch (e){
      print(e);
    }
  }

  Future<String?> fetchParentPic(int id) async {
    try {
      await _parentRepository.fetchParentPic(id);
    } catch (e){
      print(e);
    }
  }
}
