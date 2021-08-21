import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseHelper {
// Future <void> addBlog(blodData)async{
//   Firebase.

  // ignore: non_constant_identifier_names
  Future<void> addUser(person) async {
    print(person);
    FirebaseFirestore.instance
        .collection("users")
        .add(person)
        .then((value) => print(value))
        .catchError((e) {
      print(e);
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
  // ignore: non_constant_identifier_names

  //delete a post

  // delete(id) async {
  //   await FirebaseFirestore.instance.collection("blogs").doc(id).delete();
  // }

  getfriends(person) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(person.id)
        .collection("friends")
        .get();
  }

  getUsers() async {
    return await FirebaseFirestore.instance.collection("users").get();
  }
}
