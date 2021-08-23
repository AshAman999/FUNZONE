import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DetailsPage extends StatelessWidget {
  DetailsPage(
      this.name, this.email, this.about, this.imageurl, this.age, this.gender);
  final String name, email, about, imageurl, age, gender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: Text(" Profile"),
        actions: [
          // GestureDetector(
          //   child: Center(
          //     child: Container(
          //         padding: EdgeInsets.symmetric(horizontal: 5),
          //         child: Text(
          //           "Skip",
          //           style: TextStyle(fontSize: 12.sp, color: Colors.white),
          //         )),
          //   ),
          //   onTap: () {
          //     Navigator.pushReplacement(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => WaitingLobby(),
          //       ),
          //     );
          //   },
          // )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(20),
                ),
                Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[300],
                    ),
                    height: 30.h,
                    width: 35.w,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(imageurl),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Name",
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: Colors.lightBlueAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                CupertinoTextField(
                    enabled: false,
                    autocorrect: false,
                    textCapitalization: TextCapitalization.words,
                    placeholder: name,
                    onChanged: (value) {
                      // name = value;
                    }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Email",
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: Colors.lightBlueAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                CupertinoTextField(
                    enabled: false,
                    placeholder: email,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      // email = value;
                    }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          "Age",
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: Colors.lightBlueAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          width: 15.w,
                          child: CupertinoTextField(
                              enabled: false,
                              placeholder: age,
                              maxLength: 3,
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                // age = value;
                              }),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "Gender",
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: Colors.lightBlueAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          width: 15.w,
                          child: CupertinoTextField(
                              enabled: false,
                              placeholder: gender,
                              autofillHints: [],
                              maxLength: 1,
                              keyboardType: TextInputType.text,
                              onChanged: (value) {
                                // gender = value;
                              }),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "About",
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: Colors.lightBlueAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                CupertinoTextField(
                    //remove the border
                    enabled: false,
                    textCapitalization: TextCapitalization.words,
                    placeholder: about,
                    maxLines: 5,
                    onChanged: (value) {
                      // about = value;
                    }),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 1.h),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
