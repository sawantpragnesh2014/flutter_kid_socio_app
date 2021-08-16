import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_kid_socio_app/shared/app_bar.dart';
import 'package:flutter_kid_socio_app/shared/colors.dart';
import 'package:flutter_kid_socio_app/shared/size_config.dart';
import 'package:flutter_kid_socio_app/shared/styles.dart';
import 'package:flutter_kid_socio_app/ui/bottom_nav.dart';
import 'package:flutter_kid_socio_app/ui/login.dart';
import 'package:flutter_kid_socio_app/ui/root_page.dart';

//https://www.youtube.com/watch?v=8eRQyE2PN7w refer for design
class OnBoardingTwo extends StatefulWidget {
  @override
  _OnBoardingTwoState createState() => _OnBoardingTwoState();
}

class _OnBoardingTwoState extends State<OnBoardingTwo> {
  final int numPages = 3;
  int currentPage = 0;
  final PageController pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBarView(height: 120.0,),
      body: Container(
        padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 8,
              child: Container(
                height: SizeConfig.blockSizeVertical*80,
                alignment: Alignment.center,
                child: PageView(
                  physics: ClampingScrollPhysics(),
                  controller: pageController,
                  onPageChanged: (int page){
                    setState(() {
                      currentPage = page;
                    });
                  },
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(40.0,0.0,40.0,0.0),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 8,
                          child: Container(
                            color: Colors.red,
                            child: Center(
                              child: Image(
                                image: AssetImage("assets/onboarding11.png"),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Expanded(
                          flex: 2,
                          child: Text(
                            "Make PlayDates for your Kids",
                            style: TextStyles.blackTextSemiSemiBold,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Expanded(
                          flex: 1,
                          child: Text(
                            "Make PlayDates for your Kids, Make new Friends",
                            style: TextStyles.blackTextRegular,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(40.0,0.0,40.0,0.0),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 8,
                            child: Container(
                              color: Colors.red,
                              child: Center(
                                child: Image(
                                  image: AssetImage("assets/onboarding11.png"),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Expanded(
                            flex: 2,
                            child: Text(
                              "Make PlayDates for your Kids",
                              style: TextStyles.blackTextSemiSemiBold,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Expanded(
                            flex: 1,
                            child: Text(
                              "Make PlayDates for your Kids, Make new Friends",
                              style: TextStyles.blackTextRegular,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(40.0,0.0,40.0,0.0),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 8,
                            child: Container(
                              color: Colors.red,
                              child: Center(
                                child: Image(
                                  image: AssetImage("assets/onboarding11.png"),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Expanded(
                            flex: 2,
                            child: Text(
                              "Make PlayDates for your Kids",
                              style: TextStyles.blackTextSemiSemiBold,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Expanded(
                            flex: 1,
                            child: Text(
                              "Make PlayDates for your Kids, Make new Friends",
                              style: TextStyles.blackTextRegular,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: buildPageIndicator(),
              ),
            ),
            /*SizedBox(height: 12.0,),*/
        Padding(
          padding: EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 0.0),
          child: SizedBox(
            height: 60.0,
              width: double.infinity,
              child: ElevatedButton(
                style: TextStyles.stylePurpleButton,
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) => RootPage()));
                },
                child: Text(
                  'Login',
                  style: TextStyles.whiteTextBold,
                ),
              ),
          ),
        ),
            /*currentPage != numPages -1?Expanded(
                child:Align(
                  alignment: FractionalOffset.bottomRight,
                  child: TextButton(
                    onPressed: (){
                      pageController.nextPage(duration: Duration(milliseconds: 150,),curve: Curves.ease);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Next',style: TextStyles.blackTextSmall),
                        SizedBox(width: 10.0,),
                        Icon(Icons.arrow_forward,size: 30.0,)
                      ],
                    ),
                  ),
                )
            )
                :Text('')*/
          ],
        ),
      ),
      /*bottomSheet: currentPage == numPages -1
          ? BottomNav(textName: "Get Started",bgColor:AppColors.coloref4138,onNavHit: (){
          Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => RootPage()));
      },)
          :Text(''),*/
    );
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
