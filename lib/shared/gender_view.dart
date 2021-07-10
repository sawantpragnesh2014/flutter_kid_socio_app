import 'package:flutter/material.dart';
import 'package:flutter_kid_socio_app/shared/styles.dart';

import 'colors.dart';

typedef StringValue = String Function(String);

class GenderView extends StatefulWidget {
  final StringValue callback;

  GenderView({this.callback});

  @override
  _GenderViewState createState() => _GenderViewState();
}

class _GenderViewState extends State<GenderView> {
  List<Map> genderList = [];

  @override
  void initState() {
    super.initState();
    Map maleGenderMap = {'name':'Male','isSelected':true};
    Map femaleGenderMap = {'name':'Female','isSelected':false};
    genderList.add(maleGenderMap);
    genderList.add(femaleGenderMap);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: genderButtonList(genderList),
      ),
    );
  }

  Widget genderButton(Map genderMap){
    return Expanded(
      child: GestureDetector(
        onTap: (){
          setState(() {
            genderList.forEach((gender) => gender['isSelected'] = false);
            genderMap['isSelected'] = true;
            print('gender for callback ${genderMap['name']}');
            widget.callback(genderMap['name'].toString());
          });
        },
        child: Card(
          elevation: 0.0,
          color: genderMap['isSelected']?AppColors.colorf3f3f3:Colors.white,
          shape: RoundedRectangleBorder(
            side: new BorderSide(color: AppColors.colore6e6e6, width: 1.0),
            borderRadius: BorderRadius.circular(12), // <-- Radius
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
            child: Center(child: Text(genderMap['name'].toString(),style: TextStyles.genderTextStyle,)),
          ),
        ),
      ),
    );
  }

  List<Widget> genderButtonList(List<Map> genderList){
    return new List<Widget>.generate(genderList.length, (int index) {
      return genderButton(genderList[index]);
    });
  }
}
