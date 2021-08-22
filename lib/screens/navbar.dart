import 'package:flutter/material.dart';
import 'package:funzone/apis/firebaseapi.dart';
import 'package:funzone/main.dart';
import 'package:funzone/screens/custimize.dart';

FirebaseHelper firebaseHelper = FirebaseHelper();

class NavDrawer extends StatelessWidget {
  final String imgurl;
  NavDrawer(this.imgurl);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Fun Zone 💬',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
                color: Colors.lightBlueAccent,
                image: DecorationImage(
                    fit: BoxFit.fill, image: NetworkImage(imgurl))),
          ),
          ListTile(
            leading: Icon(Icons.input),
            title: Text('Welcome'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('Profile'),
            onTap: () => {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Customize(),
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
