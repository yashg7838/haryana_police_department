import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import '../ui_helper/leaves.dart';
import '../ui_helper/widgets/round_btn_1.dart';
import 'notifications.dart';

class leave_request extends StatefulWidget {
  @override
  State<leave_request> createState() => _leave_requestState();
}

class _leave_requestState extends State<leave_request> {
  @override
  final _formKey = GlobalKey<FormState>();
  FilePickerResult? result;
  String? _fileName;
  PlatformFile? pickedFile;
  bool isLoading = false;
  File? fileToDisplay;



  void pickFile()async{
    try{
      setState(() {
        isLoading = true;
      });
      result = await FilePicker.platform.pickFiles(
        type:FileType.any,
        allowMultiple: false,
      );

      if(result!= null ) {
        _fileName = result!.files.first.name;
        pickedFile=result!.files.first;
        fileToDisplay= File(pickedFile!.bytes.toString());
        print('File name $_fileName');
      }

      setState(() {
        isLoading = false;
      });
    }catch(e){
      print(e);
    }
  }


  final TextEditingController _date = TextEditingController();
  final TextEditingController _date_2 = TextEditingController();
  final TextEditingController reason = TextEditingController();


  List<String> items = [
    'Casual',
    'Sick Leave',
    'Maternity Leave (ML)',
    'Marriage leave ',
    'Paternity leave ',
    'Bereavement leave',
    'Earned leave',
    'Annual leave',
  ];
  String? selecteditem = 'Casual';



  Widget build(BuildContext context) {
    return Scaffold(

        body:SafeArea(
          child: SingleChildScrollView(
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
                    )
                  ],
                ), // Top icons


                Container(
                  padding: const EdgeInsets.only(left:25),
                  child: const Text
                    ('Leave Request',style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                  ),
                ), // text leave request


                Container(
                  padding: const EdgeInsets.only(left:25,top: 20),
                  child: const Text
                    ('TYPE',style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  ),
                ), // text type


                Container(
                  padding: const EdgeInsets.only( left:25,top: 10,right: 25),
                  child: DropdownButtonFormField<String>(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person),
                        prefixIconColor: const Color(0xFF682242),
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
                    value: selecteditem,
                    items: items
                        .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(item,style: const TextStyle(fontSize: 18)),
                    )).toList(),
                    onChanged: (item) => setState(() => selecteditem=item),
                  ),
                ), // drop-down box for type


                Container(
                  padding: const EdgeInsets.only(left:25,top: 20),
                  child: const Text
                    ('Reason',style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  ),
                ), // text reason


                Container(
                  width:  MediaQuery.of(context).size.width > 1020
                      ? 1020
                      : MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(top: 10,right:25.0,left:25.0),
                  child: TextFormField(
                    controller: reason,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.edit),
                        hintText: 'Reason',
                        prefixIconColor: const Color(0xFF682242),
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
                ), // text field reason


                Container(
                  padding: const EdgeInsets.only(left:25,top: 20),
                  child: const Text
                    ('Date Of Leave',style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  ),
                ), // text date start


                Padding(
                  padding: const EdgeInsets.only(top:10,right:25,left:25),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    controller: _date,
                    decoration: InputDecoration(
                        hintText: "Date of Leave",
                        prefixIcon: Icon(Icons.edit_calendar_sharp),
                        prefixIconColor: Color(0xFF682242) ,
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
                    onTap: () async{
                      DateTime? pickeddate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100));
                      if(pickeddate != null){
                        setState(() {
                          _date.text = DateFormat('yyyy-MM-dd').format(pickeddate);
                        });
                      }
                    },
                  ),
                ), // date selector 1


                Container(
                  padding: const EdgeInsets.only(left:25,top: 20),
                  child: const Text
                    ('Date Of Return',style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  ),
                ), // text date end


                Padding(
                  padding: const EdgeInsets.only(top: 10,right: 25,left: 25),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    controller: _date_2,
                    decoration: InputDecoration(
                      hintText: "Date of Return",
                        prefixIcon: const Icon(Icons.edit_calendar_sharp),
                        prefixIconColor: const Color(0xFF682242) ,
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
                    onTap: () async{
                      DateTime? pickeddate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100));
                      if(pickeddate != null){
                        setState(() {
                          _date_2.text = DateFormat('yyyy-MM-dd').format(pickeddate);
                        });
                      }
                    },
                  ),
                ), // date selector 2


                // Container(
                //   padding: const EdgeInsets.only(left:25,top: 20),
                //   child: const Text
                //     ('Document',style: TextStyle(
                //     fontSize: 18,
                //     fontWeight: FontWeight.bold,
                //   ),
                //   ),
                // ), // text document
                // Container(
                //   padding: const EdgeInsets.only(top: 10, left: 25, right: 25),
                //   child: Container(
                //     width: double.infinity,
                //     height: 60,
                //     decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(16),
                //       border: Border.all(color: Color(0xFFD9D9D9))
                //     ),
                //       child: isLoading
                //           ?const CircularProgressIndicator()
                //           :TextButton(
                //           onPressed: (){
                //             pickFile();
                //           },
                //           child: Row(
                //             children: const [
                //               SizedBox(
                //                 width: 10,
                //               ),
                //               Icon(Icons.cloud_upload_outlined, color: Color(0xFF682242)),
                //               SizedBox(
                //                 width: 10,
                //               ),
                //               Text("UPLOAD DOCUMENT", style: TextStyle(color: Colors.grey),)
                //
                //             ],
                //           ))
                //   )
                // ), // upload doc
                //
                // if(pickedFile != null)
                //   Padding(
                //     padding: const EdgeInsets.only(left: 35, right: 25, top: 15),
                //     child: Text('File uploaded: $_fileName'),
                //   ),

                Padding (
                  padding: const EdgeInsets.only(top: 30,left: 25,right: 25),
                  child: SizedBox(
                    height: 50,
                    child: InkWell(
                      onTap: (){
                        _apply_leave();
                        showDialog(
                            context: context,
                            builder: (context){
                              return Container(
                                color: const Color.fromARGB(100, 22, 44, 33),
                                child: AlertDialog(
                                  title: const Text("Applied"),
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
                      child: const rdn_button(
                        BtnName: "Apply leave",
                      ),
                    ),
                  ),
                ), // submit



              ],
            ),
          ),
        )

    );
  }

  _apply_leave () async{
    DateTime tempDate_end = DateFormat("yyyy-MM-dd").parse(_date_2.text);
    Timestamp myTimeStamp_end = Timestamp.fromDate(tempDate_end);
    final leave_id = await RestService.getleaveid();
    print(leave_id);
    int i = leave_id.length-1;
    print(i);
    int new_leave_id = int.parse(leave_id[i].toString())+1;
    print(new_leave_id);
    DateTime tempDate_start = DateFormat("yyyy-MM-dd").parse(_date.text);
    Timestamp myTimeStamp_start = Timestamp.fromDate(tempDate_start);
    final firebaseUser = FirebaseAuth.instance.currentUser!;
    final senior = await RestService.getsoid(firebaseUser.uid.toString());
    // print(senior);
    final city = <String, dynamic>{
      "applicant_uid":firebaseUser.uid.toString(),
      "approver_OID":senior,
      "leave_end":myTimeStamp_end,
      "leave_start":myTimeStamp_start,
      "leave_id":new_leave_id,
      "leave_reason":reason.text.toString(),
      "leave_type":selecteditem,
      "status":"pending",
    };

    FirebaseFirestore.instance
        .collection("leave_application")
        .doc(new_leave_id.toString())
        .set(city)
        .onError((e, _) => print("Error writing document: $e"));
  }
}
