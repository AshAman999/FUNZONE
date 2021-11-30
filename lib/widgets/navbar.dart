import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:funzone/apis/firebaseapi.dart';
import 'package:funzone/main.dart';
import 'package:funzone/screens/customize.dart';

FirebaseHelper firebaseHelper = FirebaseHelper();

class NavDrawer extends StatelessWidget {
  final String imgurl;
  final String name;
  final String publicKey;

  NavDrawer(this.imgurl, this.name, this.publicKey);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              ' ',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
            decoration: BoxDecoration(
              color: Colors.lightBlueAccent,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                    FirebaseAuth.instance.currentUser!.photoURL.toString()),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.input),
            title:
                Text(FirebaseAuth.instance.currentUser!.displayName.toString()),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.email),
            title: Text(FirebaseAuth.instance.currentUser!.email.toString()),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('Edit Profile'),
            onTap: () => {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Customize(
                    publickey: publicKey,
                  ),
                ),
              ),
            },
          ),
          // ListTile(
          //   leading: Icon(Icons.settings),
          //   title: Text('Settings'),
          //   onTap: () => {Navigator.of(context).pop()},
          // ),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('Feedback'),
            onTap: () => {
              // mail to my email adress
              Navigator.of(context).pop()
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => {
              firebaseHelper.logout(),
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MyApp(),
                ),
              ),
            },
          ),
        ],
      ),
    );
  
  }
}
