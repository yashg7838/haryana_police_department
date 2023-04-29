// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:haryana_police_department/screens/notifications.dart';
import 'package:haryana_police_department/screens/transfer.dart';

// ignore: must_be_immutable
class to_approve_user_2 extends StatefulWidget {
  // ignore: non_constant_identifier_names
  int emp_ind;
  to_approve_user_2(this.emp_ind, {super.key});
  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() => to_approve_userState_2(emp_ind);
}

class to_approve_userState_2 extends State<to_approve_user_2> {
  int emp_ind;
  to_approve_userState_2(this.emp_ind);

  @override
  Widget build(BuildContext context) {



    var firstName = [
      'Manoj',
      "Sanjeev",
      "Vineet",
      "Mane",
      "Ramanujan",
      "Gopal",
      "Harendar",
      "Vinesh",
      "Raghav"
    ];
    var lastName = [
      'Kumar',
      "Singh",
      "Sharma",
      "Milind",
      "Govinda",
      "Chand",
      "Kumar",
      "Mittal",
      "Singh"
    ];
    var position = ["ACP", "SI Intelligence"];
    var leaveType = [
      "Casual",
      "Sick",
      "Casual",
      "Casual",
      "Sick",
      "Casual",
      "Casual",
      "Casual",
      "Sick"
    ];
    var leavePeriod = [
      "Half Day",
      "1 day",
      "1 day",
      "2 days",
      "Half Day",
      "1 day",
      "1 day",
      "1 day",
      "2 days"
    ];
    var leaveReason = [
      "Personal",
      "Personal",
      "Personal",
      "Personal",
      "Personal",
      "Personal",
      "Personal",
      "Personal",
      "Personal"
    ];

    return Scaffold(
        body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.black,
                    )),

                Expanded(
                    child: Container(
                  height: 5,
                )),

                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => notifications(),
                          ));
                    },
                    icon: const Icon(Icons.notifications_none_rounded)),

                const SizedBox(
                  width: 10,
                ),

              ],
            ), // Top icons

            const SizedBox(
              height: 10,
            ),

            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 25, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                        fit: FlexFit.tight,
                        child: Column(
                          children: [
                            ListTile(
                              leading: CircleAvatar(
                                backgroundColor: leaveType[emp_ind] == "Casual"
                                    ? Colors.orange
                                    : Colors.red,
                                child: Text(
                                  firstName[emp_ind][0] + lastName[emp_ind][0],
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ),
                              title: Text(
                                "${firstName[emp_ind]} ${lastName[emp_ind]}",
                                style: const TextStyle(fontSize: 20),
                              ),
                              subtitle: Text(position[emp_ind]),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 15),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Type:",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        leaveType[emp_ind],
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      const Text(
                                        "Reason:",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        leaveReason[emp_ind],
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      const Text(
                                        "Leave period:",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        leavePeriod[emp_ind],
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      const SizedBox(
                                        height: 50,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return Container(
                                                  color: const Color.fromARGB(
                                                      100, 22, 44, 33),
                                                  child: AlertDialog(
                                                    title: const Text(
                                                        "Are you sure you want to approve?"),
                                                    actions: [
                                                      TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return Container(
                                                                    color: const Color
                                                                            .fromARGB(
                                                                        100,
                                                                        22,
                                                                        44,
                                                                        33),
                                                                    child:
                                                                        AlertDialog(
                                                                      title: const Text(
                                                                          "Approved"),
                                                                      actions: [
                                                                        TextButton(
                                                                            onPressed:
                                                                                () {
                                                                              Navigator.pop(context);
                                                                              Navigator.pop(context);
                                                                            },
                                                                            child:
                                                                                const Text("Ok"))
                                                                      ],
                                                                    ),
                                                                  );
                                                                });
                                                          },
                                                          child: const Text(
                                                              "Yes")),
                                                      TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child:
                                                              const Text("No"))
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
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: const Center(
                                            child: Text(
                                              "Approve",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return Container(
                                                  color: const Color.fromARGB(
                                                      100, 22, 44, 33),
                                                  child: AlertDialog(
                                                    title: const Text(
                                                        "Are you sure you want to deny?"),
                                                    actions: [
                                                      TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return Container(
                                                                    color: const Color
                                                                            .fromARGB(
                                                                        100,
                                                                        22,
                                                                        44,
                                                                        33),
                                                                    child:
                                                                        AlertDialog(
                                                                      title: const Text(
                                                                          "Denied"),
                                                                      actions: [
                                                                        TextButton(
                                                                            onPressed:
                                                                                () {
                                                                              Navigator.pop(context);
                                                                              Navigator.pop(context);
                                                                            },
                                                                            child:
                                                                                const Text("Ok"))
                                                                      ],
                                                                    ),
                                                                  );
                                                                });
                                                          },
                                                          child: const Text(
                                                              "Yes")),
                                                      TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child:
                                                              const Text("No"))
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
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: const Center(
                                            child: Text(
                                              "Deny",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          // Navigator.push(
                                          //     context,
                                          //     MaterialPageRoute(
                                          //       builder: (context) =>
                                          //           transfer(emp_ind),
                                          //     ));
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          height: 40,
                                          decoration: BoxDecoration(
                                              color: const Color(0xFFF3F3F3),
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: const Center(
                                            child: Text(
                                              "Transfer",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        )),
                  ],
                ),
              ),
            )
          ]),
    ));
  }
}
