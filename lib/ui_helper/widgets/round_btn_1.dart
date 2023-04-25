// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'package:flutter/material.dart';


class rdn_button extends StatelessWidget {
  final String BtnName;
  // final String link;

  const rdn_button({super.key,
    required this.BtnName,
    // required this.link
});

  @override
  Widget build(BuildContext context) {
  return SizedBox.expand(
    child: Container(

      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            Color(0xFF2F3374),
            Color(0xFF682242)
          ]
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            spreadRadius: 2,
            blurRadius: 3,
            offset: Offset(1, 1)
          )
        ]
      ),
      child: Center(child: Text(BtnName, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),)),
    ),
  );
  }
}
