import 'package:flutter/material.dart';
import 'package:flutter_kid_socio_app/blocs/auth_bloc.dart';
import 'package:flutter_kid_socio_app/blocs/bloc_provider.dart';
import 'package:flutter_kid_socio_app/blocs/child_bloc.dart';
import 'package:flutter_kid_socio_app/models/child.dart';
import 'package:flutter_kid_socio_app/models/parent.dart';
import 'package:flutter_kid_socio_app/shared/app_bar.dart';
import 'package:flutter_kid_socio_app/shared/colors.dart';
import 'package:flutter_kid_socio_app/shared/styles.dart';
import 'package:flutter_kid_socio_app/ui/add_child/add_child.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Parent user;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    user = CustomBlocProvider.getBloc<AuthBloc>().getUser;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Child>>(
      stream: CustomBlocProvider.getBloc<ChildBloc>().childListStream,
      builder: (context, snapshot) {
        List<Child> childList = snapshot.data ?? [];
        return SafeArea(
          child: Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBarView(height: 150.0,),
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
                Container(
                  height: 300.0,
                  child: ListView.builder(
                      itemCount: childList.length,
                      itemBuilder: (context,index){
                        return childListView(childList[index]);
                      }),
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
                  SizedBox(height: 20.0,),
                  TextButton(
                    onPressed: () async {
                      await CustomBlocProvider.getBloc<AuthBloc>().signOut();
                    },
                    child: Text('Logout',style: TextStyles.facebookTextStyle,),
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
    );
  }

  Widget childListView(Child child) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.0,horizontal: 4.0),
        child: Card(
          child: ListTile(
            contentPadding: EdgeInsets.all(8.0),
            title: Text('${child.name}',style: TextStyles.genderTextStyle,),
            leading: CircleAvatar(
              backgroundImage: user?.photoUrl == null ?AssetImage('assets/google_logo.png'):NetworkImage(user.photoUrl + '?width=400&height400'),
              radius: 40.0,
            ),
          ),
        ),
      );
  }
}