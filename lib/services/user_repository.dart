import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_kid_socio_app/models/user.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final GoogleSignIn googleSignIn = GoogleSignIn();
  bool isUserSignedIn = false;
  User user;

  /*Future<FirebaseUser> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(currentUser.uid == user.uid);

    return user;
  }*/

  void signOutGoogle() async {
    await googleSignIn.signOut();
  }

  Future<User> handleSignIn() async {
    // hold the instance of the authenticated user
    // flag to check whether we're signed in already
    bool isSignedIn = await googleSignIn.isSignedIn();
    isUserSignedIn = isSignedIn;

    if (isSignedIn) {
      // if so, return the current user
      user = _userFromFireBaseUser(_auth.currentUser as FirebaseUser);
    }
    else {
      final GoogleSignInAccount googleUser =
      await googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;
      // get the credentials to (access / id token)userSignedIn
      // to sign in via Firebase Authentication
      final AuthCredential credential =
      GoogleAuthProvider.getCredential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken
      );
      user = _userFromFireBaseUser((await _auth.signInWithCredential(credential)).user);
      isSignedIn = await googleSignIn.isSignedIn();
      isUserSignedIn = isSignedIn;
    }

    return user;
  }

  /*Future<bool> checkUserLoggedInVal() async{
    bool isSignedIn = await googleSignIn.isSignedIn();
    isUserSignedIn = isSignedIn;

    return isSignedIn;
  }

  Future<User> fetchUser() async {
    final FirebaseUser currentUser = await _auth.currentUser();
    user = _userFromFireBaseUser(currentUser);
    return user;
  }*/

  User _userFromFireBaseUser(FirebaseUser user){
    return user != null?
    User(uid: user.uid,
      name: user.displayName,
      email: user.email,
      phoneNo: user.phoneNumber,
      photoUrl: user.photoUrl
    )
        : null;
  }

  //auth change user stream
  Stream<User> get onAuthStateChanged{
    return _auth.onAuthStateChanged
        .map(_userFromFireBaseUser);
  }

  User get getUser => user;

  void setUser(User data) {
    user = data;
  }
}

class AuthProvider extends InheritedWidget{
  final Auth auth;
  AuthProvider({Key key,Widget child,this.auth}):super(key:key,child: child);
  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  static AuthProvider of(BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<AuthProvider>();
  }

  //AuthProvider.of(context).auth
}