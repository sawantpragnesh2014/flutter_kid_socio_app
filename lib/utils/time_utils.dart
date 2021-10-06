import 'package:flutter/src/material/time.dart';

class TimeUtils{

  static String getDisplayTime(TimeOfDay timeOfDay) {
    if(timeOfDay.hour >= 12){
      return '${timeOfDay.hourOfPeriod.toString().padLeft(2,'0')}:${timeOfDay.minute.toString().padLeft(2,'0')} pm';
    }else{
      return '${timeOfDay.hourOfPeriod.toString().padLeft(2,'0')}:${timeOfDay.minute.toString().padLeft(2,'0')} am';
    }
  }
}