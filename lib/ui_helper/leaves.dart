import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class LeavesList {
  String applicant_uid;

  LeavesList(this.applicant_uid);

  factory LeavesList.fromJson(Map<String, dynamic> rec){
    return (LeavesList(
        rec['applicant_uid']
    ));
  }
}

class RestService{
  static Future<List<LeavesList>> getData() async{
    List<LeavesList> lst = [];
    final firebaseUser = await FirebaseAuth.instance.currentUser!;
    if (firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection("leave_application")
          .doc("100001")
          .get()
          .then((ds) {
        lst = ds.data()! as List<LeavesList>;
      });
    }
    return lst;
  }
}
