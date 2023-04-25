import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:haryana_police_department/screens/auth.dart';

import 'login.dart';

class splash extends StatefulWidget {
  const splash({super.key});
  @override
  State<StatefulWidget> createState() => _SplashState();
}

class _SplashState extends State<splash> {

  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 2),
        () async {
        FirebaseApp app = await Firebase.initializeApp();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Check(),));
        }
    );
}

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    body: Image.asset(
      "assets/images/splash_screen.jpg",
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    ),
  );
  }
}
