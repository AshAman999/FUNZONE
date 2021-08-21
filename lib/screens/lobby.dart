import 'package:flutter/material.dart';
import 'package:funzone/screens/custimize.dart';
import 'package:sizer/sizer.dart';

class WaitingLobby extends StatelessWidget {
  const WaitingLobby({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 15.w,
        title: Text("7594fh3"),
        leading: Icon(Icons.backspace_rounded),
        actions: [
          Icon(Icons.notification_add),
          Icon(Icons.message),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Customize(),
                ));
              },
              child: Container(
                margin: EdgeInsets.only(top: 0.3.h),
                color: Colors.lightBlueAccent,
                height: 10.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(child: Icon(Icons.person)),
                    Text("Dr Krishna Kumar"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.person_add),
                        Icon(Icons.block),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
