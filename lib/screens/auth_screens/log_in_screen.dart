import 'package:flutter/material.dart';
import 'package:my_messenger/widgets/common_auth_methods.dart';

class LogInScreen extends StatefulWidget {
  static const tag = '/log-in';
  const LogInScreen({Key? key}) : super(key: key);

  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final _signInKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: const Color(0xFF052B3D),
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          const Center(
            child: Text(
              'My Messenger',
              style: TextStyle(color: Colors.white, fontSize: 27),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Expanded(
            child: Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              padding: const EdgeInsets.only(top: 20),
              child: Form(
                key: _signInKey,
                child: ListView(
                  children: [
                    authTextFormField(hintText: 'Email'),
                    authTextFormField(hintText: 'Password'),
                    authButton(context: context, buttonName: 'Login'),
                    const Text(
                      'Or continue with',
                      textAlign: TextAlign.center,
                    ),
                    socialMediaIntegrationButtons(),
                    switchToAnotherAuthScreen(context: context, buttonNameFirst: 'Haven\'t had an account?', buttonNameLast: ' Sign-up'),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    ),);
  }
}
