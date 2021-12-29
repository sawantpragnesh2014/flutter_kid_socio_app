import 'dart:io';

import 'package:equatable/equatable.dart';

class Child extends Equatable{
  final int id;
  final int parentId;
  final String firstName;
  final String lastName;
  final String? photoUrl;
  final String schoolName;
  final String dob;
  final String gender;
  File? _imgPath;
  final String address;

  Child({this.id = 0,required this.parentId,required this.firstName,required this.lastName,required this.photoUrl,required this.schoolName,required this.dob,required this.gender,required this.address});


  File? get imgPath => _imgPath;

  set imgPath(File? value) {
    _imgPath = value;
  }

  @override
  String toString() {
    return 'Child{id: $id, parentId: $parentId, firstName: $firstName, lastName: $lastName, photoUrl: $photoUrl, schoolName: $schoolName, dob: $dob, gender: $gender, address: $address}';
  }

  @override
  List get props => [id,parentId,firstName,lastName,photoUrl,schoolName,dob,gender];

  static Child fromJson(dynamic json){
    return Child(
      id: json['childId'],
      parentId: json['parentId'],
      firstName: json['firstname'],
      lastName: json['lastname'],
      photoUrl: json['image'] ?? '',
      schoolName: json['schoolName'],
      dob: json['dob'],
      gender: json['gender'] ?? '',
      address: json['address'] ?? ''
    );
  }
  
  Map toJson() => {
    'childId': id,
    'parentId': parentId,
    'firstname': firstName,
    'lastname': lastName,
    'image': photoUrl,
    'schoolName': schoolName,
    'dob': dob,
    'gender': gender,
    'schoolAddress':'string',
    'address': address
  };

  @override
  bool? get stringify => throw UnimplementedError();

}

class ChildResponse{
  late List<Child> results;

  ChildResponse.fromJson(dynamic json){
    results = <Child>[];
    var totalResults = json['data'];
    if(totalResults != null){
      totalResults.forEach((v) {
        results.add(Child.fromJson(v));
      });
    }
  }
}