import 'package:flutter/material.dart';
import 'package:flutter_kid_socio_app/shared/size_config.dart';
import 'package:flutter_kid_socio_app/ui/login.dart';

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {

  Color _red = HexColor("#ef4138");

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset : false,
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                  child: Image(
                    image: AssetImage("assets/startUpKids.jpg"),
                    fit: BoxFit.contain,
                  )
              ),
              SizedBox(height: 10.0),
              RichText(
                text: TextSpan(
                    text: "Make PlayDates for your Kids, Make new Friends",
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
              ),
              Container(
                height: SizeConfig.blockSizeVertical*15,
                width: SizeConfig.screenWidth,
                decoration: BoxDecoration(
                    color: Colors.red[600],
                    borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(40.0),
                      topRight: const Radius.circular(40.0),
                    )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      "Get Started",
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                    Ink(
                      decoration: const ShapeDecoration(
                        color: Colors.yellow,
                        shape: CircleBorder(),
                      ),
                      child: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Login()),
                          );
                          //  You enter here what you want the button to do once the user interacts with it
                        },
                        icon: Icon(
                          Icons.keyboard_arrow_right,
                          color: Colors.white,
                        ),
                        iconSize: 40.0,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class HexColor extends Color {
  static int _getColor(String hex) {
    String formattedHex = "FF" + hex.toUpperCase().replaceAll("#", "");
    return int.parse(formattedHex, radix: 16);
  }

  HexColor(final String hex) : super(_getColor(hex));
}