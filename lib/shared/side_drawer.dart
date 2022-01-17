import 'package:flutter/material.dart';
import 'package:flutter_kid_socio_app/blocs/auth_bloc.dart';
import 'package:flutter_kid_socio_app/blocs/bloc_provider.dart';
import 'package:flutter_kid_socio_app/shared/colors.dart';
import 'package:flutter_kid_socio_app/shared/styles.dart';

typedef StringValue = void Function(String);

class SideDrawer extends StatelessWidget {
  final StringValue callback;
  final String userName;

  SideDrawer({required this.callback, required this.userName});

  final items = [
    'Profile',
    'Logout'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: Container(
          padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
          color: AppColors.colorE5E5E5,
          child: ListView.builder(
            itemCount: items.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return DrawerHeader(
                    decoration: BoxDecoration(
                      color: AppColors.colorE5E5E5,
                    ),
                    child: Align(alignment: Alignment.bottomLeft,child: Text('Hello, $userName',style: AppStyles.purpleTextBold16,)),
                  );
                }
            return Container(
              decoration: BoxDecoration(
                color: AppColors.colorE5E5E5,
                border: Border(bottom: BorderSide(color: Colors.white,)),
              ),
              child: ListTile(
                title: Text(items[index - 1],style: AppStyles.blackTextBold16,),
                onTap: () {
                  actionOnTap(items[index - 1]);
                  Navigator.pop(context);
                },
              ),
            );
          }),
        ),
      ),
    );
  }

  /*ListView(
  // Important: Remove any padding from the ListView.
  padding: EdgeInsets.zero,
  children: [
  const DrawerHeader(
  decoration: BoxDecoration(
  color: Colors.blue,
  ),
  child: Text('Drawer Header'),
  ),
  profile(context),
  notifications(context),
  plans(context),
  faqs(context),
  blog(context),
  referAFriend(context),
  settings(context),
  logoutUser(context),
  ],
  ),*/

  Future<void> actionOnTap(String itemName) async {
    switch (itemName) {
      case 'Logout':
        await CustomBlocProvider.getBloc<AuthBloc>()!.signOut();
        callback('logout');
        break;
      case 'Profile':
        callback('Profile');
        break;
    }
  }
}
