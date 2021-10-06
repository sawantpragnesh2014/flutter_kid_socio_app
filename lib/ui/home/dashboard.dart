import 'package:flutter/material.dart';
import 'package:flutter_kid_socio_app/models/child.dart';
import 'package:flutter_kid_socio_app/shared/colors.dart';
import 'package:flutter_kid_socio_app/shared/size_config.dart';
import 'package:flutter_kid_socio_app/shared/styles.dart';
import 'package:flutter_kid_socio_app/ui/add_child/add_child.dart';
import 'package:flutter_kid_socio_app/ui/searchplaydate/search_playdates.dart';
import 'package:flutter_kid_socio_app/ui/home/send_request_panel.dart';
import 'package:flutter_kid_socio_app/utils/image_utils.dart';

class Dashboard extends StatefulWidget {
  final List<Child> childList;

  Dashboard({this.childList});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final PageController pageController = PageController(initialPage: 0);
  int currentPage = 0;

  Widget get _tabChildDashboard {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _childListView(widget.childList),
        SizedBox(height: 8.0,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
                text: TextSpan(
                    children: [
                      TextSpan(text: 'Requests for ',style: AppStyles.blackTextBold18),
                      TextSpan(
                        text: 'Jenny',
                        style: AppStyles.redTextBold18,),
                    ]
                )
            ),
            Image.asset('assets/img_right_swipe.png', fit: BoxFit.cover)
          ],
        ),
        SizedBox(height: 8.0,),
        _childRequestViewPerChild(widget.childList),
      ],
    );
  }

  get _tabBar {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(
          25.0,
        ),
      ),
      child: TabBar(
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(
            25.0,
          ),
          color: AppColors.colorEB4C57,
        ),
        labelColor: Colors.white,
        unselectedLabelColor: AppColors.color888E9A,
        tabs: [
          Tab(text: 'Dashboard'),
          Tab(text: 'Events'),
          Tab(text: 'Near me'),
        ],
      ),
    );
  }

  get _tabBarView {
    return Container(
      height: SizeConfig.blockSizeVertical*60,
      /*color: Colors.purple,*/
      padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      child: TabBarView(children: <Widget>[
        _tabChildDashboard,
        Container(
          child: Center(
            child: Text('Display Tab 2', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          ),
        ),
        Container(
          child: Center(
            child: Text('Display Tab 3', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          ),
        ),
      ]
      ),
    );
  }

  Widget childItem(Child child) {
    return InkWell(
      onTap: (){
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SearchPlayDates(child: child,friendList: widget.childList,recentPlayDateList: widget.childList,)));
      },
      child: Container(
        width: 180.0,
        height: 180.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.0),
          image: DecorationImage(
            image: AssetImage("assets/facebook_logo.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
              height: 32.0,
              decoration: const BoxDecoration(
                color: AppColors.color7059E1,
                borderRadius: BorderRadius.all(Radius.circular(24.0)),
              ),
              alignment: Alignment.bottomCenter,
              child: Text(
                '${child.name}',
                style: AppStyles.whiteTextBold16,
                textAlign: TextAlign.center,
              )),
        ),
      ),
    );
  }

  Widget _childListView(List<Child> childList) {
    return Container(
      height: 180.0,
      child: ListView.separated(
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(width: 8.0);
          },
          scrollDirection: Axis.horizontal,
          itemCount: childList.length + 1,
          itemBuilder: (context, index) {
            if (index == childList.length) {
              return _addChildButton;
            }
            return childItem(childList[index]);
          }),
    );
  }

  Widget get _addChildButton {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AddChild()));
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
              Text(
                'Add Child',
                style: AppStyles.whiteTextMedium14,
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
        padding: AppStyles.getPadding,
        child: SingleChildScrollView(
            child: DefaultTabController(
          length: 3, // length of tabs
          initialIndex: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _tabBar,
              _tabBarView
            ],
          ),
        )
      )
    );
  }

  _childRequestViewPerChild(List<Child> childList) {
    return Expanded(
      flex: 1,
      child: PageView.builder(
          physics: ClampingScrollPhysics(),
          controller: pageController,
          onPageChanged: (int page){
            setState(() {
              currentPage = page;
            });
          },
          itemBuilder: (context, position) {
            if (position == childList.length) return null;
            return Container(
              height: 300.0,
              child: ListView.builder(
                  itemCount: childList.length,
                  itemBuilder: (context,index){
                    return childListView(childList[index]);
                  }),
            );
          },
          ),
    );
  }

  Widget childListView(Child child) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.0,horizontal: 4.0),
      child: Card(
        child: ListTile(
          onTap: (){
            showAcceptRequestPanel(child);
          },
          contentPadding: EdgeInsets.all(8.0),
          title: RichText(
              text: TextSpan(
                  children: [
                    TextSpan(text: '${child.name}, ',style: AppStyles.blackTextBold16),
                    TextSpan(
                        text: '2:36 p.m',
                        style: AppStyles.editTextStyle,),
                  ]
              )
          ),
          subtitle: Text('Breach Candy, Cumbala Hill',style: AppStyles.blackTextMedium11,),
          leading: CircleAvatar(
            backgroundImage: child?.photoUrl == null ?AssetImage('assets/google_logo.png'):AssetImage('assets/default_profile_picture.png'),
            radius: 40.0,
          ),
          trailing: Image.asset('assets/icon_msg.png', fit: BoxFit.cover),
        ),
      ),
    );
  }

  void showAcceptRequestPanel(Child child) {
    showModalBottomSheet(context: context, builder: (context){
      return Container(
        color: AppColors.colorF4F4F4,
        padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 30.0),
        child: SendRequestPanel(child: child,panelType: 'accept_request',),
      );
    });
  }
}
