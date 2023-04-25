import 'package:flutter/material.dart';

class notifications extends StatefulWidget {
  @override
  State<notifications> createState() => _notificationsState();
}

class _notificationsState extends State<notifications> {
  @override
  var notification = [
    {
      "head" : "Welcome Note",
      "body" : "Welcome to new application of The Gurugram Police. This application is developed by a team of students who are doing engineering in B.Tech CSE at BML Munjal University. Hope you guys like this application."
    }
  ];
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                IconButton(
                    onPressed: (){
                      Navigator.pop(context);
                    }, icon: const Icon(Icons.arrow_back_ios_new,
                  color: Colors.black,)),
              ],
            ),
            const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 25,top: 15),
                child: Text("Notifications", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
              ),
            ),
          ]
        ),
      ),
    );
  }
}
