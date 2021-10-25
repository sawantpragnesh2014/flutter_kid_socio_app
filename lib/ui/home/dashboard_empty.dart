import 'package:flutter/material.dart';
import 'package:flutter_kid_socio_app/shared/action_button.dart';
import 'package:flutter_kid_socio_app/shared/colors.dart';
import 'package:flutter_kid_socio_app/shared/styles.dart';
import 'package:flutter_kid_socio_app/ui/add_child/add_child.dart';

class DashboardEmpty extends StatefulWidget {
  @override
  _DashboardEmptyState createState() => _DashboardEmptyState();
}

class _DashboardEmptyState extends State<DashboardEmpty> {

  Widget get _addChildView {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => AddChild()));
      },
      child: Container(
        width: 180.0,
        height: 180.0,
        child: Card(
          color: AppColors.color7059E1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add_circle_outline_rounded,
                color: Colors.white,
                size: 48.0,
              ),
              Text('Add Child',style: AppStyles.whiteTextMedium14,)
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: AppStyles.getPadding,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _addChildView,
              SizedBox(height: 16.0,),
              Text('Lets get you started',textAlign: TextAlign.center,style: AppStyles.blueTextBold16),
              SizedBox(height: 16.0,),
              Text('Start by adding your kids to unlock 3 playdates',textAlign: TextAlign.center,style: AppStyles.blackTextRegular16,),
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/gift_bg.png"),
                    fit: BoxFit.scaleDown,
                  ),
                ),
                child: Image(image: AssetImage('assets/gift.png'),alignment: Alignment.bottomCenter,),
              ),
              SizedBox(height: 16.0,),
              ActionButtonView(
                btnName: 'How to Page Link',
                onBtnHit: (){
                  /*Navigator.push(context, MaterialPageRoute(
                      builder: (context) => AddChild()));*/
                },
                buttonStyle: AppStyles.stylePinkButton,
              ),
              SizedBox(height: 16.0,),
              /*Stack(
                          children: [
                            Positioned(
                            child: Image(image: AssetImage('assets/gift_bg.png')),
                            ),
                            Positioned(
                            child: Image(image: AssetImage('assets/gift.png')),
                            )
                          ],
                        ),*/

            ],
          ),
        )
    );
  }
}
