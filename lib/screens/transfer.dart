import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../ui_helper/leaves.dart';
import 'notifications.dart';

class transfer extends StatefulWidget {
  String leave_ind;
  transfer(this.leave_ind);
  @override
  State<transfer> createState() => _transferState(leave_ind);  //emp_ind
}

class _transferState extends State<transfer> {

  final String leave_ind;
  _transferState(this.leave_ind);
  final TextEditingController code = TextEditingController();
  late Map<String, dynamic> myData;
  late final UIDs;
  late final Leaves;
  late Map<String, dynamic> myUser;


  @override
  final _formKey = GlobalKey<FormState>();
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
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
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                  return Container();
                                },
                              ),


                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
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
                                                      const Padding(
                                                        padding: EdgeInsets.only(left: 10),
                                                        child: Text("Employee Code *",
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.w500,
                                                              fontSize: 17
                                                          ),),
                                                      ),
                                                      const SizedBox(
                                                        height: 4,
                                                      ),
                                                      SizedBox(
                                                        height: 50,
                                                        child: TextFormField(
                                                          validator: (value) {
                                                            if (value == null || value.isEmpty) {
                                                              return 'Please enter some text';
                                                            }
                                                            return null;
                                                          },
                                                          controller: code,
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
                                  ), // Email
                                  const SizedBox(
                                      height: 30
                                  ),
                                ],
                              ),
                              InkWell(
                                onTap: (){
                                  showDialog(
                                      context: context,
                                      builder: (context){
                                        return Container(
                                          color: const Color.fromARGB(100, 22, 44, 33),
                                          child: AlertDialog(
                                            title: Text("Are you sure you want to transfer to $code?"),
                                            actions: [
                                              TextButton(
                                                  onPressed: (){
                                                    Navigator.pop(context);
                                                    print("sending");
                                                    _transfer_leave(code.text.toString());
                                                    print("sent");
                                                    showDialog(
                                                        context: context,
                                                        builder: (context){
                                                          return Container(
                                                            color: const Color.fromARGB(100, 22, 44, 33),
                                                            child: AlertDialog(
                                                              title: const Text("Transferred"),
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
                                  child: const Center(child: Text("Transfer", style: TextStyle(color: Colors.white, fontSize: 17,fontWeight: FontWeight.bold),),),
                                ),
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
      ),
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

  _transfer_leave(code) async{
    print("called");
    final firebaseUser = await FirebaseAuth.instance.currentUser!;
    if(firebaseUser != null){
      await FirebaseFirestore.instance
          .collection("leave_application")
          .doc(leave_ind)
          .update({"approver_OID":code});
    }
  }
}
