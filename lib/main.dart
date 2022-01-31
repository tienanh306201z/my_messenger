import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_messenger/helpers/firebase_database_management/cloud_store_data_management.dart';
import 'package:my_messenger/screens/auth_screens/log_in_screen.dart';
import 'package:my_messenger/screens/auth_screens/sign_up_screen.dart';
import 'package:my_messenger/screens/main_screen/main_screen.dart';
import 'package:my_messenger/screens/new_user_entry_screen/new_user_entry_screen.dart';
import 'package:my_messenger/utils/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MaterialApp(
      title: 'Messenger',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: ThemeData.dark(),
      home: await _differentContextDesisionTake(),
      routes: routes,
    ),
  );
}

Future<Widget> _differentContextDesisionTake() async {
  if(FirebaseAuth.instance.currentUser == null){
    return LogInScreen();
  }
  final CloudStoreDataManagement _cloudStoreDataManagement = CloudStoreDataManagement();
  final bool _dataExistsResponse = await _cloudStoreDataManagement.userRecordExistsOrNot(email: FirebaseAuth.instance.currentUser!.email.toString());

  if(_dataExistsResponse) {
    return MainScreen();
  }
  else {
    return NewUserEntryScreen();
  }
}
