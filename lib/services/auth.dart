import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_kid_socio_app/models/parent.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final GoogleSignIn googleSignIn = GoogleSignIn();
  final fb = FacebookLogin();
  bool isUserSignedIn = false;
  Parent parent;

  Future<void> signOut() async{
    try{
      bool isGoogleSignedIn = await googleSignIn.isSignedIn();
      bool isFbSignedIn = await fb.isLoggedIn;
      if(isGoogleSignedIn){
        print('google signed out');
        googleSignIn.signOut();
      }else if(isFbSignedIn){
        print('fb signed out');
        fb.logOut();
      }
       _auth.signOut();
       parent = null;
       isUserSignedIn = false;
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  Future<Parent> handleSignIn() async {
    // hold the instance of the authenticated user
    // flag to check whether we're signed in already
    bool isSignedIn = await googleSignIn.isSignedIn();
    isUserSignedIn = isSignedIn;

    if (isSignedIn) {
      // if so, return the current user
      parent = _userFromFireBaseUser(_auth.currentUser as User);
    }
    else {
      final GoogleSignInAccount googleUser =
      await googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;
      // get the credentials to (access / id token)userSignedIn
      // to sign in via Firebase Authentication
      final AuthCredential credential =
      GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken
      );
      parent = _userFromFireBaseUser((await _auth.signInWithCredential(credential)).user);
      isSignedIn = await googleSignIn.isSignedIn();
      isUserSignedIn = isSignedIn;
    }

    return parent;
  }

  Parent _userFromFireBaseUser(User user){
    return user != null?
    Parent(uid: user.uid,
      firstName: user.displayName?.split(' ')?.length > 0?user?.displayName?.split(' ')[0]:'',
      lastName: user.displayName?.split(' ')?.length > 0?user?.displayName?.split(' ')[1]:'',
      email: user.email,
      phoneNo: user.phoneNumber,
      photoUrl: user.photoURL
    )
        : null;
  }

  //auth change user stream
  Stream<Parent> get onAuthStateChanged{
    return _auth.authStateChanges()
        .map(_userFromFireBaseUser);
  }

  Parent get getUser => parent;

  void setUser(Parent data) {
    parent = data;
  }

  Future<Parent> signInWithCredential(AuthCredential credential) async {
    parent = _userFromFireBaseUser((await _auth.signInWithCredential(credential)).user);
    return parent;
  }

  Future<bool> loginFromFaceBook() async {
    Parent result;
    final res = await fb.logIn(
        permissions: [
          FacebookPermission.publicProfile,
          FacebookPermission.email
        ]
    );

    switch(res.status){
      case FacebookLoginStatus.Success:
        print('Login successful');
        //Get token
        final String fbToken = res.accessToken.token;

        //Convert to AuthCredential
        final AuthCredential credential = FacebookAuthProvider.credential(fbToken);

        //Parent Credential to Sign in with Firebase
        result = await signInWithCredential(credential);
        print('Facebook Login successful');
        break;
      case FacebookLoginStatus.Cancel:
        print('Login cancelled');
        break;
      case FacebookLoginStatus.Error:
        print('Login Error');
        break;
    }
    return result == null;
  }
}
