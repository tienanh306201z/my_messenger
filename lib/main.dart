import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_messenger/screens/auth_screens/sign_up_screen.dart';
import 'package:my_messenger/utils/routes.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Messenger',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: ThemeData.dark(),
      home: SignUpScreen(),
      routes: routes,
    ),
  );
}
