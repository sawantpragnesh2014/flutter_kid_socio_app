import 'dart:io';

import 'package:equatable/equatable.dart';
class PlayDateRequest {
  final int requestId;
  final int statusId;
  final String firstName;
  final String lastName;
  final String? photoUrl;
  final String schoolAddress;
  final String createdDate;
  final String requestDateAndTime;
  final String approvalDate;
  final String hobbiesName;
  final int fromTime;
  final int toTime;
  File? _imgPath;
  final String address;


  PlayDateRequest(
      {required this.requestId,
      required this.statusId,
      required this.firstName,
      required this.lastName,
      this.photoUrl,
      required this.schoolAddress,
      required this.createdDate,
      required this.requestDateAndTime,
      required this.approvalDate,
      required this.hobbiesName,
      required this.fromTime,
      required this.toTime,
      required this.address});

  File? get imgPath => _imgPath;

  set imgPath(File? value) {
    _imgPath = value;
  }

  static PlayDateRequest fromJson(dynamic json){
    return PlayDateRequest(
        requestId: json['requestId'],
      statusId: json['statusId'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      photoUrl: json['image'],
      schoolAddress: json['schoolAddress'],
      createdDate: json['createdDate'],
      requestDateAndTime: json['requestDateAndTime'],
      approvalDate: json['approvalDate'],
      hobbiesName: json['hobbiesName'] ?? 'Not available',
      fromTime: json['fromTime'],
      toTime: json['toTime'],
      address: json['address'],

    );
  }

}

class PlayDateRequestResponse{
  late List<PlayDateRequest> results;

  PlayDateRequestResponse.fromJson(dynamic json){
    results = <PlayDateRequest>[];
    var totalResults = json['data'];
    if(totalResults != null){
      totalResults.forEach((v) {
        results.add(PlayDateRequest.fromJson(v));
      });
      print('results $results');
    }
  }
}