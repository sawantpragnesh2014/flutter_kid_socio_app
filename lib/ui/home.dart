import 'package:flutter/material.dart';
import 'package:flutter_kid_socio_app/blocs/auth_bloc.dart';
import 'package:flutter_kid_socio_app/blocs/bloc_provider.dart';
import 'package:flutter_kid_socio_app/models/user.dart';
import 'package:flutter_kid_socio_app/shared/app_bar.dart';
import 'package:flutter_kid_socio_app/shared/colors.dart';
import 'package:flutter_kid_socio_app/shared/styles.dart';
import 'package:flutter_kid_socio_app/ui/add_child.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  User user;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    user = CustomBlocProvider.getBloc<AuthBloc>().getUser;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBarView(user: user,height: 150.0,),
          body: Padding(
          padding: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                  'Slide to a child to continue',
                  style: TextStyles.kSubTitleStyle
              ),
              SizedBox(height: 20.0,),
              TextButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => AddChild()));
                },
                child: Text('Add Child',style: TextStyles.facebookTextStyle,),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // <-- Radius
                  ),
                  backgroundColor: AppColors.coloref4138,
                ),
              ),
            ],
        )
          ),
      ),
    );
  }
}
