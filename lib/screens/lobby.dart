import 'package:flutter/material.dart';
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
            Container(
              margin: EdgeInsets.only(top: 0.3.h),
              color: Colors.lightBlueAccent,
              height: 10.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      padding: EdgeInsets.only(left: 8.w),
                      child: Icon(Icons.person)),
                  Text("Dr Krishna Kumar"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.person_add),
                      SizedBox(width: 10),
                      Icon(Icons.block),
                    ],
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 0.3.h),
              color: Colors.lightBlueAccent,
              height: 10.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      padding: EdgeInsets.only(left: 8.w),
                      child: Icon(Icons.person)),
                  Text("Dr Krishna Kumar"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.person_add),
                      SizedBox(width: 10),
                      Icon(Icons.block),
                    ],
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 0.3.h),
              color: Colors.lightBlueAccent,
              height: 10.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      padding: EdgeInsets.only(left: 8.w),
                      child: Icon(Icons.person)),
                  Text("Dr Krishna Kumar"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.person_add),
                      SizedBox(width: 10),
                      Icon(Icons.block),
                    ],
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 0.3.h),
              color: Colors.lightBlueAccent,
              height: 10.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      padding: EdgeInsets.only(left: 8.w),
                      child: Icon(Icons.person)),
                  Text("Dr Krishna Kumar"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.person_add),
                      SizedBox(width: 10),
                      Icon(Icons.block),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
