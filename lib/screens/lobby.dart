import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
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
  GlobalKey<ScaffoldState> _key = GlobalKey();

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
      drawer: NavDrawer(imageurl, name, widget.publickey, _key),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Neumorphic(
          padding: EdgeInsets.all(10),
          style: NeumorphicStyle(
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(20)),
            depth: -5,
            color: Colors.white,
          ),
          child: Text(
            'Fun Zone 💬',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        leading: Neumorphic(
          margin: EdgeInsets.all(5),
          style: NeumorphicStyle(
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(20)),
            depth: 10,
            color: Colors.white,
          ),
          child: IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.black,
            ),
            onPressed: () {
              //
              Scaffold.of(context).openDrawer();
            },
          ),
        ),

        // foregroundColor: Colors.transparent,
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
                                ? Neumorphic(
                                    child: ChatHeads(
                                      name: snapshot.data!.docs[index]
                                          .get("username"),
                                      email: snapshot.data!.docs[index]
                                          .get("email"),
                                      imgurl: snapshot.data!.docs[index]
                                          .get("uploadedImgUrl"),
                                      about: snapshot.data!.docs[index]
                                          .get("about"),
                                      uid:
                                          snapshot.data!.docs[index].get("uid"),
                                      age:
                                          snapshot.data!.docs[index].get("age"),
                                      gender: snapshot.data!.docs[index]
                                          .get("gender"),
                                      id: snapshot.data!.docs[index].id,
                                      publicKey: snapshot.data!.docs[index]
                                          .get("publicKey"),
                                      // blogSnapshot.docs[index].id,
                                    ),
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
