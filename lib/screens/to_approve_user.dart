// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_typing_uninitialized_variables, duplicate_ignore
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:haryana_police_department/screens/notifications.dart';
import 'package:haryana_police_department/screens/transfer.dart';

import '../ui_helper/leaves.dart';

// ignore: must_be_immutable
class to_approve_user extends StatefulWidget {
  // ignore: non_constant_identifier_names
  String leave_ind;
  to_approve_user(
      this.leave_ind,
      {super.key});
  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() => to_approve_userState(leave_ind);
}

class to_approve_userState extends State<to_approve_user> {

  String leave_ind;
  to_approve_userState(
      this.leave_ind,);
  late Map<String, dynamic> myData;
  late final UIDs;
  late final Leaves;
  late Map<String, dynamic> myUser;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
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
                Expanded(child: Container(height: 5,)),
                IconButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => notifications(),));
                  },
                    icon: const Icon(Icons.notifications_none_rounded)
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ), // Top icons
            const SizedBox(
              height: 10,
            ),
            Flexible(
              child: Padding (
                padding: const EdgeInsets.only(left: 25,right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:   [
                    Flexible(
                        fit: FlexFit.tight,
                        child: Column(
                          children: [

                            FutureBuilder(
                              future: _fetch_user(),
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
                                    title: Text(myUser["name"].toString(), style: const TextStyle(fontSize: 20),),
                                    subtitle: Text(myUser["post"].toString()),
                                  );
                                }
                                return Container();
                              },
                            ),


                            const SizedBox(
                              height: 20,
                            ),

                            FutureBuilder(
                              future: _fetch_data(),
                              builder:
                                  (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                                if (snapshot.connectionState != ConnectionState.done) {
                                  return const Text("");
                                }
                                if(snapshot.hasData) {
                                  var leaveStart = (myData["leave_start"] as Timestamp).toDate();
                                  var leaveStart2 = DateFormat('dd/MM/yyyy').format(leaveStart);
                                  var leaveEnd = (myData["leave_end"] as Timestamp).toDate();
                                  var leaveEnd2 = DateFormat('dd/MM/yyyy').format(leaveEnd);
                                  var to = DateTime(leaveEnd.year, leaveEnd.month, leaveEnd.day);
                                  var from = DateTime(leaveStart.year, leaveStart.month, leaveStart.day);
                                  int period = (to.difference(from).inHours/24).round()+1;
                                  print(period);
                                  return Padding(
                                    padding: const EdgeInsets.only(left: 15, right: 15),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: SingleChildScrollView(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text("Type:",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            Text(myData["leave_type"].toString(), style: const TextStyle(fontSize: 16),),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            const Text("Reason:",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            Text(myData["leave_reason"].toString(), style: const TextStyle(fontSize: 16),),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            const Text("Leave period:",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            Text("$leaveStart2 to $leaveEnd2", style: const TextStyle(fontSize: 16),),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            const SizedBox(
                                              height: 50,
                                            ),
                                            InkWell(
                                              onTap: (){
                                                showDialog(
                                                    context: context,
                                                    builder: (context){
                                                      return Container(
                                                        color: const Color.fromARGB(100, 22, 44, 33),
                                                        child: AlertDialog(
                                                          title: const Text("Are you sure you want to approve?"),
                                                          actions: [
                                                            TextButton(
                                                                onPressed: (){
                                                                  Navigator.pop(context);
                                                                  _approve_leave(period);
                                                                  showDialog(
                                                                      context: context,
                                                                      builder: (context){
                                                                        return Container(
                                                                          color: const Color.fromARGB(100, 22, 44, 33),
                                                                          child: AlertDialog(
                                                                            title: const Text("Approved"),
                                                                            actions: [
                                                                              TextButton(
                                                                                  onPressed: (){
                                                                                    Navigator.pop(context);
                                                                                    Navigator.pop(context);
                                                                                  },
                                                                                  child: const Text("Ok"))
                                                                            ],
                                                                          ),
                                                                        );
                                                                      });
                                                                },
                                                                child: const Text("Yes")),
                                                            TextButton(
                                                                onPressed: (){
                                                                  Navigator.pop(context);
                                                                },
                                                                child: const Text("No"))
                                                          ],
                                                        ),
                                                      );
                                                    });
                                              },
                                              child: Container(
                                                width: double.infinity,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                    color: const Color(0xFF2F3374),
                                                    borderRadius: BorderRadius.circular(20)
                                                ),
                                                child: const Center(child: Text("Approve", style: TextStyle(color: Colors.white, fontSize: 17,fontWeight: FontWeight.bold),),),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            InkWell(
                                              onTap: (){
                                                showDialog(
                                                    context: context,
                                                    builder: (context){
                                                      return Container(
                                                        color: const Color.fromARGB(100, 22, 44, 33),
                                                        child: AlertDialog(
                                                          title: const Text("Are you sure you want to deny?"),
                                                          actions: [
                                                            TextButton(
                                                                onPressed: (){
                                                                  _deny_leave();
                                                                  Navigator.pop(context);
                                                                  showDialog(
                                                                      context: context,
                                                                      builder: (context){
                                                                        return Container(
                                                                          color: const Color.fromARGB(100, 22, 44, 33),
                                                                          child: AlertDialog(
                                                                            title: const Text("Denied"),
                                                                            actions: [
                                                                              TextButton(
                                                                                  onPressed: (){
                                                                                    Navigator.pop(context);
                                                                                    Navigator.pop(context);
                                                                                  },
                                                                                  child: const Text("Ok"))
                                                                            ],
                                                                          ),
                                                                        );
                                                                      });
                                                                },
                                                                child: const Text("Yes")),
                                                            TextButton(
                                                                onPressed: (){
                                                                  Navigator.pop(context);
                                                                },
                                                                child: const Text("No"))
                                                          ],
                                                        ),
                                                      );
                                                    });
                                              },
                                              child: Container(
                                                width: double.infinity,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                    color: const Color(0xFF682242),
                                                    borderRadius: BorderRadius.circular(20)
                                                ),
                                                child: const Center(child: Text("Deny", style: TextStyle(color: Colors.white, fontSize: 17,fontWeight: FontWeight.bold),),),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            InkWell(
                                              onTap: (){
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => transfer(leave_ind),)); //leave_ind
                                              },
                                              child: Container(
                                                width: double.infinity,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                    color: const Color(0xFFF3F3F3),
                                                    borderRadius: BorderRadius.circular(20)
                                                ),
                                                child: const Center(child: Text("Transfer", style: TextStyle(color: Colors.black, fontSize: 17,fontWeight: FontWeight.bold),),),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                return Container();
                              },
                            ),

                          ],
                        )
                    ),
                  ],
                ),
              ),
            )
        ]
    ),
      )
    );
  }


  _fetch_data() async{
    final firebaseUser = await FirebaseAuth.instance.currentUser!;
    if(firebaseUser != null){
      await FirebaseFirestore.instance
          .collection("leave_application")
          .doc(leave_ind)
          .get()
          .then((ds){
        myData = ds.data()!;
      });
    }
    return myData;
  }

  _fetch_user() async{
    UIDs = await RestService.getthisUID(leave_ind);
    print("object");
    print(UIDs);
    final firebaseUser = await FirebaseAuth.instance.currentUser!;
    if(firebaseUser != null){
      await FirebaseFirestore.instance
          .collection("users")
          .doc(UIDs["applicant_uid"])
          .get()
          .then((ds){
        myUser = ds.data()!;
      });
    }
    return myUser;
  }

  _approve_leave(period) async{
    Leaves = await RestService.getthisCLleaves(leave_ind);
    int cl = Leaves["cl_used"];
    num cl_update = cl + period;
    final firebaseUser = await FirebaseAuth.instance.currentUser!;
    if(firebaseUser != null){
      await FirebaseFirestore.instance
          .collection("leaves")
          .doc(UIDs["applicant_uid"])
          .update({"cl_used":cl_update});
    }
    if(firebaseUser != null){
      await FirebaseFirestore.instance
          .collection("leave_application")
          .doc(leave_ind)
          .update({"status":"approved"});
    }
  }

  _deny_leave() async{
    final firebaseUser = await FirebaseAuth.instance.currentUser!;
    if(firebaseUser != null){
      await FirebaseFirestore.instance
          .collection("leave_application")
          .doc(leave_ind)
          .update({"status":"denied"});
    }
  }
}
