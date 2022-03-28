import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:funzone/screens/Detailspage.dart';
import 'package:funzone/screens/chatpage.dart';
import 'package:sizer/sizer.dart';

class ChatHeads extends StatelessWidget {
  final String name, email, age, gender, imgurl, about, uid, id, publicKey;
  ChatHeads(this.name, this.email, this.imgurl, this.about, this.uid, this.id,
      this.age, this.gender, this.publicKey);
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
      "publicKey": publicKey,
    };
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            String roomId =
                chatRoomId(FirebaseAuth.instance.currentUser!.uid, uid);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => ChatRoom(
                  chatRoomId: roomId,
                  userMap: userMap,
                  url: imgurl,
                  publicKey: publicKey,
                ),
              ),
            );
          },
          child: Neumorphic(
            margin: EdgeInsets.symmetric(vertical: 1.h, horizontal: 1.h),
            padding: EdgeInsets.all(10),
            style: NeumorphicStyle(
              boxShape: NeumorphicBoxShape.roundRect(
                BorderRadius.circular(10),
              ),
              depth: -5,
              color: Colors.white,
              shape: NeumorphicShape.concave,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsPage(
                          name,
                          email,
                          about,
                          imgurl,
                          gender,
                          age,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 5.w),
                    width: 50.0,
                    height: 50.0,

                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(imgurl),
                      ),
                    ),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(imgurl),
                    ),
                    // child: Icon(Icons.person, color: Colors.lightBlueAccent),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Neumorphic(
                        padding: EdgeInsets.all(5),
                        child: Text(
                          FirebaseAuth.instance.currentUser!.uid == uid
                              ? "You"
                              : name,
                          style: TextStyle(
                            color: Colors.lightBlueAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Neumorphic(
                        // padding: EdgeInsets.all(2),
                        style: NeumorphicStyle(
                          boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(10),
                          ),
                          depth: -5,
                          color: Colors.white,
                          shape: NeumorphicShape.concave,
                        ),

                        child: Text(
                          "Tap to send a message",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 20,
                              fontWeight: FontWeight.normal),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 4.w,
                ),
                NeumorphicIcon(
                  Icons.message,
                  size: 30,
                  style: NeumorphicStyle(
                    color: Colors.lightBlueAccent,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
