import 'package:flutter/material.dart';
import 'package:flutter_kid_socio_app/shared/action_button.dart';
import 'package:flutter_kid_socio_app/shared/colors.dart';
import 'package:flutter_kid_socio_app/shared/size_config.dart';
import 'package:flutter_kid_socio_app/shared/styles.dart';
import 'package:flutter_kid_socio_app/ui/add_child/add_child.dart';

class DashboardEmpty extends StatefulWidget {
  @override
  _DashboardEmptyState createState() => _DashboardEmptyState();
}

class _DashboardEmptyState extends State<DashboardEmpty> {
  final PageController pageController = PageController(initialPage: 0);
  final int numPages = 3;
  int currentPage = 0;

  Widget get _addChildView {
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

  Widget get _page1 {
    return Padding(
        padding: const EdgeInsets.fromLTRB(40.0, 0.0, 40.0, 0.0),
        child:
          Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Text('Lets get you started',textAlign: TextAlign.center,style: AppStyles.blueTextBold16),
            SizedBox(height: 16.0,),
            Text('Start by adding your kids to unlock 3 playdates',textAlign: TextAlign.center,style: AppStyles.blackTextRegular16,),
            SizedBox(height: 16.0,),
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/gift_bg.png"),
                  fit: BoxFit.scaleDown,
                ),
              ),
              child: Image(image: AssetImage('assets/gift.png'),alignment: Alignment.bottomCenter,),
            ),
          ]
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
        padding: AppStyles.getPadding,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _addChildView,
              SizedBox(
                height: 16.0,
              ),
              Container(
                height: SizeConfig.blockSizeVertical*40,
                alignment: Alignment.center,
                child: PageView(
                  physics: ClampingScrollPhysics(),
                  controller: pageController,
                  onPageChanged: (int page) {
                    setState(() {
                      currentPage = page;
                    });
                  },
                  children: [
                    _page1,
                    _page1,
                    _page1,
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: buildPageIndicator(),
              ),
              SizedBox(
                height: 16.0,
              ),
            ],
          ),
        ));
  }

  List<Widget> buildPageIndicator() {
    List<Widget> list = [];
    for(int i = 0; i < numPages;i++){
      list.add(i == currentPage? indicator(true):indicator(false));
    }
    return list;
  }

  indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 4.0),
      height: 12.0,
      width: 12.0,
      decoration: BoxDecoration(
          color: isActive?Colors.yellow:Colors.grey[400],
          borderRadius: BorderRadius.all(Radius.circular(12))
      ),
    );
  }
}
