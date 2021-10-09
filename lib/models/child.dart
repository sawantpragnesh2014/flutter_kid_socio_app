import 'package:equatable/equatable.dart';
import 'package:flutter_kid_socio_app/models/parent.dart';

class Child extends Equatable{
  final int id;
  final int parentId;
  final String firstName;
  final String lastName;
  final String photoUrl;
  final String schoolName;
  final String dob;
  final String gender;

  Child({this.id,this.parentId,this.firstName,this.lastName,this.photoUrl,this.schoolName,this.dob,this.gender});

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
    'childId': id ?? 0,
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
  List<Child> results;

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