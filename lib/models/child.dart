import 'package:equatable/equatable.dart';
import 'package:flutter_kid_socio_app/models/parent.dart';

class Child extends Equatable{
  final int id;
  final int parentId;
  final String name;
  final String photoUrl;
  final String schoolName;
  final String dob;
  final String gender;

  Child({this.id,this.parentId,this.name,this.photoUrl,this.schoolName,this.dob,this.gender});

  @override
  List get props => [id,parentId,name,photoUrl,schoolName,dob,gender];

  static Child fromJson(dynamic json){
    return Child(
      id: json['childId'],
      parentId: json['parentId'],
      name: json['firstname'],
      photoUrl: json['image'],
      schoolName: json['schoolName'],
      dob: json['dob'],
      gender: json['gender']
    );
  }

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