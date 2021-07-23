import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_kid_socio_app/blocs/bloc.dart';
import 'package:flutter_kid_socio_app/models/user.dart';
import 'package:flutter_kid_socio_app/services/auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';

class AuthBloc extends Bloc{
  final auth = Auth();

  Parent get getUser => auth.getUser;

  Future<Parent> handleSignIn() async => auth.handleSignIn();

  Stream<Parent> get onAuthStateChanged => auth.onAuthStateChanged;

  void setUser(Parent data) => auth.setUser(data);

  Future<bool> loginFromFaceBook() async {
     return auth.loginFromFaceBook();
  }

  signOut() async{
    auth.signOut();
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }

}