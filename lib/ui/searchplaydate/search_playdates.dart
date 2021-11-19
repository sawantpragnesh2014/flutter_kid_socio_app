import 'package:flutter/material.dart';
import 'package:flutter_kid_socio_app/models/child.dart';
import 'package:flutter_kid_socio_app/shared/action_button.dart';
import 'package:flutter_kid_socio_app/shared/app_bar.dart';
import 'package:flutter_kid_socio_app/shared/child_info.dart';
import 'package:flutter_kid_socio_app/shared/colors.dart';
import 'package:flutter_kid_socio_app/shared/styles.dart';
import 'package:flutter_kid_socio_app/ui/home/outgoing_request_view.dart';
import 'package:flutter_kid_socio_app/ui/searchplaydate/preference.dart';
import 'package:flutter_kid_socio_app/ui/upcomingplaydate/upcoming_playdates_view.dart';
import 'package:flutter_kid_socio_app/utils/image_utils.dart';

class SearchPlayDates extends StatefulWidget {
  final Child?  child;
  final List<Child>? friendList;
  final List<Child>? recentPlayDateList;

  SearchPlayDates({this.child,this.friendList,this.recentPlayDateList});

  @override
  _SearchPlayDatesState createState() => _SearchPlayDatesState();
}

class _SearchPlayDatesState extends State<SearchPlayDates> {

  Widget _friendsList(List<Child> friendList){
    return Container(
      height: 60.0,
      child: ListView.separated(
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(width: 8.0);
          },
          scrollDirection: Axis.horizontal,
          itemCount: friendList.length,
          itemBuilder: (context, index) {
            return childItem(friendList[index]);
          }),
    );
  }

  Widget childItem(Child child) {
    return Container(
      height: 60.0,
      width: 60.0,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: child.photoUrl == null ?AssetImage('assets/google_logo.png'):AssetImage('assets/default_profile_picture.png'),
          fit: BoxFit.contain,
        ),
        borderRadius: BorderRadius.all( Radius.circular(30.0)),
        border: Border.all(
          color: AppColors.colorEB4C57,
          width: 8.0,
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBarView(height: 130.0,),
      body: Padding(
        padding: AppStyles.getPadding,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ChildInfo(child: widget.child,),
              SizedBox(height: 12.0,),
              ActionButtonView(
                  btnName: "Search Playdates",
                  onBtnHit: (){
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (context) => Preference(child: widget.child!,nearbyPlayDateList: widget.recentPlayDateList ?? [],)));
                  },
                  buttonStyle: AppStyles.stylePinkButton,
                  ),
              SizedBox(height: 12.0,),
              ActionButtonView(
                  btnName: "View sent requests",
                  onBtnHit: (){
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => OutgoingRequest(childId: widget.child!.id,)));
                  },
                  buttonStyle: AppStyles.stylePinkButton,
                  ),
              SizedBox(height: 12.0,),
              /*ActionButtonView(
                  btnName: "Upcoming playdates",
                  onBtnHit: (){
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => UpcomingPlaydateView(childId: widget.child!.id,)));
                  },
                  buttonStyle: AppStyles.stylePinkButton,
                  ),
              SizedBox(height: 12.0,),*/
              /*Text('Friends available',style: AppStyles.blackTextBold18,),
              SizedBox(height: 12.0,),
              _friendsList(widget.friendList!),
              SizedBox(height: 12.0,),*/
              Text('Recent Playdates',style: AppStyles.blackTextBold18,),
              SizedBox(height: 12.0,),
              _recentPlayDatesList(widget.recentPlayDateList ?? [])

            ],
          ),
        ),
      ),
    );
  }

  Widget _recentPlayDatesList(List<Child> recentPlayDateList) {
    return Container(
      height: 300.0,
      child: ListView.builder(
          itemCount: recentPlayDateList.length,
          itemBuilder: (context,index){
            return _recentPlayDatesView(recentPlayDateList[index]);
          }),
    );
  }

  Widget _recentPlayDatesView(Child? child) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.0,horizontal: 4.0),
      child: Card(
        child: ListTile(
          contentPadding: EdgeInsets.all(8.0),
          title: Text('${child?.firstName}, ',style: AppStyles.blackTextBold16),
          subtitle: Text('Breach Candy, Cumbala Hill',style: AppStyles.blackTextMedium11,),
          leading: CircleAvatar(
            backgroundImage: child?.photoUrl == null ?AssetImage('assets/google_logo.png'):AssetImage('assets/default_profile_picture.png'),
            radius: 40.0,
          ),
          trailing: Text('30 JUL,21',style: AppStyles.greyRegularSmall),
        ),
      ),
    );
  }
}
