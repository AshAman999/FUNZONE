import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:funzone/screens/lobby.dart';
import 'package:funzone/screens/loginpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

String publicKey = "";
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    getPublicKey();
    var currentUser = FirebaseAuth.instance.currentUser;
    print(publicKey + "public key");
    return Sizer(builder: (context, orientation, deviceType) {
      print(publicKey + 'one loading of user');
      return MaterialApp(
        title: 'Fun Zone ',
        debugShowCheckedModeBanner: false,
        // home: MyHomePage(title: 'A clutter free social media'),
        home: (currentUser != null)
            ? WaitingLobby(
                publickey: publicKey.toString(),
              )
            : LoginScreen(),
      );
    });
  }
}

Future<void> getPublicKey() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  var publicKey2 = prefs.getString('publicKey');
  print(publicKey2);
  if (publicKey2 == null) {
    publicKey = "";
  } else {
    publicKey = publicKey2;
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: GestureDetector(
            onTap: () {
              print(publicKey + 'click on ontap');
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => WaitingLobby(
                  publickey: getPublicKey().toString(),
                ),
              ));
            },
            child: Center(child: Text("Logged In"))),
      ),
    );
  }
}

