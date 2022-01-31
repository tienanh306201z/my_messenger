import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:my_messenger/helpers/firebase_database_management/cloud_store_data_management.dart';
import 'package:my_messenger/screens/main_screen/main_screen.dart';
import 'package:my_messenger/utils/reg_exp.dart';
import 'package:my_messenger/widgets/common_auth_methods.dart';

class NewUserEntryScreen extends StatefulWidget {
  static const tag = '/new-user-entry';

  const NewUserEntryScreen({Key? key}) : super(key: key);

  @override
  _NewUserEntryScreenState createState() => _NewUserEntryScreenState();
}

class _NewUserEntryScreenState extends State<NewUserEntryScreen> {
  bool _isLoading = false;

  final GlobalKey<FormState> _takeUserPrimaryInfoKey = GlobalKey<FormState>();

  final TextEditingController _userName = TextEditingController();
  final TextEditingController _userAbout = TextEditingController();
  
  final CloudStoreDataManagement _cloudStoreDataManagement = CloudStoreDataManagement();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: LoaderOverlay(
          useDefaultLoading: _isLoading,
          child: SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            child: Form(
              key: _takeUserPrimaryInfoKey,
              child: ListView(
                shrinkWrap: true,
                children: [
                  _upperHeading(),
                  commonTextFormField(
                      hintText: 'User Name',
                      validator: (inputVal) {
                        if (inputVal!.trim().length < 6) {
                          return "User Name At Least 6 Characters";
                        } else if (inputVal.contains('@')) {
                          return "'@' Not Allowed";
                        } else if (inputVal.contains('__')) {
                          return "'__' Not Allowed...Use '_' instead of '__'";
                        } else if (!messageRegex.hasMatch(inputVal)) {
                          return "Sorry,Only Emoji Not Supported";
                        }
                        return null;
                      },
                      textEditingController: _userName),
                  commonTextFormField(
                      hintText: 'About You',
                      validator: (inputVal) {
                        if (inputVal!.length < 6) {
                          return 'About You must have at least 6 chars';
                        }
                        return null;
                      },
                      textEditingController: _userAbout),
                  _saveUserInfo(),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _upperHeading() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 40),
      child: Center(
        child: Text(
          'Set Up Your Personal Information',
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style: TextStyle(color: Colors.white, fontSize: 23),
        ),
      ),
    );
  }

  Widget _saveUserInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: ElevatedButton(
        onPressed: () async {
          FocusScope.of(context).unfocus();
          if (_takeUserPrimaryInfoKey.currentState!.validate()) {
            print('validated');

            if(mounted) {
              setState(() {
                _isLoading = true;
              });
            }
            context.loaderOverlay.show();

            final bool userNameExistsResponse = await _cloudStoreDataManagement.checkThisUserAlreadyExists(userName: _userName.text);

            String msg = '';

            if(userNameExistsResponse){
              msg = 'User Name Already Exists';
            }
            else{
              final bool _userEntryResponse = await _cloudStoreDataManagement.registerNewUser(userName: _userName.text, userAbout: _userAbout.text, userEmail: FirebaseAuth.instance.currentUser!.email.toString());
              if(_userEntryResponse){
                msg = 'User data entry successfully';
                Navigator.of(context).pushReplacementNamed(MainScreen.tag);
              }
              else{
                msg = 'User data entry unsuccessfully';
              }
            }

            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));

            if(mounted) {
              setState(() {
                _isLoading = false;
              });
            }
            context.loaderOverlay.hide();
          } else {
            print('not validated');
          }
        },
        style: ElevatedButton.styleFrom(
          minimumSize: Size(MediaQuery.of(context).size.width - 60, 30),
          primary: Colors.lightBlue.shade900,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        ),
        child: const Text(
          'Save',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w300),
        ),
      ),
    );
  }
}
