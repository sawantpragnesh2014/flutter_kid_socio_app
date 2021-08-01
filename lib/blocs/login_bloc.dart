import 'dart:async';

import 'package:flutter_kid_socio_app/blocs/bloc.dart';
import 'package:flutter_kid_socio_app/models/parent.dart';
import 'package:flutter_kid_socio_app/repositories/parent_repository.dart';

class LoginBloc extends Bloc {
  ParentRepository _parentRepository;
  String _firstName;
  String _lastName;
  String _email;
  String _gender;
  String _phoneNo;

LoginBloc(){
  _parentRepository = ParentRepository();
}

  set firstName(String value) {
    _firstName = value;
  }

  createParent(Parent parent) async{
  _parentRepository.createParent(parent);
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

  Parent createParentByFormFields(String uid) {
    return Parent(uid: uid,firstName: _firstName,lastName: _lastName,gender: _gender,email: _email,phoneNo: _phoneNo);
  }
}
