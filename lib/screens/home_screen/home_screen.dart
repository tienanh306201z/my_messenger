import 'package:flutter/material.dart';
import 'package:my_messenger/helpers/firebase_auth/email_and_password_auth.dart';
import 'package:my_messenger/helpers/firebase_auth/facebook_auth.dart';
import 'package:my_messenger/helpers/firebase_auth/google_auth.dart';
import 'package:my_messenger/screens/auth_screens/log_in_screen.dart';

class HomeScreen extends StatefulWidget {
  static const tag = '/home-screen/';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final EmailAndPassWordAuth _emailAndPassWordAuth = EmailAndPassWordAuth();
  final GoogleAuthentication _googleAuthentication = GoogleAuthentication();
  final FacebookAuthentication _facebookAuthentication = FacebookAuthentication();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: ElevatedButton(
          child: const Text('Log out'),
          onPressed: () async {
            final bool googleResponse = await _googleAuthentication.logOut();
            if(!googleResponse) {
              final bool fBResponse = await _facebookAuthentication.logOut();
              if(!fBResponse){
                await _emailAndPassWordAuth.logOut();
              }
            }
            Navigator.of(context).pushReplacementNamed(LogInScreen.tag);
          },
        ),
      ),
    );
  }
}
