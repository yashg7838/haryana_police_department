// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:haryana_police_department/screens/home.dart';
import '../ui_helper/widgets/round_btn_1.dart';

// ignore: camel_case_types
class change_password extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
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
              const Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text("Change Password",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
                child: SizedBox(
                  height: 100,
                  child: Column(
                    children: [
                      Flexible(
                        flex: 8,
                        fit: FlexFit.tight,
                        child: Container(
                          // color: Colors.grey,
                            child: (
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Text("Old Password",
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
                                      child: TextField(
                                        obscureText: true,
                                        obscuringCharacter: "*",
                                        keyboardType: TextInputType.name,
                                        decoration: InputDecoration(
                                            hintText: "**********",
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(16),
                                                borderSide: const BorderSide(
                                                  color: Color(0xFFD9D9D9),
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
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25,right: 25),
                child: SizedBox(
                  height: 100,
                  child: Column(
                    children: [
                      Flexible(
                        flex: 8,
                        fit: FlexFit.tight,
                        child: Container(
                          // color: Colors.grey,
                            child: (
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Text("New Password",
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
                                      child: TextField(
                                        obscureText: true,
                                        obscuringCharacter: "*",
                                        keyboardType: TextInputType.emailAddress,
                                        decoration: InputDecoration(
                                            hintText: "**********",
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(16),
                                                borderSide: const BorderSide(
                                                  color: Color(0xFFD9D9D9),
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
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25,right: 25),
                child: SizedBox(
                  height: 100,
                  child: Column(
                    children: [
                      Flexible(
                        flex: 8,
                        fit: FlexFit.tight,
                        child: Container(
                          // color: Colors.grey,
                            child: (
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Text("Re-enter Password",
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
                                      child: TextField(
                                        obscureText: true,
                                        obscuringCharacter: "*",
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                            hintText: "**********",
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(16),
                                                borderSide: const BorderSide(
                                                  color: Color(0xFFD9D9D9),
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
              ),
              const SizedBox(
                  height: 30
              ),
              Padding (
                padding: const EdgeInsets.only(left: 25,right: 25),
                child: SizedBox(
                  height: 50,
                  child: Column(
                    children:  [
                      Flexible(
                          flex: 8,
                          fit: FlexFit.tight,
                          child:
                          // Container(
                          //   color: Colors.red,
                          // )
                          InkWell(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: const rdn_button(
                              BtnName: "Save",
                              // link: "Navigator.push(context, MaterialPageRoute(builder: (context) => login(),))"
                            ),
                          )
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  }
