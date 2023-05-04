import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:haryana_police_department/screens/to_approve_user.dart';
import 'package:haryana_police_department/ui_helper/leaves.dart';
// import 'package:haryana_police_department/screens/to_approve_user.dart';

class my_leaves extends StatefulWidget {  @override
  State<StatefulWidget> createState() => my_leavesstate();
}

class my_leavesstate extends State<my_leaves> {
  late List<Map<String, dynamic>> leaves;
  late Map<String, dynamic> applicants;
  late String test;
  late final UIDs;
  late final Names;
  late final Posts;
  late final Leave_IDs;
  late final myOIDa;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    print(height);

    return Material(
        child: SingleChildScrollView(
          child:
          Column(
            children: [
              FutureBuilder(
                future: _fetch_details(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return const Text("");
                  }
                  if(snapshot.hasData) {
                    return ListView.separated(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: ((context, index){
                        var leaveStart = (leaves[index]["leave_start"] as Timestamp).toDate();
                        var leaveStart2 = DateFormat('dd/MM/yyyy').format(leaveStart);
                        var leaveEnd = (leaves[index]["leave_end"] as Timestamp).toDate();
                        var leaveEnd2 = DateFormat('dd/MM/yyyy').format(leaveEnd);
                        return Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black12,
                                    spreadRadius: 1,
                                    blurRadius: 1,
                                    blurStyle: BlurStyle.outer
                                )
                              ]
                          ),
                          child: ListTile(
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                Row(
                                  children: const [
                                    Text("Type", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                  ],
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Row(
                                    children: [
                                      Text(leaves[index]["leave_type"],  style: const TextStyle(fontSize: 16),),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: const [
                                    Text("Reason",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                  ],
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(leaves[index]["leave_reason"],  style: const TextStyle(fontSize: 16),),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: const [
                                    Text("Leave Period",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                  ],
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Row(
                                    children: [
                                      Text("$leaveStart2 to $leaveEnd2", style: const TextStyle(fontSize: 16),),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: const [
                                    Text("Status", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                  ],
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Row(
                                    children: [
                                      Text(leaves[index]["status"], style: const TextStyle(fontSize: 16),),
                                    ],
                                  ),
                                ),
                              ],)
                          ),
                        );
                      }),
                      itemCount: leaves.length,
                      separatorBuilder: (context, index) {
                        return const Divider(height: 10, thickness: 0,color: Colors.white,);
                      },
                    );
                  }
                  return const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text("No leave applied yet."),
                  );
                },
              ),

            ],
          ),
        )
    );
  }

  Future<List<Map<String, dynamic>>> _fetch_details() async {
    leaves = (await RestService.getMyLeaves())!;
    // print(leaves[0]["leave_id"]);
    // print("type:");
    // print(leaves[0]["leave_type"]);
    // print("Reason:");
    // print(leaves[0]["leave_reason"]);
    // print("Period:");
    // print(leaves[0]["leave_end"]);
    // print("Status:");
    // print(leaves[0]["status"]);
    final firebaseUser = await FirebaseAuth.instance.currentUser!;
    // print(leaves);
    return leaves;
  }

}