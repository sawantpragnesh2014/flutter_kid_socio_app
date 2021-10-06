import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ChildTimings extends Equatable{
  final int childId;
  String day;
  TimeOfDay fromTime;
  TimeOfDay toTime;
  bool isSelected;

  ChildTimings({this.childId,this.day,this.fromTime,this.toTime,this.isSelected = false});


  @override
  String toString() {
    return 'ChildTimings{day: $day, fromTime: $fromTime, toTime: $toTime, isSelected: $isSelected}';
  }

  @override
  List get props => [childId,day,fromTime,toTime,isSelected];

  static ChildTimings fromJson(dynamic json){
    return ChildTimings(
        childId: json['childId'],
        day: json['childDay'],
        fromTime: json['fromTime'],
        toTime: json['toTime']
    );
  }
}

class ChildTimingsResponse{
  List<ChildTimings> results;

  ChildTimingsResponse.fromJson(dynamic json){
    results = <ChildTimings>[];
    var totalResults = json['data'];
    if(totalResults != null){
      totalResults.forEach((v) {
        results.add(ChildTimings.fromJson(v));
      });
    }
  }
}