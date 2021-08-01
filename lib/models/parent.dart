import 'package:equatable/equatable.dart';

class Parent extends Equatable{
  final String uid;
  final String firstName;
  final String lastName;
  final String phoneNo;
  final String email;
  final String photoUrl;
  final String gender;

  Parent({this.uid,this.firstName,this.lastName,this.email,this.phoneNo,this.photoUrl,this.gender});

  @override
  List get props => [uid,firstName,lastName,phoneNo,email,photoUrl,gender];

  static Parent fromJson(dynamic json) {
    print('json $json');
    return Parent(
      uid: json['uid'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      phoneNo: json['mobileNo'],
      email: json['emailId'],
      gender: json['gender'],
    );
  }
}

class ParentResponse{
  List<Parent> results;

  ParentResponse.fromJson(dynamic json){
    results = <Parent>[];
    var totalResults = json['data'];
    if(totalResults != null){
      totalResults.forEach((v) {
        results.add(Parent.fromJson(v));
      });
    }
  }
}