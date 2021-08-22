import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funzone/Models/Profile.dart';
import 'package:funzone/apis/firebaseapi.dart';
import 'package:funzone/screens/lobby.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:random_string/random_string.dart';

class Customize extends StatefulWidget {
  const Customize({Key? key}) : super(key: key);

  @override
  _CustomizeState createState() => _CustomizeState();
}

List<Person> friends = [];

String name = "",
    email = "",
    about = "",
    imageurl = "",
    gender = "",
    age = "",
    uid = "",
    imagepath = "";
var pickedFile;

void getUser() {
  //get current user uid
  uid = FirebaseAuth.instance.currentUser!.uid;
}

void updatefirebaseuser() async {
  final refr = FirebaseStorage.instance
      .ref("uploadedImages/${randomAlphaNumeric(6)}.jpg");
  final task = refr.putFile(File(imagepath));
  final snapshot = await task.whenComplete(() {});
  imageurl = await snapshot.ref.getDownloadURL();
  var authuser = FirebaseAuth.instance.currentUser;
  authuser!.updateDisplayName(name);
  // authuser.updateEmail(email);
  authuser.updatePhotoURL(imageurl);
}

void updateuserslist() {
  FirebaseHelper firebaseHelper = FirebaseHelper();
  Map<String, String> person = {
    "uploadedImgUrl": imageurl.toString(),
    "username": name,
    "email": email,
    "about": about,
    "uid": uid,
    "age": age.toString(),
    "gender": gender,
  };
  firebaseHelper
      // .addUser(Person(name, about, email, uid, imageurl, friends))
      .addUser(person)
      .onError((error, stackTrace) => print("fatal error"));
}

class _CustomizeState extends State<Customize> {
  final picker = ImagePicker();
  void selectimage() async {
    pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    if (pickedFile != null) {
      setState(() {
        imagepath = pickedFile.path;
      });
    }
  }

  void empty() {
    name = "";
    email = "";
    about = "";
    imageurl = "";
    gender = "";
    age = "";
    uid = "";
    imagepath = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: Text("Edit Profile"),
        actions: [
          // GestureDetector(
          //   child: Center(
          //     child: Container(
          //         padding: EdgeInsets.symmetric(horizontal: 5),
          //         child: Text(
          //           "Skip",
          //           style: TextStyle(fontSize: 12.sp, color: Colors.white),
          //         )),
          //   ),
          //   onTap: () {
          //     Navigator.pushReplacement(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => WaitingLobby(),
          //       ),
          //     );
          //   },
          // )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(20),
                ),
                GestureDetector(
                  onTap: () {
                    selectimage();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[300],
                    ),
                    height: 30.h,
                    width: 35.w,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: imagepath == ""
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_a_photo_outlined,
                                  color: Colors.black26,
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                Text(
                                  "Select a photo from the device",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Container(
                                height: 20.h,
                                width: 16.w,
                                child: Image.file(
                                  File(imagepath),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Name",
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: Colors.lightBlueAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                CupertinoTextField(
                    autocorrect: false,
                    textCapitalization: TextCapitalization.words,
                    placeholder: "Enter your name",
                    onChanged: (value) {
                      name = value;
                    }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Email",
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: Colors.lightBlueAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                CupertinoTextField(
                    placeholder: "someome@example.com",
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      email = value;
                    }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          "Age",
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: Colors.lightBlueAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          width: 15.w,
                          child: CupertinoTextField(
                              placeholder: '23',
                              maxLength: 3,
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                age = value;
                              }),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "Gender",
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: Colors.lightBlueAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          width: 15.w,
                          child: CupertinoTextField(
                              placeholder: 'M/F/O',
                              autofillHints: [],
                              maxLength: 1,
                              keyboardType: TextInputType.text,
                              onChanged: (value) {
                                gender = value;
                              }),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "About",
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: Colors.lightBlueAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                CupertinoTextField(
                    //remove the border

                    textCapitalization: TextCapitalization.words,
                    placeholder: "Enter a short info about you",
                    maxLines: 5,
                    onChanged: (value) {
                      about = value;
                    }),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 1.h),
                ),
                CupertinoButton(
                  color: Colors.lightBlueAccent,
                  onPressed: () {
                    getUser();
                    updatefirebaseuser();
                    updateuserslist();
                    print(uid);
                    // empty();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WaitingLobby(),
                      ),
                    );
                    // print(name + about + imageurl + gender + age + email);
                  },
                  child: Text("Next"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
