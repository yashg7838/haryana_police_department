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
  static Future<List<String>>  getUID() async {
    final List<String> UIDs = [];
    final collectionRef = FirebaseFirestore.instance.collection('leave_application');
    final snapshot = await collectionRef.get();
    final documents = snapshot.docs;
    final myOIDa = await RestService.getOID();


    for (final doc in documents) {
      String status = doc.data()["status"].toString();
      if(status == "pending" && doc.data()["approver_OID"].toString() == myOIDa!["oid"].toString()) {
        UIDs.add(doc.data()["applicant_uid"].toString());
      }
    }
    return UIDs;
  }

  static Future<List<String>>  getName() async {
    final List<String> Names = [];
    final collectionRef = FirebaseFirestore.instance.collection('users');
    final snapshot = await collectionRef.get();
    final documents = snapshot.docs;
    final firebaseUser = await FirebaseAuth.instance.currentUser!;
    final UIDs = await RestService.getUID();
    Map<String, dynamic>? myOID;
    print("object");
    print(UIDs);
    print("object");

    for(int i = 0; i < UIDs.length;i++){
      if (firebaseUser != null) {
        await FirebaseFirestore.instance
            .collection("users")
            .doc(UIDs[i].toString())
            .get()
            .then((ds) {
          myOID = ds.data();
        });
      }
      Names.add(myOID!["name"].toString());
    }


    // for (final doc in documents) {
    //   // print(doc.data());
    //   if(UIDs.contains(doc.data()["uid"].toString())){
    //     Names.add(doc.data()["name"].toString());
    //   }
    // }
    print(Names);
    return Names;
  }

  static Future<List<String>>  getPosts() async {
    final List<String> Posts = [];
    final collectionRef = FirebaseFirestore.instance.collection('users');
    final snapshot = await collectionRef.get();
    final documents = snapshot.docs;
    final myOIDa = await RestService.getOID();
    final UIDs = await RestService.getUID();
    final firebaseUser = await FirebaseAuth.instance.currentUser!;
    Map<String, dynamic>? myOID;



    for(int i = 0; i < UIDs.length;i++){
      if (firebaseUser != null) {
        await FirebaseFirestore.instance
            .collection("users")
            .doc(UIDs[i].toString())
            .get()
            .then((ds) {
          myOID = ds.data();
        });
      }
      Posts.add(myOID!["post"].toString());
    }

    // for (final doc in documents) {
    //   // print(doc.data());
    //   if(UIDs.contains(doc.data()["uid"].toString())){
    //     Posts.add(doc.data()["post"].toString());
    //   }
    // }
    print(Posts);
    return Posts;
  }

  static Future<List<String>>  getLeaves_ID() async {
    final List<String> Leaves_ID = [];
    final collectionRef = FirebaseFirestore.instance.collection('leave_application');
    final snapshot = await collectionRef.get();
    final documents = snapshot.docs;
    final myOIDa = await RestService.getOID();
    final UIDs = await RestService.getUID();



    for (final doc in documents) {
      if(UIDs.contains(doc.data()["applicant_uid"].toString()) && doc.data()["status"].toString() == "pending" && doc.data()["approver_OID"].toString() == myOIDa!["oid"].toString()){
        Leaves_ID.add(doc.data()["leave_id"].toString());
      }
    }
    print(Leaves_ID);
    return Leaves_ID;
  }

  static Future<Map<String, dynamic>?> getthisUID(leave_id) async{
    Map<String, dynamic>? myOID;
    final firebaseUser = await FirebaseAuth.instance.currentUser!;
    if (firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection("leave_application")
          .doc(leave_id.toString())
          .get()
          .then((ds) {
        myOID = ds.data();
      });
    }
    // print(myOID);
    return myOID;
  }

  static Future<Map<String, dynamic>?> getthisCLleaves(leave_id) async{
    final UIDs = await RestService.getthisUID(leave_id);
    Map<String, dynamic>? myLeave;
    final firebaseUser = await FirebaseAuth.instance.currentUser!;
    if (firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection("leaves")
          .doc(UIDs!["applicant_uid"])
          .get()
          .then((ds) {
        myLeave = ds.data();
      });
    }
    return myLeave;
  }

  static Future<Map<String, dynamic>?> getOID() async{
    Map<String, dynamic>? myOID;
    final firebaseUser = await FirebaseAuth.instance.currentUser!;
    if (firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection("UIDtoOID")
          .doc(firebaseUser.uid)
          .get()
          .then((ds) {
        myOID = ds.data();
      });
    }
    print(myOID);
    return myOID;
  }

  static Future<List<Map<String, dynamic>>> getMyLeaves() async{
    final firebaseUser = await FirebaseAuth.instance.currentUser!;
    final List<Map<String, dynamic>> UIDs = [];
    final collectionRef = FirebaseFirestore.instance.collection('leave_application');
    final snapshot = await collectionRef.get();
    final documents = snapshot.docs;

    for (final doc in documents) {
      if(doc.data()["applicant_uid"].toString() == firebaseUser.uid) {
        UIDs.add(doc.data());
      }
    }
    print(UIDs[0]["leave_id"]);
    return UIDs;
  }

  static Future<List>  getleaveid() async {
    final List<String> Leaves_ID = [];
    final collectionRef = FirebaseFirestore.instance.collection('leave_application');
    print(collectionRef);
    final snapshot = await collectionRef.get();
    print(snapshot);
    final documents = snapshot.docs;
    final myOIDa = await RestService.getOID();
    final UIDs = await RestService.getUID();
    final leave_ids = [];



    for (final doc in documents) {
      // print(doc.data());
      print(doc.id.toString());
      leave_ids.add(doc.id.toString());
    }
    return leave_ids;
  }

  static Future<String> getsoid(userid) async{
    Map<String, dynamic>? myOID;
    final firebaseUser = await FirebaseAuth.instance.currentUser!;
    if (firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(userid)
          .get()
          .then((ds) {
        myOID = ds.data();
      });
    }
    // print(myOID);
    return myOID!["senior_oid"];
  }

}


