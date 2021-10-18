import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ChildTimings extends Equatable{
  int childId;
  String day;
  int fromTime;
  int toTime;
  bool isSelected;

  ChildTimings({required this.childId,required this.day,required this.fromTime,required this.toTime,this.isSelected = false});


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

  Map<String, dynamic> toJson() => {
      'childId': childId,
      'childDay': day,
      'fromTime': fromTime,
      'toTime': toTime,
    };
}

/*
class TimeSpan {
  double totalMilliseconds;

  TimeSpan({this.totalMilliseconds});

  Map<String, dynamic> toJson() => {
    'totalMilliseconds': totalMilliseconds,
  };
}
*/

class ChildTimingsList {
  ChildTimingsList(this.childTimingsList);

  List<ChildTimings> childTimingsList;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'childTimings': childTimingsList,
  };
}

class ChildTimingsResponse{
  late List<ChildTimings> results;

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