import 'package:flutter/material.dart';
import 'package:flutter_kid_socio_app/blocs/auth_bloc.dart';
import 'package:flutter_kid_socio_app/blocs/bloc_provider.dart';

typedef StringValue = void Function(String);

class SideDrawer extends StatelessWidget {

  final StringValue callback;

  SideDrawer({required this.callback});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
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
      ),
    );
  }

  Widget profile(BuildContext context) {
    return ListTile(
      title: const Text('Profile'),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }

  Widget notifications(BuildContext context) {
    return ListTile(
      title: const Text('Notifications'),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }

  Widget plans(BuildContext context) {
    return ListTile(
      title: const Text('Plans'),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }

  Widget faqs(BuildContext context) {
    return ListTile(
      title: const Text('Faqs'),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }

  Widget blog(BuildContext context) {
    return ListTile(
      title: const Text('Blog'),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }

  Widget referAFriend(BuildContext context) {
    return ListTile(
      title: const Text('Refer a friend'),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }

  Widget settings(BuildContext context) {
    return ListTile(
      title: const Text('Settings'),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }

  logoutUser(BuildContext context) {
    return ListTile(
      title: const Text('Logout'),
      onTap: () async {
        await CustomBlocProvider.getBloc<AuthBloc>()!.signOut();
        callback('logout');
        Navigator.pop(context);
      },
    );
  }
}
