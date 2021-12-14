import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_messenger/screens/auth_screens/log_in_screen.dart';
import 'package:my_messenger/screens/auth_screens/sign_up_screen.dart';

Widget switchToAnotherAuthScreen(
    {required BuildContext context,
    required String buttonNameFirst,
    required String buttonNameLast}) {
  return ElevatedButton(
    onPressed: () {
      if (buttonNameLast.trim() == 'Log-in') {
        Navigator.of(context).pushReplacementNamed(LogInScreen.tag);
      } else {
        Navigator.of(context).pushReplacementNamed(SignUpScreen.tag);
      }
    },
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          buttonNameFirst,
          style: const TextStyle(
              color: Colors.blueGrey,
              fontSize: 13,
              letterSpacing: 1,
              decoration: TextDecoration.underline),
        ),
        Text(
          buttonNameLast,
          style: const TextStyle(
              color: Colors.lightBlueAccent, fontSize: 13, letterSpacing: 1.0),
        ),
      ],
    ),
    style: ElevatedButton.styleFrom(elevation: 0, primary: Colors.transparent),
  );
}

Widget socialMediaIntegrationButtons() {
  return Container(
    width: double.maxFinite,
    padding: const EdgeInsets.all(20.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          onPressed: () {},
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
          onPressed: () {},
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

Widget authTextFormField({required String hintText}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: TextFormField(
      decoration: InputDecoration(
        hintText: hintText,
        enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(width: 1, color: Colors.grey.withOpacity(0.3))),
      ),
    ),
  );
}

Widget authButton({required BuildContext context, required String buttonName}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
    child: ElevatedButton(
      onPressed: () {},
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
