// ignore_for_file: non_constant_identifier_names, camel_case_types, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:haryana_police_department/screens/leave_page.dart';
import 'package:haryana_police_department/screens/leave_request.dart';
import 'package:haryana_police_department/screens/more.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../ui_helper/widgets/round_btn_1.dart';
import 'notifications.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: camel_case_types, must_be_immutable
class home extends StatefulWidget{
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  // ignore: prefer_typing_uninitialized_variables
  String Tab = "total";
  late Map<String, dynamic> myName;
  late Map<String, dynamic> myLeaves;

  @override
  Widget build(BuildContext context) {



    int leavesCl;
    int leavesEl;
    int leavesT;


    int totalLeaves;
    int clLeaves;
    int elLeaves;

    int leavebalanceT;
    int leavebalanceCl;
    int leavebalanceEl;

    double leavesperT;
    double leavesperCl;
    double leavesperEl;




    return Scaffold(
      body: SafeArea(
        child: Container(

          // Background decoration
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF1C28F0),
                Color(0xFF552752)
              ],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            )
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 5,
              ),

              // Header information of user
              FutureBuilder(
                future: _fetch_details(),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if(snapshot.connectionState!= ConnectionState.done) {
                    return const Text("");
                  }
                  return ListTile(
                    leading: InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => more(),));
                      },
                      child: const Icon(Icons.supervised_user_circle,
                        size: 60,
                        color: Colors.white,),
                    ),
                    title:Text(myName["name"].toString(), style: const TextStyle(color: Colors.white),),
                    subtitle: Text(myName["post"], style: const TextStyle(color: Colors.white),),
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
                height: 15,
              ),


              // Start of main body
              Flexible(
                flex: 10,
                fit: FlexFit.tight,
                child: Container(
                  decoration:  const BoxDecoration(
                    boxShadow: [BoxShadow(
                      color: Colors.black38,
                      blurRadius: 4,
                      spreadRadius: 4
                    )
                    ],
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(34), topRight: Radius.circular(34)),
                      color: Colors.white
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 25,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text("Leave Balance", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
                        ), // Leave Balance Text
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Container(
                            height: 250,
                            decoration: BoxDecoration(
                              // color: Colors.grey,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: const Color(0xFFDFDFDF))
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      children: [


                                        // For Total of leaves on main page
                                        Tab == "total"?
                                        FutureBuilder(
                                          future: _fetch_leaves(),
                                          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                                            if(snapshot.connectionState!= ConnectionState.done) {
                                              return const Text("");
                                            } else{
                                              leavesEl = myLeaves["el"];
                                              leavesCl = myLeaves["cl"];
                                              totalLeaves = leavesCl+leavesEl;
                                            }
                                            return Text(totalLeaves.toString() , style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),);
                                          },
                                        ):
                                        Tab == "cl"?
                                        FutureBuilder(
                                          future: _fetch_leaves(),
                                          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                                            if(snapshot.connectionState!= ConnectionState.done) {
                                              return const Text("");
                                            } else{
                                              leavesCl = myLeaves["cl"];
                                            }
                                            return Text(leavesCl.toString() , style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),);
                                          },
                                        ):
                                        FutureBuilder(
                                          future: _fetch_leaves(),
                                          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                                            if(snapshot.connectionState!= ConnectionState.done) {
                                              return const Text("");
                                            } else{
                                              leavesEl = myLeaves["el"];
                                            }
                                            return Text(leavesEl.toString() , style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),);
                                          },
                                        ),
                                        const SizedBox(
                                          height: 7,
                                        ),
                                        const Text("Total Leaves", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 13),)
                                      ],
                                    ), // Total Leaves



                                    // For percentage circle of leaves left on main page // Leaves percentage
                                    Tab == "total"?
                                      FutureBuilder(
                                      future: _fetch_leaves(),
                                      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                                        if(snapshot.connectionState!= ConnectionState.done) {
                                          return const Text("");
                                        } else{
                                          elLeaves = myLeaves["el_used"];
                                          clLeaves = myLeaves["cl_used"];
                                          leavesEl = myLeaves["el"];
                                          leavesCl = myLeaves["cl"];
                                          totalLeaves = leavesCl+leavesEl;
                                          leavesT =  clLeaves+elLeaves;
                                          leavebalanceT = totalLeaves - leavesT;
                                          leavesperT = (leavebalanceT/totalLeaves);
                                        }
                                        return CircularPercentIndicator(
                                          radius: 45,
                                          lineWidth: 3,
                                          percent: leavesperT.toDouble(),
                                          linearGradient: const LinearGradient(
                                              colors: [
                                                Color(0xFF2F3374),
                                                Color(0xFF682242)
                                              ],
                                              end: Alignment.topRight,
                                              begin: Alignment.bottomLeft
                                          ),
                                          circularStrokeCap: CircularStrokeCap.round,
                                          center:
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(leavebalanceT.toString() , style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
                                            ],
                                          ),
                                        );
                                      },
                                    ):  // ok tested
                                    Tab == "cl"?
                                      FutureBuilder(
                                      future: _fetch_leaves(),
                                      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                                        if(snapshot.connectionState!= ConnectionState.done) {
                                          return const Text("");
                                        } else{
                                          clLeaves = myLeaves["cl_used"];
                                          leavesCl = myLeaves["cl"];
                                          leavebalanceCl = leavesCl - clLeaves;
                                          leavesperCl = (leavebalanceCl/leavesCl);
                                        }
                                        return CircularPercentIndicator(
                                          radius: 45,
                                          lineWidth: 3,
                                          percent: leavesperCl.toDouble(),
                                          linearGradient: const LinearGradient(
                                              colors: [
                                                Color(0xFF2F3374),
                                                Color(0xFF682242)
                                              ],
                                              end: Alignment.topRight,
                                              begin: Alignment.bottomLeft
                                          ),
                                          circularStrokeCap: CircularStrokeCap.round,
                                          center:
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(leavebalanceCl.toString() , style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
                                            ],
                                          ),
                                        );
                                      },
                                    ):  // error
                                      FutureBuilder(
                                      future: _fetch_leaves(),
                                      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                                        if(snapshot.connectionState!= ConnectionState.done) {
                                          return const Text("");
                                        } else{
                                          elLeaves = myLeaves["el_used"];
                                          leavesEl = myLeaves["el"];
                                          leavebalanceEl = leavesEl - elLeaves;
                                          leavesperEl = (leavebalanceEl/leavesEl);
                                        }
                                        return CircularPercentIndicator(
                                          radius: 45,
                                          lineWidth: 3,
                                          percent: leavesperEl.toDouble(),
                                          linearGradient: const LinearGradient(
                                              colors: [
                                                Color(0xFF2F3374),
                                                Color(0xFF682242)
                                              ],
                                              end: Alignment.topRight,
                                              begin: Alignment.bottomLeft
                                          ),
                                          circularStrokeCap: CircularStrokeCap.round,
                                          center:
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(leavebalanceEl.toString() , style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
                                            ],
                                          ),
                                        );
                                      },
                                    ),




                                    Column(
                                      children: [
                                        Tab == "total"?
                                          FutureBuilder(
                                            future: _fetch_leaves(),
                                            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                                              if(snapshot.connectionState!= ConnectionState.done) {
                                                return const Text("");
                                              } else{
                                                elLeaves = myLeaves["el_used"];
                                                clLeaves = myLeaves["cl_used"];
                                                leavesT =  clLeaves+elLeaves;
                                              }
                                              return Text(leavesT.toString(), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),);
                                            },
                                          ):
                                        Tab == "cl"?
                                          FutureBuilder(
                                            future: _fetch_leaves(),
                                            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                                              if(snapshot.connectionState!= ConnectionState.done) {
                                                return const Text("");
                                              } else{
                                                clLeaves = myLeaves["cl_used"];
                                              }
                                              return Text(clLeaves.toString(), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),);
                                            },
                                          ):
                                          FutureBuilder(
                                            future: _fetch_leaves(),
                                            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                                              if(snapshot.connectionState!= ConnectionState.done) {
                                                return const Text("");
                                              } else{
                                                elLeaves = myLeaves["el_used"];
                                              }
                                              return Text(elLeaves.toString(), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),);
                                            },
                                          ),
                                        const SizedBox(
                                          height: 7,
                                        ),
                                        const Text("Used Leaves", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 13),)
                                      ],
                                    ), // Used Leaves
                                  ],
                                ), // Upper row with circle
                                const SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Flexible(
                                      child: InkWell(
                                        onTap: (){
                                          setState(() {
                                            Tab = "cl";
                                          });
                                        },
                                        child: SizedBox(
                                            height: 24,
                                            width: double.infinity,
                                            child: Center(child: FutureBuilder(
                                              future: _fetch_leaves(),
                                              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                                                if(snapshot.connectionState!= ConnectionState.done) {
                                                  return const Text("");
                                                } else{
                                                  clLeaves = myLeaves["cl"];
                                                }
                                                return Text(clLeaves.toString(), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),);
                                              },
                                            ))),
                                      ),
                                    ),
                                    Container(
                                      color: const Color(0xFFDFDFDF),
                                      width: 2,
                                      height: 24,
                                    ),
                                    Flexible(
                                      child: InkWell(
                                        onTap: (){
                                          setState(() {
                                            Tab = "el";
                                          });
                                        },
                                        child: SizedBox(
                                            width: double.infinity,
                                            height: 24,
                                            child: Center(child: FutureBuilder(
                                              future: _fetch_leaves(),
                                              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                                                if(snapshot.connectionState!= ConnectionState.done) {
                                                  return const Text("");
                                                } else{
                                                  elLeaves = myLeaves["el"];
                                                }
                                                return Text(elLeaves.toString(), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),);
                                              },
                                            ))),
                                      ),
                                    ),
                                    Container(
                                      color: const Color(0xFFDFDFDF),
                                      width: 2,
                                      height: 24,
                                    ),
                                    Flexible(
                                      child: InkWell(
                                        onTap: (){
                                          setState(() {
                                            Tab = "total";
                                          });
                                        },
                                        child: SizedBox(
                                            height: 24,
                                            width: double.infinity,
                                            child: Center(child: FutureBuilder(
                                              future: _fetch_leaves(),
                                              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                                                if(snapshot.connectionState!= ConnectionState.done) {
                                                  return const Text("");
                                                } else{
                                                  elLeaves = myLeaves["el"];
                                                  clLeaves = myLeaves["cl"];
                                                  leavesT =  clLeaves+elLeaves;
                                                }
                                                return Text(leavesT.toString(), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),);
                                              },
                                            ))),
                                      ),
                                    ),
                                  ],
                                ), // Middle row
                                const SizedBox(
                                  height: 9,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    Flexible(
                                      flex: 2,
                                      fit: FlexFit.tight,
                                      child: InkWell(
                                        onTap: (){
                                          setState(() {
                                            Tab = "cl";
                                          });
                                        },
                                        child: Container(
                                          height: 20,
                                          decoration: (Tab == "cl")?
                                          BoxDecoration(
                                            color: const Color(0xFF682242),
                                            borderRadius: BorderRadius.circular(11.5)
                                          ):
                                            BoxDecoration(
                                            color: const Color(0xFF2F3374),
                                            borderRadius: BorderRadius.circular(11.5)
                                            ),
                                          child:
                                          const Center(child: Text("CL", style: TextStyle(color: Colors.white),)),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    Flexible(
                                      flex: 2,
                                      fit: FlexFit.tight,
                                      child: InkWell(
                                        onTap: (){
                                          setState(() {
                                            Tab = "el";
                                          });
                                        },
                                        child: Container(
                                          height: 20,
                                          decoration: (Tab == "el")?
                                        BoxDecoration(
                                            color: const Color(0xFF682242),
                                            borderRadius: BorderRadius.circular(11.5)
                                        ):
                                        BoxDecoration(
                                            color: const Color(0xFF2F3374),
                                            borderRadius: BorderRadius.circular(11.5)
                                        ),
                                          child:
                                          const Center(child: Text("EL", style: TextStyle(color: Colors.white),)),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    Flexible(
                                      flex: 2,
                                      fit: FlexFit.tight,
                                      child: InkWell(
                                        onTap: (){
                                          setState(() {
                                            Tab = "total";
                                          });
                                        },
                                        child: Container(
                                          height: 20,
                                          decoration: (Tab == "total")?
                                          BoxDecoration(
                                              color: const Color(0xFF682242),
                                              borderRadius: BorderRadius.circular(11.5)
                                          ):
                                          BoxDecoration(
                                              color: const Color(0xFF2F3374),
                                              borderRadius: BorderRadius.circular(11.5)
                                          ),
                                          child:
                                          const Center(child: Text("Total", style: TextStyle(color: Colors.white),)),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                  ],
                                ), // Lower Row
                              ],
                            ),
                          ),
                        ), // Leave Balance Box
                        Row(
                          children: [
                            Flexible(
                              child: Padding (
                                padding: const EdgeInsets.only(left: 25,right: 25),
                                child: SizedBox(
                                  height: 50,
                                  child: Column(
                                    children:   [
                                      Flexible(
                                          flex: 4,
                                          fit: FlexFit.tight,
                                          child:
                                          // Container(
                                          //   color: Colors.red,
                                          // )
                                          InkWell(
                                            onTap: (){
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => leave_request(),)); //leaves_page("your")
                                            },
                                            child: const rdn_button(
                                              BtnName: "Apply Leave",
                                              // link: 'Navigator.push(context, MaterialPageRoute(builder: (context) => change_password(),))'
                                            ),
                                          )
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              child: Padding (
                                padding: const EdgeInsets.only(left: 25,right: 25),
                                child: SizedBox(
                                  height: 50,
                                  child: Column(
                                    children:   [
                                      Flexible(
                                          flex: 4,
                                          fit: FlexFit.tight,
                                          child:
                                          // Container(
                                          //   color: Colors.red,
                                          // )
                                          InkWell(
                                            onTap: (){
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => leave(),));
                                            },
                                            child: const rdn_button(
                                              BtnName: "Approval",
                                              // link: 'Navigator.push(context, MaterialPageRoute(builder: (context) => change_password(),))'
                                            ),
                                          )
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
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


  _fetch_leaves() async{
    final firebaseUser = await FirebaseAuth.instance.currentUser!;
    if(firebaseUser != null){
      await FirebaseFirestore.instance
          .collection("leaves")
          .doc(firebaseUser.uid)
          .get()
          .then((ds){
        myLeaves = ds.data()!;
      });
    }
    return myLeaves;
  }
}
