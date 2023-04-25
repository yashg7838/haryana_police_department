import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:haryana_police_department/screens/auth.dart';
import 'package:haryana_police_department/screens/change_password.dart';
import '../ui_helper/widgets/round_btn_1.dart';
import 'leave_request.dart';
import 'notifications.dart';
import 'package:firebase_auth/firebase_auth.dart';

class senior_oid extends StatefulWidget{
  @override
  State<senior_oid> createState() => _senior_oidState();
}

class _senior_oidState extends State<senior_oid> {
  late Map<String, dynamic> myName;

  late Map<String, dynamic> SUID;

  late Map<String, dynamic> SDetails;

  final TextEditingController s_oid = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  var status = "no";

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


              FutureBuilder(
                future: _fetch_details(),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if(snapshot.connectionState!= ConnectionState.done) {
                    return const Text("");
                  }
                  String seniorOid = myName["senior_oid"];
                  return Padding(
                    padding: const EdgeInsets.only(left: 30, top: 20, right: 20),
                    child: seniorOid.isEmpty?
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("Currently it is not set.",style: TextStyle(fontSize: 18, color: Colors.red),),
                        Text("Set it now:",style: TextStyle(fontSize: 18, color: Colors.red),)
                      ],
                    ):
                    Text("Your Senior's OID is: $seniorOid",style: const TextStyle(fontSize: 18, color: Colors.green),),
                  );
                },
              ),


              Padding(
                padding: const EdgeInsets.only(left: 20,top: 20),
                child: Row(
                  children: const [
                    Text("Enter Senior OID:", style: TextStyle(fontSize: 18),),
                    Text(" *", style: TextStyle(color: Colors.red),)
                  ],
                ),
              ),


              Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 25,right: 25),
                        child: SizedBox(
                          height: 100,
                          child: Column(
                            children: [
                              Flexible(
                                flex: 8,
                                fit: FlexFit.tight,
                                child: Container(
                                    child: (
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                          children: [
                                            SizedBox(
                                              height: 50,
                                              child: TextFormField(
                                                validator: (value) {
                                                  if (value == null || value.isEmpty) {
                                                    return 'Please enter some text';
                                                  }
                                                  return null;
                                                },
                                                controller: s_oid,
                                                keyboardType: TextInputType.number,
                                                decoration: InputDecoration(
                                                    hintText: "6 digit code",
                                                    enabledBorder: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(16),
                                                        borderSide: const BorderSide(
                                                          color: Color(0xFFD9D9D9),
                                                          // width: 2
                                                        )
                                                    ),
                                                    errorBorder: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(30),
                                                        borderSide: const BorderSide(
                                                          color: Colors.red,
                                                          // width: 2
                                                        )
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(16),
                                                        borderSide: const BorderSide(
                                                            color: Colors.black,
                                                            width: 2
                                                        )
                                                    )
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                    )
                                ),
                              ),
                            ],
                          ),
                        ),
                      ), // Email


                     //  status == "yes"?
                     // FutureBuilder(
                     //        future: _fetch_senior(),
                     //        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                     //          if(snapshot.connectionState!= ConnectionState.done) {
                     //            return const Text("");
                     //          }
                     //          String s_name = SDetails["name"];
                     //          String s_post = SDetails["post"];
                     //          return Column(
                     //            children: [
                     //              Text(s_name),
                     //              Text(s_post)
                     //            ],
                     //          );
                     //        },
                     //      )
                     //   :
                          
                      const SizedBox(
                          height: 30
                      ),


                      Padding (
                        padding: const EdgeInsets.only(left: 25,right: 25),
                        child: SizedBox(
                          height: 50,
                          child: Column(
                            children:   [
                              Flexible(
                                  flex: 8,
                                  fit: FlexFit.tight,
                                  child:
                                  InkWell(
                                    onTap: (){
                                      if (_formKey.currentState!.validate()) {
                                        setState(() {
                                          _update_senior();
                                        });
                                      }
                                    },
                                    child: const rdn_button(
                                      BtnName: "Continue",
                                      // link: 'Navigator.push(context, MaterialPageRoute(builder: (context) => change_password(),))'
                                    ),
                                  )
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
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

  // _fetch_uid() async{
  //   final firebaseUser = await FirebaseAuth.instance.currentUser!;
  //   if(firebaseUser != null){
  //     await FirebaseFirestore.instance
  //         .collection("OIDtoUID")
  //         .doc(s_oid.text)
  //         .get()
  //         .then((es){
  //       SUID = es.data()!;
  //     });
  //   }
  //   String se_oid = SUID["uid"].toString();
  //   print(se_oid);
  //   return se_oid;
  // }
  //
  // _fetch_senior() async{
  //   final firebaseUser = await FirebaseAuth.instance.currentUser!;
  //   if(firebaseUser != null){
  //     await FirebaseFirestore.instance
  //         .collection("users")
  //         .doc(_fetch_uid())
  //         .get()
  //         .then((xs){
  //       SDetails = xs.data()!;
  //     });
  //   }
  //   print(SDetails);
  //   return SDetails;
  // }

  _update_senior() async{
    final firebaseUser = await FirebaseAuth.instance.currentUser!;
    if(firebaseUser != null){
      await FirebaseFirestore.instance
          .collection("users")
          .doc(firebaseUser.uid)
          .update({"senior_oid":s_oid.text});
    }
  }
}