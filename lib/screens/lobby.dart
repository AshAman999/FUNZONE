import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:funzone/apis/firebaseapi.dart';
import 'package:funzone/screens/customize.dart';
import 'package:funzone/screens/loadingscreen.dart';
import 'package:funzone/widgets/navbar.dart';
import 'package:funzone/widgets/chatheads.dart';

class WaitingLobby extends StatefulWidget {
  final String publickey;
  const WaitingLobby({required this.publickey, Key? key}) : super(key: key);

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
    stream = _firestore.collection("users").snapshots();
    setState(
      () {
        loaded = true;
      },
    );
    //  = GlobalKey(); // Create a key
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(imageurl, name, widget.publickey),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'Fun Zone 💬',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        // foregroundColor: Colors.transparent,
        leading: InkWell(
          onTap: () {
            Scaffold.of(context).openDrawer();
          },
          child: Icon(
            Icons.menu,
            // size: appBarMenuIconSize,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/66.jpg"),
          fit: BoxFit.cover,
        )),
        child: !loaded
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
                            print(snapshot.data!.docs[index].get("publicKey"));
                            return snapshot.data!.docs[index].get("uid") !=
                                    FirebaseAuth.instance.currentUser!.uid
                                ? ChatHeads(
                                    snapshot.data!.docs[index].get("username"),
                                    snapshot.data!.docs[index].get("email"),
                                    snapshot.data!.docs[index]
                                        .get("uploadedImgUrl"),
                                    snapshot.data!.docs[index].get("about"),
                                    snapshot.data!.docs[index].get("uid"),
                                    snapshot.data!.docs[index].get("age"),
                                    snapshot.data!.docs[index].get("gender"),
                                    snapshot.data!.docs[index].id,
                                    snapshot.data!.docs[index].get("publicKey"),
                                    // blogSnapshot.docs[index].id,
                                  )
                                : Container();
                          },
                        );
                },
              ),
      ),
    );
  }
}
