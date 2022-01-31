import 'package:flutter/material.dart';
import 'package:my_messenger/screens/auth_screens/log_in_screen.dart';
import 'package:my_messenger/screens/auth_screens/sign_up_screen.dart';
import 'package:my_messenger/screens/home_screen/home_screen.dart';
import 'package:my_messenger/screens/main_screen/main_screen.dart';
import 'package:my_messenger/screens/new_user_entry_screen/new_user_entry_screen.dart';

Map<String, WidgetBuilder> routes = {
  SignUpScreen.tag: (context) => SignUpScreen(),
  LogInScreen.tag: (context) => LogInScreen(),
  HomeScreen.tag: (context) => HomeScreen(),
  NewUserEntryScreen.tag: (context) => NewUserEntryScreen(),
  MainScreen.tag: (context) => MainScreen(),
};