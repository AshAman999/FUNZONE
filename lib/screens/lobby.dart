import 'package:flutter/material.dart';

class WaitingLobby extends StatelessWidget {
  const WaitingLobby({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.person),
                Text("Dr Krishna Kumar"),
                Row(
                  children: [
                    Icon(Icons.person_add),
                    Icon(Icons.block),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
