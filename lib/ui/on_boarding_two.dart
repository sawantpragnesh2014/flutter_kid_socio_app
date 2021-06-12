import 'package:flutter/material.dart';
import 'package:flutter_kid_socio_app/shared/size_config.dart';
import 'package:flutter_kid_socio_app/shared/styles.dart';

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
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
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
                    padding: const EdgeInsets.all(40.0),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Image(
                          image: AssetImage("assets/startUpKids.jpg"),
                          height: 410.0,
                          width: 410.0,
                        ),
                      ),
                      SizedBox(height: 30.0),
                      Text(
                        "Make PlayDates for your Kids, Make new Friends",
                        style: kTitleStyle,
                      ),
                      SizedBox(height: 15.0),
                      Text(
                        "Make PlayDates for your Kids, Make new Friends",
                        style: kSubTitleStyle,
                      ),
                    ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Image(
                            image: AssetImage("assets/startUpKids.jpg"),
                            fit: BoxFit.contain,
                            height: 410.0,
                            width: 410.0,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          "Make PlayDates for your Kids, Make new Friends",
                          style: kTitleStyle,
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          "Make PlayDates for your Kids, Make new Friends",
                          style: kSubTitleStyle,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Image(
                            image: AssetImage("assets/startUpKids.jpg"),
                            fit: BoxFit.contain,
                            height: 410.0,
                            width: 410.0,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          "Make PlayDates for your Kids, Make new Friends",
                          style: kTitleStyle,
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          "Make PlayDates for your Kids, Make new Friends",
                          style: kSubTitleStyle,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: buildPageIndicator(),
            ),
            currentPage != numPages -1?Expanded(
                child:Align(
                  alignment: FractionalOffset.bottomRight,
                  child: FlatButton(
                    onPressed: (){
                      pageController.nextPage(duration: Duration(milliseconds: 150,),curve: Curves.ease);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Next',style: blackTextSmall),
                        SizedBox(width: 10.0,),
                        Icon(Icons.arrow_forward,size: 30.0,)
                      ],
                    ),
                  ),
                )
            )
                :Text('')
          ],
        ),
      ),
      bottomSheet: currentPage == numPages -1
          ? Container(
        height: 100.0,
        width: double.infinity,
        color: Colors.red[600],
        child: GestureDetector(
          onTap: () => print('Get Started'),
          child: Padding(
            padding: EdgeInsets.only(bottom: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Get Started',
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
                SizedBox(width: 10.0,),
                Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      color: Color(0xFFfbaf43),
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  child: Icon(Icons.arrow_forward_ios,size: 30.0,color: Colors.white,),
                ),
                SizedBox(width: 10.0,),
              ],
            )
          ),
        ),
          )
          :Text(''),
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
          color: isActive?Colors.grey:Colors.grey[400],
          borderRadius: BorderRadius.all(Radius.circular(12))
      ),
    );
  }
}
