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
  late final UIDs;
  late final Names;
  late final Posts;
  late final Leave_IDs;
  late final myOIDa;

  Widget build(BuildContext context) {


    return Material(
        child: Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: () {
                  setState(() {});
                },
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
            const SizedBox(
              height: 20,
            ),
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
                      return ListView.separated(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: ((context, index){
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
                                leading: const Icon(
                                  Icons.supervised_user_circle,
                                  size: 40,
                                  color: Colors.black,
                                ),
                                title: Text(Names[index].toString(), style: const TextStyle(fontSize: 20),),
                                subtitle: Text(Posts[index].toString()),
                                trailing: IconButton(
                                  onPressed: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => to_approve_user(Leave_IDs[index],),));
                                  },
                                  icon: const Icon(Icons.open_in_new_outlined),
                                  color: Colors.black,
                                )
                            ),
                          );
                        }),
                        itemCount: Names.length,
                        separatorBuilder: (context, index) {
                          return const Divider(height: 10, thickness: 0,color: Colors.white,);
                        },
                      );
                    }
                    return Container();
                  },
                ),


                // FutureBuilder(
                //   future: _fetch_details(),
                //   builder:
                //       (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                //     if (snapshot.connectionState != ConnectionState.done) {
                //       return const Text("");
                //     }
                //     if(snapshot.hasData) {
                //         return ListTile(
                //           leading: const Icon(
                //             Icons.supervised_user_circle,
                //             size: 60,
                //             color: Colors.black,
                //           ),
                //           title: Text(
                //             Names[0].toString(),
                //             style: const TextStyle(color: Colors.black),
                //           ),
                //           subtitle: Text(
                //             Posts[0].toString(),
                //             style: const TextStyle(color: Colors.grey),
                //           ),
                //           trailing: IconButton(
                //             onPressed: () {
                //               Navigator.push(
                //                   context,
                //                   MaterialPageRoute(
                //                     builder: (context) => notifications(),
                //                   ));
                //             },
                //             icon: const Icon(
                //               Icons.notifications_active_outlined,
                //               size: 25,
                //               color: Colors.white,
                //             ),
                //           ),
                //         );
                //       }
                //     return Container();
                //   },
                // ),
              ],
            ))
          ],
        ),
      ),
    ));
  }

  Future <Map<String,dynamic>> _fetch_details() async {
    UIDs = await RestService.getUID();
    Names = await RestService.getName();
    Posts = await RestService.getPosts();
    Leave_IDs = await RestService.getLeaves_ID();
    myOIDa = await RestService.getOID();
    final firebaseUser = await FirebaseAuth.instance.currentUser!;
    if (firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(UIDs[0].toString())
          .get()
          .then((ds) {
            print(ds);
        leaves = ds.data()!;
      });
    }
    // print(leaves);
    return leaves;
  }
}
