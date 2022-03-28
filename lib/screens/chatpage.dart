import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypton/crypton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:shared_preferences/shared_preferences.dart';

String privateKey = '';
String userPublicKey = '';

class ChatRoom extends StatelessWidget {
  final Map<String, dynamic>? userMap;
  final String? chatRoomId;
  final String? url;
  final String publicKey;

  ChatRoom({this.chatRoomId, this.userMap, this.url, required this.publicKey});

  final TextEditingController _message = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> getPrivateKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var key = await prefs.getString('privateKey').toString();
    var key2 = await prefs.getString('publicKey').toString();
    privateKey = key;
    userPublicKey = key2;
  }

  void onSendMessage(String publicKey) async {
    print(publicKey + 'its the pkey');
    String encrypted_messages = await RSAPublicKey.fromString(publicKey)
        .encrypt(_message.text)
        .toString();
    String encrypted_messages_for_sender =
        await RSAPublicKey.fromString(userPublicKey)
            .encrypt(_message.text)
            .toString();
    print(encrypted_messages);
    if (_message.text.isNotEmpty) {
      Map<String, dynamic> messages = {
        "sendby": _auth.currentUser!.displayName,
        "message": encrypted_messages,
        "message_for_sender": encrypted_messages_for_sender,
        "time": FieldValue.serverTimestamp(),
      };

      _message.clear();
      await _firestore
          .collection('chatroom')
          .doc(chatRoomId)
          .collection('chats')
          .add(messages);
    } else {
      print("Enter Some Text");
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final _controller = ScrollController();
    getPrivateKey();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: StreamBuilder<DocumentSnapshot>(
          stream:
              _firestore.collection("users").doc(userMap!['uid']).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              return Container(
                child: Row(
                  children: [
                    Neumorphic(
                      style: NeumorphicStyle(
                        boxShape: NeumorphicBoxShape.circle(),
                        depth: 10,
                        color: Colors.white,
                      ),
                      margin: EdgeInsets.all(8),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          url.toString(),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Neumorphic(
                      padding: EdgeInsets.all(10),
                      style: NeumorphicStyle(
                        boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(10),
                        ),
                        depth: -5,
                        color: Colors.lightBlueAccent,
                      ),
                      child: Text(
                        userMap!['name'],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Container();
            }
          },
        ),
        leading: Neumorphic(
          margin: EdgeInsets.all(8),
          style: NeumorphicStyle(
            boxShape: NeumorphicBoxShape.circle(),
            depth: -10,
            color: Colors.lightBlueAccent,
          ),
          child: BackButton(
            color: Colors.white,
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/back_ground.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              height: size.height / 1.3,
              width: size.width,
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore
                    .collection('chatroom')
                    .doc(chatRoomId)
                    .collection('chats')
                    .orderBy("time", descending: false)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.data != null) {
                    Timer(
                      Duration(milliseconds: 100),
                      () => _controller
                          .jumpTo(_controller.position.maxScrollExtent),
                    );

                    return ListView.builder(
                      physics: BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      controller: _controller,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> map = snapshot.data!.docs[index]
                            .data() as Map<String, dynamic>;
                        return messages(size, map);
                      },
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
            Container(
              height: size.height / 10,
              width: size.width,
              alignment: Alignment.center,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                height: size.height / 12,
                width: size.width / 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: size.height / 17,
                      width: size.width / 1.3,
                      child: Neumorphic(
                        child: TextField(
                          controller: _message,
                          decoration: InputDecoration(
                              hintText: "Send Message",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              )),
                        ),
                      ),
                    ),
                    Container(
                      child: IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () {
                          onSendMessage(publicKey);
                        },
                        color: Colors.lightBlueAccent,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget messages(Size size, Map<String, dynamic> map) {
    return Container(
      width: size.width,
      alignment: map['sendby'] == _auth.currentUser!.displayName
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: map['sendby'] == _auth.currentUser!.displayName
              ? Colors.lightBlueAccent
              : Colors.grey[400],
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 5), // changes position of shadow
            ),
          ],
        ),
        child: Text(
          map['sendby'] != _auth.currentUser!.displayName
              ? RSAPrivateKey.fromString(privateKey)
                  .decrypt(
                    map['message'],
                  )
                  .toString()
              : RSAPrivateKey.fromString(privateKey)
                  .decrypt(
                    map['message_for_sender'],
                  )
                  .toString(),
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}




/// this is it