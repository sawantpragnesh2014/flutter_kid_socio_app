import 'package:equatable/equatable.dart';
import 'package:flutter_kid_socio_app/models/parent.dart';

class Child extends Equatable{
  final int id;
  late final int parentId;
  late final String firstName;
  late final String lastName;
  late final String photoUrl;
  late final String schoolName;
  late final String dob;
  late final String gender;

  Child({this.id = 0,required this.parentId,required this.firstName,required this.lastName,required this.photoUrl,required this.schoolName,required this.dob,required this.gender});

  @override
  List get props => [id,parentId,firstName,lastName,photoUrl,schoolName,dob,gender];

  static Child fromJson(dynamic json){
    return Child(
      id: json['childId'],
      parentId: json['parentId'],
      firstName: json['firstname'],
      lastName: json['lastname'],
      photoUrl: json['image'],
      schoolName: json['schoolName'],
      dob: json['dob'],
      gender: json['gender']
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
    'schoolAddress':'string'
  };

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