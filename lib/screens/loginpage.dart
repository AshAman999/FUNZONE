import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:funzone/main.dart';
import 'package:funzone/screens/customize.dart';
import 'package:funzone/screens/lobby.dart';

const users = const {
  'dribbble@gmail.com': '12345',
  'hunter@gmail.com': 'hunter',
};
bool firsttime = false;

class LoginScreen extends StatelessWidget {
  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String> _authUser(LoginData data) {
    print('Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) async {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: "${data.name}",
          password: "${data.password}",
        );
        return "";
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          return ('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          return ('Wrong password provided for that user.');
        }
        return "Unexpected Error";
      }
    });
  }

  Future<String> _signup(LoginData data) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: "${data.name}", password: "${data.password}");
      firsttime = true;
      return "";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return ('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        return ('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
      return (e.toString());
    }
    return "Unexpected Error";
  }

  Future<String> _recoverPassword(String name) {
    FirebaseAuth.instance.sendPasswordResetEmail(email: name);
    return Future.delayed(loginTime).then((_) {
      return "Reset Link Has Been SentTo Your Email";
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'Fun Zone',
      // logo: 'assets/images/ecorp-lightblue.png',
      onLogin: _authUser,
      onSignup: _signup,

      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => firsttime ? Customize() : WaitingLobby(),
        ));
      },
      onRecoverPassword: _recoverPassword,
    );
  }
}
