import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:funzone/apis/firebaseapi.dart';
import 'package:funzone/main.dart';
import 'package:funzone/screens/custimize.dart';
import 'package:funzone/screens/loadingscreen.dart';
import 'package:funzone/widgets/chatheads.dart';

class WaitingLobby extends StatefulWidget {
  const WaitingLobby({Key? key}) : super(key: key);

  @override
  _WaitingLobbyState createState() => _WaitingLobbyState();
}

class _WaitingLobbyState extends State<WaitingLobby> {
  FirebaseHelper firebaseHelper = FirebaseHelper();
  late QuerySnapshot blogSnapshot;
  bool loaded = false;

  @override
  void initState() {
    firebaseHelper.getusers().then((result) {
      blogSnapshot = result;

      print(result.docs[0].get("uploadedImgUrl").toString());
      setState(() {
        loaded = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlueAccent,
          title: Text('Waiting Lobby'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Customize(),
              ));
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.logout_rounded),
              onPressed: () {
                firebaseHelper.logout();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyApp(),
                    ));
              },
            )
          ],
        ),
        body: !loaded
            ? LoadingIndicator()
            : ListView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                itemCount: blogSnapshot.docs.length,
                itemBuilder: (context, index) {
                  return ChatHeads(
                    blogSnapshot.docs[index].get("username"),
                    blogSnapshot.docs[index].get("email"),
                    blogSnapshot.docs[index].get("about"),
                    blogSnapshot.docs[index].get("uploadedImgUrl"),
                    blogSnapshot.docs[index].get("uid"),
                    blogSnapshot.docs[index].id,
                  );
                }));
  }
}
