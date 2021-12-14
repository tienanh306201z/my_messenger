import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_messenger/screens/auth_screens/log_in_screen.dart';
import 'package:my_messenger/widgets/common_auth_methods.dart';

class SignUpScreen extends StatefulWidget {
  static const tag = '/sign-up';

  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _signUpKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF052B3D),
        body: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            const Center(
              child: Text(
                'Create Your Account',
                style: TextStyle(color: Colors.white, fontSize: 27),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(top: 20),
                child: Form(
                  key: _signUpKey,
                  child: ListView(
                    children: [
                      authTextFormField(hintText: 'Email'),
                      authTextFormField(hintText: 'Password'),
                      authTextFormField(hintText: 'Confirm Password'),
                      authButton(context: context, buttonName: 'Create new account'),
                      const Text(
                        'Or continue with',
                        textAlign: TextAlign.center,
                      ),
                      socialMediaIntegrationButtons(),
                      switchToAnotherAuthScreen(context: context, buttonNameFirst: 'Already have an account?', buttonNameLast: ' Log-in'),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
