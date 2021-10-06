import 'dart:async';

import 'package:flutter_kid_socio_app/blocs/bloc.dart';
import 'package:flutter_kid_socio_app/models/parent.dart';
import 'package:flutter_kid_socio_app/repositories/parent_repository.dart';
import 'package:flutter_kid_socio_app/services/api_response.dart';

class LoginBloc extends Bloc {
  ParentRepository _parentRepository;
  String _firstName;
  String _lastName;
  String _email;
  String _gender;
  String _phoneNo;
  String _photoUrl;
  String _pinCode;
  String _addressName;
  Parent _parent;

  StreamController _parentController = StreamController<ApiResponse<int>>.broadcast();

  StreamSink<ApiResponse<int>> get parentSink =>
      _parentController.sink;

  Stream<ApiResponse<int>> get parentStream =>
      _parentController.stream;

LoginBloc(){
  _parentRepository = ParentRepository();
}

  set firstName(String value) {
    _firstName = value;
  }

  createParent(Parent parent) async{
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

Future<Parent> fetchParent(String uid) async{
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

  set photoUrl(String value) {
    _photoUrl = value;
  }


  set pinCode(String value) {
    _pinCode = value;
  }

  Parent generateParentObject(String uid) {

    return Parent(uid: uid,firstName: _firstName,lastName: _lastName,gender: _gender,email: _email,phoneNo: _phoneNo,photoUrl: _photoUrl,address: Address(address: _addressName,pinCode: _pinCode));
  }

  set addressName(String value) {
    _addressName = value;
  }

  set parent(Parent value) {
    _parent = value;
  }
}
