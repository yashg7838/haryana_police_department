import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haryana_police_department/screens/my_leaves.dart';
import 'package:haryana_police_department/screens/to_approve.dart';
import 'package:haryana_police_department/screens/to_approve_2.dart';
import 'package:haryana_police_department/screens/your_leave.dart';

import 'leave_request.dart';
import 'notifications.dart';

class leave extends StatefulWidget {
  @override
  State<leave> createState() => _leaveState();
}

class _leaveState extends State<leave> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          body: SafeArea(
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
                        }, icon: const Icon(Icons.home_outlined,
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
                const SizedBox(
                  height: 20,
                ),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text("Leaves", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                  ),
                ), // Text: Leaves
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      // color: Colors.black,
                        color: const Color(0xFFF3F3F3),
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: TabBar(
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.black,
                        indicatorColor: Colors.green,
                        indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: const LinearGradient(
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                              colors: [
                                Color(0xFF2F3374),
                                Color(0xFF682242)
                              ],
                            )
                        ),
                        tabs: const [
                          Tab(text: "Yours",),
                          Tab(text: "To Approve",)
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: TabBarView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 25, right: 25),
                          child: my_leaves(),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 25, right: 25),
                          child: SizedBox(
                            height: 200,
                              child: to_approve_2()
                          ),
                        )
                      ]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
