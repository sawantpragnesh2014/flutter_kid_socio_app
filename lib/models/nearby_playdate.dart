import 'package:equatable/equatable.dart';
class NearbyPlaydate extends Equatable{
  final int parentId;
  final int childId;
  final String firstName;
  final String lastName;
  final String? photoUrl;
  final String dob;
  final String gender;
  final String schoolAddress;
  final double distance;
  final String hobbiesId;
  final String hobbiesName;
  final String matchedHobbies;
  final int hobbiesMatchedCount;
  final String matchedHobbiesName;
  final String? matchedWeekDay;
  final int weekDayCount;

  NearbyPlaydate({this.childId = 0,required this.parentId,required this.firstName,required this.lastName,
    required this.photoUrl,
    required this.dob,required this.gender,required this.schoolAddress,
    required this.distance,required this.hobbiesId,required this.hobbiesName,
    required this.matchedHobbies,required this.hobbiesMatchedCount,required this.matchedHobbiesName,
    required this.matchedWeekDay,required this.weekDayCount
  });


  @override
  String toString() {
    return 'NearbyPlaydate{parentId: $parentId, childId: $childId, firstName: $firstName, lastName: $lastName, photoUrl: $photoUrl, dob: $dob, gender: $gender, schoolAddress: $schoolAddress, distance: $distance, hobbiesId: $hobbiesId, hobbiesName: $hobbiesName, matchedHobbies: $matchedHobbies, hobbiesMatchedCount: $hobbiesMatchedCount, matchedHobbiesName: $matchedHobbiesName, matchedWeekDay: $matchedWeekDay, weekDayCount: $weekDayCount}';
  }

  @override
  List get props => [childId,parentId,firstName,lastName,photoUrl,
    dob,gender,schoolAddress,distance,hobbiesId,hobbiesName,
    matchedHobbies,hobbiesMatchedCount,matchedHobbiesName,
    matchedWeekDay,weekDayCount];

  static NearbyPlaydate fromJson(dynamic json){
    return NearbyPlaydate(
        childId: json['childId'],
        parentId: json['userId'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        photoUrl: json['image'] ?? '',
        schoolAddress: json['schoolAddress'],
        dob: json['dob'],
        gender: json['gender'] ?? '',
        distance: 1,
        hobbiesId: json['hobbiesId'],
        hobbiesName: json['hobbiesName'],
        matchedHobbies: json['matchedHobbies'],
        hobbiesMatchedCount: json['hobbiesMatchedCount'],
        matchedHobbiesName: json['matchedHobbiesName'],
        matchedWeekDay: json['matchedWeekDay'],
        weekDayCount: json['weekDayCount'],
    );
  }

  Map toJson() => {
    'childId': childId,
    'userId': parentId,
    'firstName': firstName,
    'lastName': lastName,
    'image': photoUrl,
    'dob': dob,
    'gender': gender,
    'schoolAddress': schoolAddress,
    'distance': distance,
    'hobbiesId': hobbiesId,
    'hobbiesName': hobbiesName,
    'matchedHobbies': matchedHobbies,
    'hobbiesMatchedCount': hobbiesMatchedCount,
    'matchedHobbiesName': matchedHobbiesName,
    'matchedWeekDay': matchedWeekDay,
    'weekDayCount': weekDayCount,
  };

}

class NearbyPlaydateResponse{
  late List<NearbyPlaydate> results;

  NearbyPlaydateResponse.fromJson(dynamic json){
    results = <NearbyPlaydate>[];
    var totalResults = json['data'];
    if(totalResults != null){
      totalResults.forEach((v) {
        results.add(NearbyPlaydate.fromJson(v));
      });
      print('results $results');
    }
  }
}