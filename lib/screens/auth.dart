import 'package:flutter/material.dart';
import 'package:haryana_police_department/screens/login.dart';
import 'package:haryana_police_department/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Check extends StatelessWidget {
  const Check({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:StreamBuilder<User?>(stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context , snapshot){
            if(snapshot.hasData){
              return home();
            }
            else{
              return login();
            }
          },),
        );
    }
}