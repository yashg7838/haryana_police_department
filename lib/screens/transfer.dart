import 'package:flutter/material.dart';

import 'notifications.dart';

class transfer extends StatefulWidget {
  int emp_ind;
  transfer(this.emp_ind);
  @override
  State<transfer> createState() => _transferState(emp_ind);
}

class _transferState extends State<transfer> {

  int emp_ind;
  _transferState(this.emp_ind);

  @override
  var ID = ["1001","1002","1003","1004","1005","1006","1007","1008","1009"];
  var firstName = ['Manoj',"Sanjeev","Vineet","Mane","Ramanujan","Gopal","Harendar","Vinesh","Raghav"];
  var lastName = ['Kumar',"Singh","Sharma","Milind","Govinda","Chand","Kumar","Mittal","Singh"];
  var position = ["ACP","SI Intelligence"];
  var leaveType = ["Casual","Sick","Casual","Casual","Sick","Casual","Casual","Casual","Sick"];
  var leavePeriod = ["Half Day","1 day","1 day","2 days","Half Day","1 day","1 day","1 day","2 days"];
  var leaveReason = ["Personal","Personal","Personal","Personal","Personal","Personal","Personal","Personal","Personal"];
  var applyTime = ["7:45 p.m.","7:45 p.m.","7:45 p.m.","7:45 p.m.","7:45 p.m.","7:45 p.m.","7:45 p.m.","7:45 p.m.","7:45 p.m."];
  final _formKey = GlobalKey<FormState>();
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
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
                            ListTile(
                              leading: CircleAvatar(
                                backgroundColor: leaveType[emp_ind] == "Casual"? Colors.orange:Colors.red,
                                child: Text(firstName[emp_ind][0]+lastName[emp_ind][0],style: const TextStyle(fontSize: 20),),
                              ),
                              title: Text("${firstName[emp_ind]} ${lastName[emp_ind]}", style: const TextStyle(fontSize: 20),),
                              subtitle: Text(position[emp_ind]),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
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
                                      Text(leaveType[emp_ind], style: const TextStyle(fontSize: 16),),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      const Text("Reason:",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Text(leaveReason[emp_ind], style: const TextStyle(fontSize: 16),),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      const Text("Leave period:",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Text(leavePeriod[emp_ind], style: const TextStyle(fontSize: 16),),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      const SizedBox(
                                        height: 50,
                                      ),
                                      Form(
                                          key: _formKey,
                                          child: Column(
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
                                              SizedBox(
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
                                                                    child: Text("Reason",
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
                                                                      keyboardType: TextInputType.text,
                                                                      decoration: InputDecoration(
                                                                          hintText: "Reason",
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
                                              ), // Password
                                              const SizedBox(
                                                  height: 30
                                              ),
                                              InkWell(
                                                onTap: (){
                                                  if (_formKey.currentState!.validate()) {
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return Container(
                                                            color: const Color.fromARGB(
                                                                100, 22, 44, 33),
                                                            child: AlertDialog(
                                                              title: const Text(
                                                                  "Are you sure you want to transfer?"),
                                                              actions: [
                                                                TextButton(
                                                                    onPressed: () {
                                                                      Navigator.pop(
                                                                          context);
                                                                      showDialog(
                                                                          context: context,
                                                                          builder: (
                                                                              context) {
                                                                            return Container(
                                                                              color: const Color
                                                                                  .fromARGB(
                                                                                  100,
                                                                                  22,
                                                                                  44,
                                                                                  33),
                                                                              child: AlertDialog(
                                                                                title: const Text(
                                                                                    "Transferred"),
                                                                                actions: [
                                                                                  TextButton(
                                                                                      onPressed: () {
                                                                                        Navigator
                                                                                            .pop(
                                                                                            context);
                                                                                      },
                                                                                      child: const Text(
                                                                                          "Ok"))
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
                                                                    child: const Text(
                                                                        "No"))
                                                              ],
                                                            ),
                                                          );
                                                        });
                                                  };
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

                                      const SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )

                          ],
                        )
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }}
