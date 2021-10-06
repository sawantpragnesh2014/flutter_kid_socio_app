import 'package:flutter/material.dart';
import 'package:flutter_kid_socio_app/models/child.dart';
import 'package:flutter_kid_socio_app/shared/app_bar.dart';
import 'package:flutter_kid_socio_app/shared/child_info.dart';
import 'package:flutter_kid_socio_app/shared/colors.dart';
import 'package:flutter_kid_socio_app/shared/styles.dart';
import 'package:flutter_kid_socio_app/ui/home/send_request_panel.dart';
import 'package:flutter_kid_socio_app/utils/image_utils.dart';

class NearbyPlayDates extends StatefulWidget {

  final List<Child> nearbyPlayDatesList;
  final Child child;

  NearbyPlayDates({this.child,this.nearbyPlayDatesList});

  @override
  _NearbyPlayDatesState createState() => _NearbyPlayDatesState();
}

class _NearbyPlayDatesState extends State<NearbyPlayDates> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBarView(height: 150.0,),
      body: Padding(
        padding: AppStyles.getPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 1,
              child: ChildInfo(child: widget.child,),
            ),
            SizedBox(height: 12.0,),
            Text('Nearby playdates',style: AppStyles.blackTextBold18,),
            SizedBox(height: 12.0,),
            Expanded(
                flex: 3,
                child: _nearbyPlayDatesList(widget.nearbyPlayDatesList),
            )

          ],
        ),
      ),
    );
  }

  Widget _nearbyPlayDatesList(List<Child> recentPlayDateList) {
    return Container(
      height: 300.0,
      child: ListView.builder(
          itemCount: recentPlayDateList.length,
          itemBuilder: (context,index){
            return _nearbyPlayDatesView(recentPlayDateList[index]);
          }),
    );
  }

  Widget _nearbyPlayDatesView(Child child) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.0,horizontal: 4.0),
      child: Card(
        child: ListTile(
          onTap: (){
            showSendRequestPanel(child);
          },
          contentPadding: EdgeInsets.all(8.0),
          title: RichText(
              text: TextSpan(
                  children: [
                    TextSpan(text: '${child.name}, ',style: AppStyles.blackTextBold16),
                    TextSpan(
                      text: '2:36 p.m',
                      style: AppStyles.blackTextBold18,),
                  ]
              )
          ),
          subtitle: Text('Breach Candy, Cumbala Hill',style: AppStyles.blackTextMedium11,),
          leading: CircleAvatar(
            backgroundImage: child?.photoUrl == null ?AssetImage('assets/google_logo.png'):AssetImage('assets/default_profile_picture.png'),
            radius: 40.0,
          ),
          trailing: Image.asset('assets/img_apartment.png', fit: BoxFit.cover),
        ),
      ),
    );
  }

  void showSendRequestPanel(Child child) {
    showModalBottomSheet(context: context, builder: (context){
      return Container(
          color: AppColors.colorF4F4F4,
          padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 30.0),
          child: SendRequestPanel(child: child,panelType: 'send_request',),
      );
    });
  }
}
