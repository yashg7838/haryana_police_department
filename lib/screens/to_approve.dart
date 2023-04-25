import 'package:flutter/material.dart';
import 'package:haryana_police_department/screens/to_approve_user.dart';

class to_approve extends StatefulWidget {  @override
State<StatefulWidget> createState() => to_approveState();
}

class to_approveState extends State<to_approve> {
  @override
  Widget build(BuildContext context) {
    var ID = ["1001","1002","1003","1004","1005","1006","1007","1008","1009","1010"];
    var firstName = ['Manoj',"Sanjeev","Vineet","Mane","Ramanujan","Gopal","Harendar","Vinesh","Raghav","Dinesh"];
    var lastName = ['Kumar',"Singh","Sharma","Milind","Govinda","Chand","Kumar","Mittal","Singh","Thappar"];
    var position = ["ACP","SI Intelligence","ASI","Inspector","Inspector","Inspector","Inspector","Inspector","Inspector","Inspector"];
    var leaveType = ["Casual","Sick","Casual","Casual","Sick","Casual","Casual","Casual","Sick","Casual"];
    var leavePeriod = ["Half Day","1 day","1 day","2 days","Half Day","1 day","1 day","1 day","2 days","1 days"];
    var leaveReason = ["Personal","Personal","Personal","Personal","Personal","Personal","Personal","Personal","Personal","Personal"];
    var applyTime = ["7:45 p.m.","7:45 p.m.","7:45 p.m.","7:45 p.m.","7:45 p.m.","7:45 p.m.","7:45 p.m.","7:45 p.m.","7:45 p.m.","7:45 p.m."];
    var leave_status = ["none","none","none","none","none","none","none","none","none","none"];
    return Material(
      child: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              InkWell(
                onTap: (){
                  setState(() {
                  });
                },
                child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    decoration: BoxDecoration(
                      // color: Colors.black,
                        color: const Color(0xFFF3F3F3),
                        borderRadius: BorderRadius.circular(20)
                    ),
                    height: 35,
                    width: 80,
                    child: const Center(child: Text("Refresh", style: TextStyle(fontWeight: FontWeight.bold),)),
                  ),
                ),
              ), // Refresh button
              SizedBox(
                child: ListView.separated(
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
                        leading: CircleAvatar(
                          backgroundColor: leaveType[index] == "Casual"? Colors.orange:Colors.red,
                          child: Text(firstName[index][0]+lastName[index][0],style: const TextStyle(fontSize: 20),),
                        ),
                        title: Text("${firstName[index]} ${lastName[index]}", style: const TextStyle(fontSize: 20),),
                        subtitle: Text(position[index]),
                        trailing: IconButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => to_approve_user(index),));
                          },
                          icon: const Icon(Icons.open_in_new_outlined),
                          color: Colors.black,
                        )
                      ),
                    );
                  }),
                  itemCount: ID.length,
                  separatorBuilder: (context, index) {
                    return const Divider(height: 10, thickness: 0,color: Colors.white,);
                  },
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}
