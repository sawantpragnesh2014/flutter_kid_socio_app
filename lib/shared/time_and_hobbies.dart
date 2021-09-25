import 'package:flutter/material.dart';
import 'package:flutter_kid_socio_app/shared/styles.dart';

class TimeAndHobbies extends StatelessWidget {
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
                Text('2:36 p.m',style: AppStyles.greyBold16,),
                Text('to',style: AppStyles.editTextStyle,),
                Text('4:36 p.m',style: AppStyles.greyBold16,),
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
                Text('Board Games, Outdoors, Park, Drawing',style: AppStyles.blackTextRegular14,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
