import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:haryana_police_department/screens/auth.dart';
import 'package:haryana_police_department/screens/change_password.dart';
import 'package:haryana_police_department/screens/senior_oid.dart';
import 'leave_request.dart';
import 'notifications.dart';
import 'package:firebase_auth/firebase_auth.dart';

class oid_home extends StatelessWidget{
  late Map<String, dynamic> myName;
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Column(
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


                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => leave_request(),));
                    },
                    child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                                colors: [
                                  Color(0xFF2F3374),
                                  Color(0xFF682242)
                                ]
                            ),
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: const Icon(Icons.add_outlined, size: 30, color: Colors.white,)
                    ),
                  ),


                  const SizedBox(
                    width: 10,
                  )
                ],
              ), // Top icons


              // User ID
              FutureBuilder(
                future: _fetch_details(),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if(snapshot.connectionState!= ConnectionState.done) {
                    return Text("");
                  }
                  return ListTile(
                    leading: const Icon(Icons.supervised_user_circle,
                      size: 60,
                      color: Colors.black,),
                    title:Text(myName["name"].toString(), style: const TextStyle(color: Colors.black),),
                    subtitle: Text(myName["post"], style: const TextStyle(color: Colors.black),),
                    trailing: IconButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => notifications(),));
                      },
                      icon: const Icon(Icons.notifications_active_outlined,
                        size: 25,
                        color: Colors.white,),
                    ),

                  );
                },
              ),


              const SizedBox(
                height: 20,
              ),


              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10,right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text("My OID:",style: TextStyle(fontSize: 18,),)
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FutureBuilder(
                              future: _fetch_details(),
                              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                                if(snapshot.connectionState!= ConnectionState.done) {
                                  return const Text("");
                                }
                                return Text(myName["oid"],style: TextStyle(fontSize: 18, color: Colors.green),);
                              },
                            ),

                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),


              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => senior_oid(),));
                  },
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      boxShadow: [BoxShadow(
                        color: Colors.grey,
                        blurRadius: 1,
                      )]
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10,right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text("Senior OID:",style: TextStyle(fontSize: 18,),)
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FutureBuilder(
                                future: _fetch_details(),
                                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                                  if(snapshot.connectionState!= ConnectionState.done) {
                                    return const Text("");
                                  }
                                  String senior_oid = myName["senior_oid"];
                                  return senior_oid.isEmpty?
                                  const Text("Not set",style: TextStyle(fontSize: 18, color: Colors.red),):
                                  Text(senior_oid,style: const TextStyle(fontSize: 18, color: Colors.green),);
                                },
                              ),

                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),


              Flexible(
                child: Container(
                  height: double.infinity,
                ),
              ),


            ],
          ),
        )
    );
  }
  _fetch_details() async{
    final firebaseUser = await FirebaseAuth.instance.currentUser!;
    if(firebaseUser != null){
      await FirebaseFirestore.instance
          .collection("users")
          .doc(firebaseUser.uid)
          .get()
          .then((ds){
        myName = ds.data()!;
      });
    }
    return myName;
  }
}