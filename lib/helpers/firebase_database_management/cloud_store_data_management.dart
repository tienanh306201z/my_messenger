import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:intl/intl.dart';

class CloudStoreDataManagement {

  final _collectionName = 'users';

  Future<bool> checkThisUserAlreadyExists({required String userName}) async {
    try{
      final QuerySnapshot<Map<String, dynamic>> findResults = await FirebaseFirestore.instance.collection(_collectionName).where('user_name', isEqualTo: userName).get();

      return findResults.docs.isNotEmpty ? true : false;

    } catch (e) {
      print('Error in checking this user already exists or not: ${e.toString()}');
      return false;
    }
  }

  Future<bool> registerNewUser({required String userName, required String userAbout, required String userEmail}) async {
    try{

      final String? _getToken = await FirebaseMessaging.instance.getToken();

      final String currDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

      final String currTime = DateFormat('hh:mm a').format(DateTime.now());

      await FirebaseFirestore.instance.doc('$_collectionName/$userEmail').set({
        "about": userAbout,
        "activity": [],
        "connection_request": [],
        "connections": {},
        "creation_date": currDate,
        "creation_time": currTime,
        "phone_number": "",
        "profile_pic": "",
        "token": _getToken.toString(),
        "total_connections": "",
        "user_name": userName,
      });
      return true;
    } catch (e) {
      print('Error in registering new user: ${e.toString()}');
      return false;
    }
  }

  Future<bool> userRecordExistsOrNot({required String email}) async{
    try{
      final DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await FirebaseFirestore.instance.doc('$_collectionName/$email').get();
      return documentSnapshot.exists;
    } catch (e) {
      print('Error in User Record Exists Or Not: ${e.toString()}');
      return false;
    }
  }
}