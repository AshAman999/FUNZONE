// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:crypton/crypton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:funzone/screens/customize.dart';
import 'package:funzone/screens/lobby.dart';
import 'package:shared_preferences/shared_preferences.dart';

const users = const {
  'dribbble@gmail.com': '12345',
  'hunter@gmail.com': 'hunter',
};
bool firsttime = false;
RSAKeypair rsaKeypair = RSAKeypair.fromRandom();
// var publicKey = RSAPublicKey.fromString(rsaKeypair.publicKey.toString());
// print(rsaKeypair.publicKey);
String rsaPublicKey = rsaKeypair.publicKey.toString();
String rsaPrivateKey = rsaKeypair.privateKey.toString();
String message = 'this is check messages';
String encrypted = rsaKeypair.publicKey.encrypt(message);
String decrypted = rsaKeypair.privateKey.decrypt(encrypted);
// print(encrypted);
// print(decrypted);

class LoginScreen extends StatelessWidget {
  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String> _authUser(LoginData data) {
    print('Name: ${data.name}, Password: ${data.password}');
    var bytes = utf8.encode("${data.password}"); // data being hashed
    var digest = sha256.convert(bytes);
    print(digest.toString());
    return Future.delayed(loginTime).then((_) async {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: "${data.name}",
          password: "${digest.toString()}",
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

  Future<String> _signup(SignupData data) async {
    try {
      var bytes = utf8.encode("${data.password}"); // data being hashed
      var digest = sha256.convert(bytes);
      print(digest.toString());
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: "${data.name}", password: digest.toString());
      firsttime = true;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('privateKey', rsaPrivateKey);
      await prefs.setString('publicKey', rsaPublicKey);
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
        print(rsaPublicKey + "public key");
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => firsttime
              ? Customize(
                  publickey: rsaPublicKey,
                )
              : WaitingLobby(
                  publickey: rsaPublicKey,
                ),
        ));
      },
      onRecoverPassword: _recoverPassword,
    );
  }
}
