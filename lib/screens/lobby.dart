import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:funzone/apis/firebaseapi.dart';
import 'package:funzone/main.dart';
import 'package:funzone/screens/custimize.dart';
import 'package:funzone/screens/loadingscreen.dart';
import 'package:funzone/screens/navbar.dart';
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
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var stream;
  @override
  void initState() {
    stream = _firestore.collection('users').snapshots();
    setState(() {
      loaded = true;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(imageurl),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent,
        title: Text('Fun Zone   💬'),
        foregroundColor: Colors.lightBlueAccent,

        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back),
        //   onPressed: () {
        //     Navigator.of(context).push(MaterialPageRoute(
        //       builder: (context) => Customize(),
        //     ));
        //   },
        // ),
      ),
      body: !loaded
          ? LoadingIndicator()
          : StreamBuilder<QuerySnapshot>(
              stream: stream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                return snapshot.data == null
                    ? LoadingIndicator()
                    : ListView.builder(
                        physics: BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return ChatHeads(
                            snapshot.data!.docs[index].get("username"),
                            snapshot.data!.docs[index].get("email"),
                            snapshot.data!.docs[index].get("uploadedImgUrl"),
                            snapshot.data!.docs[index].get("about"),
                            snapshot.data!.docs[index].get("uid"),
                            snapshot.data!.docs[index].id,
                            // blogSnapshot.docs[index].id,
                          );
                        });
              },
            ),
    );
  }
}
