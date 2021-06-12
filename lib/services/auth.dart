import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

final GoogleSignIn googleSignIn = GoogleSignIn();

Future<FirebaseUser> signInWithGoogle() async {
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
}

void signOutGoogle() async {
  await googleSignIn.signOut();
}

/*
Future<void> handleLogin() async {
  final FacebookLoginResult result = await facebookLogin.logIn(['email']);
  switch (result.status) {
    case FacebookLoginStatus.cancelledByUser:
      break;
    case FacebookLoginStatus.error:
      break;
    case FacebookLoginStatus.loggedIn:
      try {
        await loginWithfacebook(result);
      } catch (e) {
        print(e);
      }
      break;
  }
}
*/

/*
Future loginWithfacebook(FacebookLoginResult result) async {
  final FacebookAccessToken accessToken = result.accessToken;
  AuthCredential credential = FacebookAuthProvider.getCredential(accessToken);
  var a = await _auth.signInWithCredential(credential);
}*/
