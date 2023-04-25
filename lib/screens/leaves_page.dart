import 'package:flutter/material.dart';
import 'package:haryana_police_department/screens/to_approve.dart';
import 'package:haryana_police_department/screens/your_leave.dart';

// ignore: camel_case_types, must_be_immutable
class leaves_page extends StatefulWidget {
  String cont;
  leaves_page(this.cont, {super.key});
  @override
// ignore: no_logic_in_create_state
State<StatefulWidget> createState() => leavesState(cont);

}

// ignore: camel_case_types
class leavesState extends State<leaves_page> {

  // ignore: prefer_typing_uninitialized_variables
  var status;
  leavesState(this.page);
  // ignore: prefer_typing_uninitialized_variables
  var page;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                const Icon(Icons.notifications_none_rounded),
                const SizedBox(
                  width: 10,
                ),
                Container(
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
            Flexible(
              child: Padding (
                padding: const EdgeInsets.only(left: 25,right: 25),
                child: SizedBox(
                  height: 40,
                  child: Column(
                    children:   [
                      Flexible(
                          fit: FlexFit.tight,
                          child:
                          Container(
                            decoration: BoxDecoration(
                              // color: Colors.black,
                                color: const Color(0xFFF3F3F3),
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child: Row(
                              children: [
                                Flexible(
                                    child: InkWell(
                                      onTap: (){
                                        setState(() {
                                          page = "your";
                                        });
                                      },
                                      child: Padding(
                                          padding: const EdgeInsets.all(4),
                                          child: SizedBox(
                                            height: 38,
                                            child: Column(
                                              children: [
                                                Flexible(
                                                    fit: FlexFit.tight,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(20),
                                                        gradient: page == "your"? const LinearGradient(
                                                          begin: Alignment.bottomLeft,
                                                          end: Alignment.topRight,
                                                          colors: [
                                                            Color(0xFF2F3374),
                                                            Color(0xFF682242)
                                                          ],
                                                        ) : const LinearGradient(colors: [Color(0xFFF3F3F3),Color(0xFFF3F3F3)]),
                                                      ),
                                                      child: Center(child: Text("Yours", style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold, color: page == "your"? Colors.white:Colors.black),)),
                                                    )
                                                )
                                              ],
                                            ),
                                          )
                                      ),
                                    )
                                ),
                                Flexible(
                                    child: InkWell(
                                      onTap: (){
                                        setState(() {
                                          page = "approve";
                                        });
                                      },
                                      child: Padding(
                                          padding: const EdgeInsets.all(4),
                                          child: SizedBox(
                                            height: 38,
                                            child: Column(
                                              children: [
                                                Flexible(
                                                    fit: FlexFit.tight,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(20),
                                                        gradient: page == "approve"? const LinearGradient(
                                                          begin: Alignment.bottomLeft,
                                                          end: Alignment.topRight,
                                                          colors: [
                                                            Color(0xFF2F3374),
                                                            Color(0xFF682242)
                                                          ],
                                                        ) : const LinearGradient(colors: [Color(0xFFF3F3F3),Color(0xFFF3F3F3)]),
                                                      ),
                                                      child: Center(child: Text("To Approve", style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold, color: page == "approve"? Colors.white:Colors.black),)),
                                                    )
                                                )
                                              ],
                                            ),
                                          )
                                      ),
                                    )
                                )
                              ],
                            ),
                          )
                      ),
                    ],
                  ),
                ),
              ),
            ), // Yours-To approve navigation
            const SizedBox(
              height: 15,
            ),
            Flexible(
              child: Padding (
                padding: const EdgeInsets.only(left: 25,right: 25),
                child: Column(
                  children:   [
                    Flexible(
                        fit: FlexFit.tight,
                        child: page == "your"?your_leave():to_approve()
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
