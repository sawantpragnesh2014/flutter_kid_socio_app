import 'package:flutter/material.dart';
import 'package:flutter_kid_socio_app/shared/colors.dart';

class BottomNav extends StatelessWidget {
  var textName;
  Color bgColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      width: double.infinity,
      color: bgColor,
      child: GestureDetector(
        onTap: () => onNavHit(),
        child: Padding(
            padding: EdgeInsets.only(bottom: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  textName,
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
                SizedBox(width: 10.0,),
                Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: AppColors.colorfbaf43,
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  child: Icon(Icons.arrow_forward_ios,size: 30.0,color: Colors.white,),
                ),
                SizedBox(width: 10.0,),
              ],
            )
        ),
      ),
    );
  }

  BottomNav({this.textName,this.bgColor, this.onNavHit});

  final VoidCallback onNavHit;

}
