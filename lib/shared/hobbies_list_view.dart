import 'package:flutter/material.dart';
import 'package:flutter_kid_socio_app/models/child_hobbies.dart';
import 'package:flutter_kid_socio_app/shared/styles.dart';

import 'colors.dart';

class HobbiesListView extends StatefulWidget {
  final List<ChildHobbies>? childHobbiesList;

  HobbiesListView({this.childHobbiesList});

  @override
  _HobbiesListViewState createState() => _HobbiesListViewState();
}

class _HobbiesListViewState extends State<HobbiesListView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        spacing: 10.0,
        children: interestsButtonList(widget.childHobbiesList),
      ),
    );
  }

  Widget interestsButton(ChildHobbies childHobbies){
    return Container(
      width: 150.0,
      height: 150.0,
      child: GestureDetector(
        onTap: (){
          setState(() {
            childHobbies.isSelected = !childHobbies.isSelected;
            print('Hobblie clicked ${childHobbies.name} ${childHobbies.isSelected}');
            /*widget.callback(interestsMap['name'].toString());*/
          });
        },
        child: Card(
          margin: EdgeInsets.all(10.0),
          color: childHobbies.isSelected?AppColors.color16499f:AppColors.colorf3f3f3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32), // <-- Radius
          ),
          child: Center(
              child: Text(
                childHobbies.name.toString(),
                style: childHobbies.isSelected?AppStyles.interestSelected:AppStyles.genderTextStyle,
              )
          ),
        ),
      ),
    );
  }

  List<Widget> interestsButtonList(List<ChildHobbies>? interestsList){
    return new List<Widget>.generate(interestsList!.length, (int index) {
      return interestsButton(interestsList[index]);
    });
  }
}
