import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_messenger/utils/enum_generation.dart';

class GoogleAuthentication {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<GoogleSignInResults> signInWithGoogle() async {
    try {
      if (await _googleSignIn.isSignedIn()) {
        FirebaseAuth.instance.signOut();
        return GoogleSignInResults.AlreadySignedIn;
      } else {
        final GoogleSignInAccount? _googleSignInAccount =
            await _googleSignIn.signIn();
        if (_googleSignInAccount == null) {
          print('Google Sign In not completed');
          return GoogleSignInResults.SignInNotCompleted;
        } else {
          final GoogleSignInAuthentication _googleSignInAuthentication =
              await _googleSignInAccount.authentication;
          OAuthCredential _oAuthCredential = GoogleAuthProvider.credential(
            accessToken: _googleSignInAuthentication.accessToken,
            idToken: _googleSignInAuthentication.idToken,
          );

          final UserCredential userCredential = await FirebaseAuth.instance
              .signInWithCredential(_oAuthCredential);

          if (userCredential.user!.email != null) {
            print('Google Sign In Completed');
            return GoogleSignInResults.SignInCompleted;
          } else {
            print('Google Sign In Error');
            return GoogleSignInResults.UnexpectedError;
          }
        }
      }
    } catch (e) {
      print('Error in Google Sign In: ${e.toString()}');
      return GoogleSignInResults.UnexpectedError;
    }
  }

  Future<bool> logOut() async {
    try {
      print('Google Log out');
      await _googleSignIn.disconnect();
      await _googleSignIn.signOut();
      await FirebaseAuth.instance.signOut();
      return true;
    } catch (e) {
      print('Error in Google Log Out: ${e.toString()}');
      return false;
    }
  }
}
