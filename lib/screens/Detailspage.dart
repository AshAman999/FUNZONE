import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:sizer/sizer.dart';

class DetailsPage extends StatelessWidget {
  DetailsPage(
      {required this.name, required this.email, required this.about, required this.imageurl, required this.age, required this.gender});
  final String name, email, about, imageurl, age, gender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent,
        title: Neumorphic(
          padding: EdgeInsets.all(10),
          style: NeumorphicStyle(
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
            depth: -5,
            color: Colors.lightBlueAccent,
          ),
          child: Text(
            " Profile",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
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
                  ),
                ),
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
                Neumorphic(
                  child: CupertinoTextField(
                    enabled: false,
                    autocorrect: false,
                    textCapitalization: TextCapitalization.words,
                    placeholder: name,
                  ),
                ),
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
                Neumorphic(
                  child: CupertinoTextField(
                    enabled: false,
                    placeholder: email,
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
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
                          child: Neumorphic(
                            child: CupertinoTextField(
                              enabled: false,
                              placeholder: age,
                              maxLength: 3,
                              keyboardType: TextInputType.number,
                            ),
                          ),
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
                          child: Neumorphic(
                            child: CupertinoTextField(
                              enabled: false,
                              placeholder: gender,
                              autofillHints: [],
                              maxLength: 1,
                              keyboardType: TextInputType.text,
                            ),
                          ),
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
                Neumorphic(
                  child: CupertinoTextField(
                    enabled: false,
                    textCapitalization: TextCapitalization.words,
                    placeholder: about,
                    maxLines: 5,
                  ),
                ),
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
