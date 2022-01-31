import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_messenger/utils/enum_generation.dart';

class EmailAndPassWordAuth {
  Future<EmailSignUpResults> signUpAuth(
      {required String email, required String password}) async {
    try {
      final UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential.user!.email != null) {
        userCredential.user!.sendEmailVerification();
        return EmailSignUpResults.SignUpCompleted;
      }
      return EmailSignUpResults.SignUpNotCompleted;
    } catch (e) {
      print('Error in email and password Sign Up: ${e.toString()}');
      return EmailSignUpResults.EmailAlreadyExists;
    }
  }
  Future<EmailSignInResults> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user!.emailVerified) {
        return EmailSignInResults.SignInCompleted;
      }
      else {
        final logOutResponse = await logOut();
        if(logOutResponse) {
          return EmailSignInResults.EmailNotVerified;
        }
        return EmailSignInResults.UnexpectedError;
      }
    } catch (e) {
      print(
          'Error in Sign In With Email and Password Authentication: ${e.toString()}');
      return EmailSignInResults.EmailOrPasswordInvalid;
    }
  }

  Future<bool> logOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      return true;
    } catch (e) {
      return false;
    }
  }
}
