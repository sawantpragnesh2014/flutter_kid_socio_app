import 'package:flutter/material.dart';
import 'package:flutter_kid_socio_app/shared/colors.dart';
import 'package:flutter_kid_socio_app/shared/styles.dart';

typedef StringValue = String Function(String);

class InterestView extends StatefulWidget {
  @override
  _InterestViewState createState() => _InterestViewState();
}

class _InterestViewState extends State<InterestView> {
  List<Map> interestsList = [];

  @override
  void initState() {
    super.initState();
    interestsList.add({'name':'Swimming','isSelected':false});
    interestsList.add({'name':'Running','isSelected':false});
    interestsList.add({'name':'Football','isSelected':false});
    interestsList.add({'name':'Swimming','isSelected':false});
    interestsList.add({'name':'Running','isSelected':false});
    interestsList.add({'name':'Football','isSelected':false});
    interestsList.add({'name':'Swimming','isSelected':false});
    interestsList.add({'name':'Running','isSelected':false});
    interestsList.add({'name':'Football','isSelected':false});
    interestsList.add({'name':'Swimming','isSelected':false});
    interestsList.add({'name':'Running','isSelected':false});
    interestsList.add({'name':'Football','isSelected':false});
    interestsList.add({'name':'Swimming','isSelected':false});
    interestsList.add({'name':'Running','isSelected':false});
    interestsList.add({'name':'Football','isSelected':false});
    interestsList.add({'name':'Swimming','isSelected':false});
    interestsList.add({'name':'Running','isSelected':false});
    interestsList.add({'name':'Football','isSelected':false});
    interestsList.add({'name':'Swimming','isSelected':false});
    interestsList.add({'name':'Running','isSelected':false});
    interestsList.add({'name':'Football','isSelected':false});
    interestsList.add({'name':'Swimming','isSelected':false});
    interestsList.add({'name':'Running','isSelected':false});
    interestsList.add({'name':'Football','isSelected':false});
    interestsList.add({'name':'Swimming','isSelected':false});
    interestsList.add({'name':'Running','isSelected':false});
    interestsList.add({'name':'Football','isSelected':false});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Wrap(
        alignment: WrapAlignment.start,
        children: interestsButtonList(interestsList),
      ),
    );
  }

  Widget interestsButton(Map interestsMap){
    return GestureDetector(
      onTap: (){
        setState(() {
          interestsMap['isSelected'] = !interestsMap['isSelected'];
          print('interests for callback ${interestsMap['name']}');
          // widget.callback(interestsMap['name'].toString());
        });
      },
      child: Card(
        margin: EdgeInsets.all(10.0),
        color: interestsMap['isSelected']?AppColors.color16499f:AppColors.colorf3f3f3,
        shape: RoundedRectangleBorder(
          side: new BorderSide(color: AppColors.colore6e6e6, width: 1.0),
          borderRadius: BorderRadius.circular(12), // <-- Radius
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(interestsMap['name'].toString(),style: interestsMap['isSelected']?TextStyles.interestSelected:TextStyles.genderTextStyle,),
        ),
      ),
    );
  }

  List<Widget> interestsButtonList(List<Map> interestsList){
    return new List<Widget>.generate(interestsList.length, (int index) {
      return interestsButton(interestsList[index]);
    });
  }
}

