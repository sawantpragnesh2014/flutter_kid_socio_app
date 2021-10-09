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

  Map toJson() => {
      'userId': id ?? 0,
      'uid': uid,
      'emailId': email,
      'firstName': firstName,
      'lastName': lastName,
      'gender': gender,
      'mobileNo': phoneNo,
      'isOtpVerified': true,
      'userStatus': true,
      'isUserBan': false,
      'userType': 3,
      'updatedBy': 0,
      'parentImage': photoUrl,
      'userPersonal': address,
      'userCreatedDate': '2021-10-04T07:24:39.325Z',
      'userModifiedDate': '2021-10-04T07:24:39.325Z',
    };
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

  Map toJson() => {
      'userId': id ?? 0,
      'address': address,
      'zipCode': pinCode,
      'state': 'string',
      'city': 'string',
      'landmark': 'string',
      'createdDate': '2021-10-04T07:24:39.325Z',
      'updatedDate': '2021-10-04T07:24:39.325Z'
    };

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