import 'package:flutter/material.dart';
import 'package:my_messenger/screens/auth_screens/log_in_screen.dart';
import 'package:my_messenger/screens/auth_screens/sign_up_screen.dart';

Map<String, WidgetBuilder> routes = {
  SignUpScreen.tag: (context) => SignUpScreen(),
  LogInScreen.tag: (context) => LogInScreen()
};