import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseHelper {
  // ignore: non_constant_identifier_names
  Future<void> addUser(person) async {
    print(person);
// find the user if it exits edit the same
    FirebaseFirestore.instance
        .collection("users")
        .where("uid", isEqualTo: person["uid"])
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        FirebaseFirestore.instance
            .collection("users")
            .doc(value.docs.first.id)
            .update(person)
            .then((value) {
          print(person);
        }).catchError((e) {
          print(e);
        });
      } else {
        FirebaseFirestore.instance
            .collection("users")
            .add(person)
            .then((value) => print(value))
            .catchError((e) {
          print(e);
        });
      }
    });
  }

  Future<void> updateUser(person) async {
    print(person);
// find the user if it exits edit the same
    FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: person["email"])
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        FirebaseFirestore.instance
            .collection("users")
            .doc(value.docs.first.id)
            .update(person)
            .then((value) {
          print(person);
        }).catchError((e) {
          print(e);
        });
      } else {
        FirebaseFirestore.instance
            .collection("users")
            .add(person)
            .then((value) => print(value))
            .catchError((e) {
          print(e);
        });
      }
    });
  }

  // ignore: non_constant_identifier_names
  Future<void> acceptFriend(person) async {
    print(person);
    FirebaseFirestore.instance
        .collection("users")
        .doc(person.id)
        .collection("friends")
        .add(person)
        .then((value) => print(value))
        .catchError((e) {
      print(e);
    });
  }

  void logout() {
    FirebaseAuth.instance.signOut();
  } // ignore: non_constant_identifier_names

  getfriends(person) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(person.id)
        .collection("friends")
        .get();
  }

  getusers() async {
    return await FirebaseFirestore.instance.collection("users").get();
  }
}
