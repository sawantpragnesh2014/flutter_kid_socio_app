import 'package:equatable/equatable.dart';

class Parent extends Equatable{
  int id;
  String uid;
  String firstName;
  String lastName;
  String phoneNo;
  String email;
  String photoUrl;
  String gender;
  Address address;

  Parent({this.id,this.uid,this.firstName,this.lastName,this.email,this.phoneNo,this.photoUrl,this.gender,this.address});


  @override
  String toString() {
    return 'Parent{id: $id, uid: $uid, firstName: $firstName, lastName: $lastName, phoneNo: $phoneNo, email: $email, gender: $gender, address: $address}';
  }

  @override
  List get props => [id,uid,firstName,lastName,email,phoneNo,photoUrl,gender,address];

  static Parent fromJson(dynamic json) {
    print('json $json');
    return Parent(
      id: json['userId'],
      uid: json['uid'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      phoneNo: json['mobileNo'],
      email: json['emailId'],
      photoUrl: json['parentImage'],
      gender: json['gender'],
      address: json['userPersonal'],
    );
  }
}

class Address {
  final int id;
  final String address;
  final String pinCode;

  Address({this.id,this.address,this.pinCode});

  static Address fromJson(dynamic json){
    return Address(
      id: json['userId'],
      address: json['address'],
      pinCode: json['zipCode'],
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

class ParentResponsee{
  List<int> results;

  ParentResponsee.fromJson(dynamic json){
    results = <int>[];
    var totalResults = json['userId'];
  }
}