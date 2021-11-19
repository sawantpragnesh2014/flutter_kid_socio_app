import 'package:equatable/equatable.dart';

class Parent extends Equatable{
  int id;
  String uid;
  String firstName;
  String lastName;
  String phoneNo;
  String email;
  String? photoUrl;
  String gender;
  Address? address;
  UserLocation? userLocation;

  Parent({this.id = 0,required this.uid,required this.firstName,required this.lastName,required this.email,required this.phoneNo, this.photoUrl,this.gender = '', this.address, this.userLocation});


  @override
  String toString() {
    return 'Parent{id: $id, uid: $uid, firstName: $firstName, lastName: $lastName, phoneNo: $phoneNo, email: $email, gender: $gender, address: $address, userLocation: $userLocation}';
  }

  @override
  List get props => [id,uid,firstName,lastName,email,phoneNo,photoUrl,gender,address,userLocation];

  static Parent fromJson(dynamic json) {
    print('json $json');
    return Parent(
      id: json['userId'],
      uid: json['uid'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      phoneNo: json['mobileNo'],
      email: json['emailId'] ?? '',
      photoUrl: json['parentImage'] ?? '',
      gender: json['gender'],
      address: json['userPersonal'],
      userLocation: json['userLocation'],
    );
  }

  Map toJson() => {
      'userId': id,
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
      'userLocation': userLocation,
      'userCreatedDate': '2021-10-04T07:24:39.325Z',
      'userModifiedDate': '2021-10-04T07:24:39.325Z',
    };
}

class Address {
  final int id;
  final String address;
  final String pinCode;

  Address({this.id = 0,this.address = '',this.pinCode = ''});

  static Address fromJson(dynamic json){
    return Address(
      id: json['userId'],
      address: json['address'],
      pinCode: json['zipCode'],
    );
  }

  Map toJson() => {
      'userId': id,
      'address': address,
      'zipCode': pinCode,
      'state': 'string',
      'city': 'string',
      'landmark': 'string',
      'createdDate': '2021-10-04T07:24:39.325Z',
      'updatedDate': '2021-10-04T07:24:39.325Z'
    };

}

class UserLocation {
  final int id;
  final double latitude;
  final double longitude;

  UserLocation({this.id = 0,this.latitude = 0,this.longitude = 0});

  static UserLocation fromJson(dynamic json){
    return UserLocation(
      id: json['userId'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

  Map toJson() => {
      'userId': id,
      'latitude': latitude,
      'longitude': longitude,
    };

}

class ParentResponse{
  late List<Parent> results;

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