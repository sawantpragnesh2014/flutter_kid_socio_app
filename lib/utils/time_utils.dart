import 'package:flutter/src/material/time.dart';
import 'package:flutter_kid_socio_app/models/child_timings.dart';

class TimeUtils{

  static String getDisplayTime(int timeOfDay) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timeOfDay);
    if(dateTime.hour == 12){
      return '${(dateTime.hour).toString().padLeft(2,'0')}:${dateTime.minute.toString().padLeft(2,'0')} pm';
    }else if(dateTime.hour > 12){
      return '${(dateTime.hour - 12).toString().padLeft(2,'0')}:${dateTime.minute.toString().padLeft(2,'0')} pm';
    }else{
      return '${dateTime.hour.toString().padLeft(2,'0')}:${dateTime.minute.toString().padLeft(2,'0')} am';
    }
  }

  static String getDateInYyyyMmDd(DateTime currentDate) {
    return '${currentDate.year}-${currentDate.month.toString().padLeft(2,'0')}-${currentDate.day.toString().padLeft(2,'0')}';//2021-10-07
  }
}