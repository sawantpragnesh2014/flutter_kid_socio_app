import 'package:flutter/material.dart';
import 'package:flutter_kid_socio_app/models/nearby_playdate.dart';
import 'package:flutter_kid_socio_app/shared/styles.dart';

class TimeAndHobbies extends StatelessWidget {

  late final String  hobbiesName;
  late final String  fromTime;
  late final String  toTime;

  TimeAndHobbies({required this.hobbiesName,required this.fromTime,required this.toTime,});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Text('$fromTime',style: AppStyles.greyBold16,),
                Text('to',style: AppStyles.editTextStyle,),
                Text('$toTime',style: AppStyles.greyBold16,),
              ],
            ),
          ),
          SizedBox(width: 8.0,),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Hobbies',style: AppStyles.purpleTextBold16,),
                Text('${hobbiesName}',style: AppStyles.blackTextRegular14,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
