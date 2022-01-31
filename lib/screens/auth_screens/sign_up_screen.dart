import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:my_messenger/helpers/firebase_auth/email_and_password_auth.dart';
import 'package:my_messenger/helpers/firebase_auth/facebook_auth.dart';
import 'package:my_messenger/helpers/firebase_auth/google_auth.dart';
import 'package:my_messenger/screens/auth_screens/log_in_screen.dart';
import 'package:my_messenger/screens/home_screen/home_screen.dart';
import 'package:my_messenger/screens/new_user_entry_screen/new_user_entry_screen.dart';
import 'package:my_messenger/utils/enum_generation.dart';
import 'package:my_messenger/utils/reg_exp.dart';
import 'package:my_messenger/widgets/common_auth_methods.dart';

class SignUpScreen extends StatefulWidget {
  static const tag = '/sign-up';

  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _signUpKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();

  final EmailAndPassWordAuth _emailAndPassWordAuth = EmailAndPassWordAuth();
  final GoogleAuthentication _googleAuthentication = GoogleAuthentication();
  final FacebookAuthentication _facebookAuthentication = FacebookAuthentication();

  bool _isLoading = false;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: LoaderOverlay(
          useDefaultLoading: _isLoading,
          child: Column(
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
                        authTextFormField(
                            hintText: 'Email',
                            validator: (inputVal) {
                              if (!emailRegex.hasMatch(inputVal.toString())) {
                                return 'Email format not matching';
                              }
                              return null;
                            },
                            textEditingController: _email),
                        authTextFormField(
                            hintText: 'Password',
                            validator: (inputVal) {
                              if (inputVal!.length < 6) {
                                return 'Password must be at least 6 chars';
                              }
                              if (_password.text != _confirmPassword.text) {
                                return 'Password and confirm password not match';
                              }
                              return null;
                            },
                            textEditingController: _password),
                        authTextFormField(
                            hintText: 'Confirm Password',
                            validator: (inputVal) {
                              if (inputVal!.length < 6) {
                                return 'Password must be at least 6 chars';
                              }
                              if (_password.text != _confirmPassword.text) {
                                return 'Password and confirm password not match';
                              }
                              return null;
                            },
                            textEditingController: _confirmPassword),
                        signUpAuthButton(
                            context: context, buttonName: 'Create new account'),
                        const Text(
                          'Or continue with',
                          textAlign: TextAlign.center,
                        ),
                        signUpSocialMediaIntegrationButtons(),
                        switchToAnotherAuthScreen(
                            context: context,
                            buttonNameFirst: 'Already have an account?',
                            buttonNameLast: ' Log-in'),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget signUpAuthButton(
      {required BuildContext context, required String buttonName}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: ElevatedButton(
        onPressed: () async {
          FocusScope.of(context).unfocus();
          if (_signUpKey.currentState!.validate()) {
            print('Validated');

            if (mounted) {
              setState(() {
                _isLoading = true;
              });
            }

            context.loaderOverlay.show();

            final EmailSignUpResults response =
                await _emailAndPassWordAuth.signUpAuth(
                    email: _email.value.text.trim(), password: _password.value.text);

            if (response == EmailSignUpResults.SignUpCompleted) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Sign Up Completed')));
              Navigator.of(context).pushReplacementNamed(LogInScreen.tag);
            } else if (response == EmailSignUpResults.SignUpNotCompleted) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Sign Up Not Completed')));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Email Already Exists')));
            }
          } else {
            print('Errors occurred');
          }

          context.loaderOverlay.hide();

          if (mounted) {
            setState(() {
              _isLoading = false;
            });
          }
        },
        style: ElevatedButton.styleFrom(
          minimumSize: Size(MediaQuery.of(context).size.width - 60, 30),
          primary: Colors.lightBlue.shade900,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        ),
        child: Text(
          buttonName,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w300),
        ),
      ),
    );
  }

  Widget signUpSocialMediaIntegrationButtons() {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: () async {
              if(mounted){
                setState(() {
                  _isLoading = true;
                });
              }
              context.loaderOverlay.show();

              final GoogleSignInResults _googleSignInResults = await _googleAuthentication.signInWithGoogle();
              String msg = '';

              if(_googleSignInResults == GoogleSignInResults.SignInCompleted){
                msg = 'Sign In Completed';
              }
              else if (_googleSignInResults == GoogleSignInResults.SignInNotCompleted){
                msg = 'Sign In Not Completed';
              }
              else if (_googleSignInResults == GoogleSignInResults.AlreadySignedIn){
                msg = 'Already Google Signed In';
              }
              else {
                msg = 'Unexpected Error';
              }

              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));

              if(_googleSignInResults == GoogleSignInResults.SignInCompleted){
                Navigator.of(context).pushReplacementNamed(NewUserEntryScreen.tag);
              }

              if(mounted){
                setState(() {
                  _isLoading = false;
                });
              }
              context.loaderOverlay.hide();

            },
            icon: ShaderMask(
              shaderCallback: (Rect bounds) {
                return LinearGradient(
                  colors: <Color>[
                    Colors.redAccent.shade200,
                    Colors.yellowAccent.shade200,
                    Colors.green.shade700,
                    Colors.blue.shade700,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(bounds);
              },
              child: const Icon(
                FontAwesomeIcons.google,
                size: 30,
              ),
            ),
          ),
          IconButton(
            onPressed: () async {
              if(mounted){
                setState(() {
                  _isLoading = true;
                });
              }
              context.loaderOverlay.show();

              final FBSignInResults _fBSignInResults = await _facebookAuthentication.facebookLogIn();
              String msg = '';

              if(_fBSignInResults == FBSignInResults.SignInCompleted){
                msg = 'Sign In Completed';
              }
              else if (_fBSignInResults == FBSignInResults.SignInNotCompleted){
                msg = 'Sign In Not Completed';
              }
              else if (_fBSignInResults == FBSignInResults.AlreadySignedIn){
                msg = 'Already Facebook Signed In';
              }
              else {
                msg = 'Unexpected Error';
              }

              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));

              if(_fBSignInResults == FBSignInResults.SignInCompleted){
                Navigator.of(context).pushReplacementNamed(NewUserEntryScreen.tag);
              }

              if(mounted){
                setState(() {
                  _isLoading = false;
                });
              }
              context.loaderOverlay.hide();

            },
            icon: ShaderMask(
              shaderCallback: (bounds) {
                return LinearGradient(
                    colors: [Colors.lightBlue.shade200, Colors.blue.shade700],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight)
                    .createShader(bounds);
              },
              child: const Icon(
                FontAwesomeIcons.facebook,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
