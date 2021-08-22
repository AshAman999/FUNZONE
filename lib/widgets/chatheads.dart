import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:funzone/screens/chatpage.dart';
import 'package:funzone/screens/custimize.dart';
import 'package:sizer/sizer.dart';

class ChatHeads extends StatelessWidget {
  ChatHeads(this.name, this.email, this.imgurl, this.about, this.uid, this.id);
  final String name, uid, email, imgurl, about, id;
  String chatRoomId(String user1, String user2) {
    if (user1[0].toLowerCase().codeUnits[0] >
        user2.toLowerCase().codeUnits[0]) {
      return "$user1$user2";
    } else {
      return "$user2$user1";
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, String> userMap = {
      "uid": uid,
      "name": name,
    };
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Customize(),
            ));
          },
          child: GestureDetector(
            onTap: () {
              String roomId = chatRoomId(
                  FirebaseAuth.instance.currentUser!.displayName!, name);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ChatRoom(
                    chatRoomId: roomId,
                    userMap: userMap,
                  ),
                ),
              );
            },
            child: Container(
              
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              margin: EdgeInsets.only(top: 1.2.h),
              height: 15.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 8.w),
                    child:
                        CircleAvatar(child: Image(image: NetworkImage(imgurl))),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          FirebaseAuth.instance.currentUser!.uid == uid? "You":name,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          "How is it Going",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 20,
                              fontWeight: FontWeight.normal),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.person_add,
                        size: 30,
                        color: Colors.green,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 1.w),
                      ),
                      Icon(
                        Icons.delete_forever,
                        color: Colors.red,
                        size: 30,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
