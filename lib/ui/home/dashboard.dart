import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_kid_socio_app/blocs/auth_bloc.dart';
import 'package:flutter_kid_socio_app/blocs/bloc_provider.dart';
import 'package:flutter_kid_socio_app/blocs/send_accept_request_bloc.dart';
import 'package:flutter_kid_socio_app/models/child.dart';
import 'package:flutter_kid_socio_app/models/nearby_playdate.dart';
import 'package:flutter_kid_socio_app/models/playdate_request.dart';
import 'package:flutter_kid_socio_app/shared/action_button.dart';
import 'package:flutter_kid_socio_app/shared/colors.dart';
import 'package:flutter_kid_socio_app/shared/error_page.dart';
import 'package:flutter_kid_socio_app/shared/loading.dart';
import 'package:flutter_kid_socio_app/shared/size_config.dart';
import 'package:flutter_kid_socio_app/shared/styles.dart';
import 'package:flutter_kid_socio_app/ui/add_child/add_child.dart';
import 'package:flutter_kid_socio_app/ui/searchplaydate/search_playdates.dart';
import 'package:flutter_kid_socio_app/ui/home/send_request_panel.dart';
import 'package:flutter_kid_socio_app/utils/image_utils.dart';
import 'package:skeletons/skeletons.dart';

class Dashboard extends StatefulWidget {
  late final List<Child> childList;

  Dashboard({required this.childList});

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
        SizedBox(height: 16.0,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
                text: TextSpan(
                    children: [
                      TextSpan(text: 'Requests for ',
                          style: AppStyles.blackTextBold18),
                      TextSpan(
                        text: '${widget.childList[currentPage].firstName}',
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
      height: SizeConfig.blockSizeVertical * 60,
      /*color: Colors.purple,*/
      padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      child: TabBarView(children: <Widget>[
        _tabChildDashboard,
        Container(
          child: Center(
            child: Text('Display Tab 2',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          ),
        ),
        Container(
          child: Center(
            child: Text('Display Tab 3',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          ),
        ),
      ]
      ),
    );
  }

  int next(int min, int max) => min + Random().nextInt(max - min);

  Widget childItem(Child child) {
    setFileImage2(child);
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) =>
            SearchPlayDates(child: child,
              friendList: widget.childList,
              recentPlayDateList: widget.childList,)));
      },
      child: Container(
        width: 180.0,
        height: 180.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.0),
          image: DecorationImage(
            image: child.imgPath == null ?AssetImage("assets/default_profile_picture.png"): FileImage(child.imgPath!) as ImageProvider,
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
              child: Center(
                child: Text(
                  '${child.firstName}',
                  style: AppStyles.whiteTextBold16,
                  textAlign: TextAlign.center,
                ),
              )),
        ),
      ),
    );
  }

  Widget _childListView(List<Child> childList) {
    return Container(
      height: 160.0,
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
          color: AppColors.colorFFC035,
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
  void initState() {
    super.initState();
    CustomBlocProvider.setBloc(SendAcceptRequestBloc());
  }

  @override
  void dispose() {
    super.dispose();
    CustomBlocProvider.getBloc<SendAcceptRequestBloc>()!.dispose();
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
                  SizedBox(height: 12.0,),
                  _tabBarView,
                  SizedBox(height: 16.0,),
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
        itemCount: childList.length,
        physics: ClampingScrollPhysics(),
        controller: pageController,
        onPageChanged: (int page) {
          setState(() {
            currentPage = page;
          });
        },
        itemBuilder: (context, position) {
          return FutureBuilder<List<PlayDateRequest>?>(

              future: CustomBlocProvider.getBloc<SendAcceptRequestBloc>()!
                  .getIncomingRequestList(childList[position].id),

              builder: (context, snapshot) {
                print('Connection state ${snapshot.connectionState}');
                print('Connection snapshot.hasError for incoming ${snapshot.hasError}');
                print('Connection snapshot.hasdata for incoming ${snapshot.hasData}');

                if (snapshot.connectionState == ConnectionState.waiting) {
                  print('data loading');
                  return SkeletonListView();
                } else {
                  if (snapshot.hasData) {
                    List<PlayDateRequest>? nearbyPlaydateList = snapshot.data;
                    return Container(
                      height: 300.0,
                      child: ListView.builder(
                          itemCount: nearbyPlaydateList!.length,
                          itemBuilder: (context, index) {
                            return childListView(nearbyPlaydateList[index],
                                childList[currentPage]);
                          }),
                    );
                  } else {
                    return Center(child: Text('Empty',style: AppStyles.greyRegularSmall,textAlign: TextAlign.center,));
                  }
                }
                return Center(child: Text('Empty',style: AppStyles.greyRegularSmall,textAlign: TextAlign.center,));
              }
          );
        },
      ),
    );
  }

  Widget childListView(PlayDateRequest incomingPlayDateRequest, Child child) {
    setFileImage(incomingPlayDateRequest);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
      child: Card(
        child: ListTile(
          onTap: () {
            if (incomingPlayDateRequest.statusId == SendAcceptRequestBloc.PENDING) {
              showAcceptRequestPanel(incomingPlayDateRequest, child);
            }
          },
          contentPadding: EdgeInsets.all(8.0),
          title: RichText(
              text: TextSpan(
                  children: [
                    TextSpan(text: '${incomingPlayDateRequest.firstName}, ',
                        style: AppStyles.blackTextBold16),
                    TextSpan(
                      text: '2:36 p.m',
                      style: AppStyles.editTextStyle,),
                  ]
              )
          ),
          subtitle: Text(
            'Breach Candy, Cumbala Hill', style: AppStyles.blackTextMedium11,),
          leading: CircleAvatar(
            backgroundImage: incomingPlayDateRequest.imgPath == null ? AssetImage(
                'assets/default_profile_picture.png') : FileImage(incomingPlayDateRequest.imgPath!) as ImageProvider,
            radius: 40.0,
          ),
          trailing: getApprovalStatusIcon(incomingPlayDateRequest.statusId),
        ),
      ),
    );
}

  Future<void> setFileImage(PlayDateRequest user) async {
    if(user.imgPath != null){
      return;
    }
    user.imgPath = await ImageUtils.getTempFile('playDateRequest_${user.requestId}_img',user.photoUrl);
    if(user.imgPath == null){
      return;
    }
    setState(() {
    });
  }

  Future<void> setFileImage2(Child child) async {
    if(child.imgPath != null){
      return;
    }
    child.imgPath = await ImageUtils.getFile('child_${child.id}_img',child.photoUrl);
    if(child.imgPath == null){
      return;
    }
    setState(() {
    });
  }

Icon? getApprovalStatusIcon(int statusId){
    switch(statusId){
      case SendAcceptRequestBloc.ACCEPT:
        return Icon(Icons.check_circle,color: Colors.lightGreenAccent,);

      case SendAcceptRequestBloc.REJECT:
        return Icon(Icons.report_gmailerrorred_sharp,color: Colors.redAccent,);
      case SendAcceptRequestBloc.PENDING:
      default:
        return null;
    }
}

void showAcceptRequestPanel(PlayDateRequest incomingPlayDateRequest, Child child) {
  showModalBottomSheet(context: context, builder: (context) {
    return Container(
      color: AppColors.colorF4F4F4,
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
      child: SendRequestPanel(
        child: child, incomingPlayDateRequest: incomingPlayDateRequest, panelType: 'accept_request',),
    );
  });
}
}
