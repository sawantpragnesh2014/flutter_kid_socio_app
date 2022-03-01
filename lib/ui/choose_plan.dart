import 'package:flutter/material.dart';
import 'package:flutter_kid_socio_app/shared/app_bar.dart';
import 'package:flutter_kid_socio_app/shared/colors.dart';
import 'package:flutter_kid_socio_app/shared/size_config.dart';
import 'package:flutter_kid_socio_app/shared/styles.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:flutter_kid_socio_app/models/parent.dart';


class ChoosePlan extends StatefulWidget {

  final Parent user;

  ChoosePlan(this.user);

  @override
  _ChoosePlanState createState() => _ChoosePlanState();
}

class _ChoosePlanState extends State<ChoosePlan> {
  String email = "";
  late Razorpay _razorpay;

  Widget cardView(String txt1, String txt2, String txt3, Color? color) {
    return InkWell(
      onTap: (){
        if(txt1.contains("500")){
          openCheckOut(500);
        } else if(txt1.contains("1500")){
          openCheckOut(1500);
        }else if (txt1.contains("5000")){
          openCheckOut(5000);
        }
      },
      child: Container(
        height: 150,
        width: 150,
        child: Card(
          color: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(txt1, style: TextStyle(fontSize: 30.0, color: Colors.white)),
                Text(txt2, style: TextStyle(fontSize: 10.0, color: Colors.white)),
                Text(txt3, style: TextStyle(fontSize: 20.0, color: Colors.white)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();


    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset : false,
        appBar: AppBarView(height: 130.0,),
        body: Padding(
          padding: EdgeInsets.fromLTRB(15.0, 50.0, 15.0, 0.0),
          child: Container(
              height: SizeConfig.blockSizeVertical*80,
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Choose your plan', style: AppStyles.redText),
              SizedBox(
                height: 10.0,
              ),
              Text('Choose a plan that works \nbest for you',
                  style: AppStyles.blackTextSmall),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  cardView('Trial', '3 playdates', 'for 1 week',Colors.red[300]),
                  cardView('Rs 500', 'Unlimited Playdates', 'for 1 month',AppColors.colore6e6e6,),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  cardView('Rs 1500', 'Unlimited playdates', 'for 3 months',AppColors.color16499f),
                  cardView('Rs 5000', 'unlimited playdates', 'for 1 year',AppColors.colorfbaf43),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              TextFormField(
                decoration: AppStyles.textInputDecoration.copyWith(hintText: 'Have a coupon?'),
                validator: (val) => val!.isEmpty?'Enter a valid coupon':'',
                onChanged: (val){
                  setState(() {
                    email = val;
                  });
                },
              ),
            ],
          )
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear(); // Removes all listeners
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    print("Payment successful");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    print("Payment failed");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
    print("External wallet");
  }

  void openCheckOut(int amt) {
    var options = {
      'key': 'rzp_test_VLyrCYtv9hqEOf',
      'amount': amt,
      'name': 'Kid Socio',
      'description': 'kids app',
      'prefill': {
        'contact': widget.user.phoneNo,
        'email': widget.user.email
      }
    };

    try {
      _razorpay.open(options);
    } catch(e){
      print("${e.toString()}");
    }
  }
}
