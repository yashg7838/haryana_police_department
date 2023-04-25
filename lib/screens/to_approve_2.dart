import 'package:flutter/material.dart';
import 'package:haryana_police_department/screens/to_approve_user.dart';
import 'notifications.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:haryana_police_department/ui_helper/leaves.dart';

class to_approve_2 extends StatefulWidget {
  const to_approve_2({super.key});
  @override
  State<StatefulWidget> createState() => to_approveState_2();
}

class to_approveState_2 extends State<to_approve_2> {
  @override
  late Map<String, dynamic> leaves;
  late Map<String, dynamic> applicants;
  late String test;

  Widget build(BuildContext context) {
    // FutureBuilder<dynamic>(
    //     future: _fetch_details(),
    //     builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
    //       test = leaves["leave_reason"].toString();
    //       print("test: $test");
    //       return Container();
    //     }
    // );

    initState(){
      super.initState();
      FutureBuilder<dynamic>(
          future: _fetch_details(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
            if(snapshot.hasData) {
              test = leaves["name"].toString();
              print("test: $test");
            }
            return Container();
          }
      );
    };

    initState();

    return Material(
        child: Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            InkWell(
              onTap: () {
                setState(() {});
              },
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
                  decoration: BoxDecoration(
                      // color: Colors.black,
                      color: const Color(0xFFF3F3F3),
                      borderRadius: BorderRadius.circular(20)),
                  height: 35,
                  width: 80,
                  child: const Center(
                      child: Text(
                    "Refresh",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                ),
              ),
            ), // Refresh button
            SizedBox(
                child: Column(
              children: [
                FutureBuilder(
                  future: _fetch_details(),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.connectionState != ConnectionState.done) {
                      return const Text("");
                    }
                    if(snapshot.hasData) {
                      return ListTile(
                        leading: const Icon(
                          Icons.supervised_user_circle,
                          size: 60,
                          color: Colors.black,
                        ),
                        title: Text(
                          leaves["name"].toString(),
                          style: const TextStyle(color: Colors.black),
                        ),
                        subtitle: Text(
                          leaves["post"].toString(),
                          style: const TextStyle(color: Colors.grey),
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => notifications(),
                                ));
                          },
                          icon: const Icon(
                            Icons.notifications_active_outlined,
                            size: 25,
                            color: Colors.white,
                          ),
                        ),
                      );
                    }
                    return Container();
                  },
                ),
              ],
            ))
          ],
        ),
      ),
    ));
  }

  Future <Map<String,dynamic>> _fetch_details() async {
    final lst = await RestService.getData();
    final firebaseUser = await FirebaseAuth.instance.currentUser!;
    if (firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(lst[0].applicant_uid.toString())
          .get()
          .then((ds) {
            print(ds);
        leaves = ds.data()!;
      });
    }
    print(leaves);
    return leaves;
  }
}
