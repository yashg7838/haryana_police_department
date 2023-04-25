import 'package:flutter/material.dart';
import 'package:haryana_police_department/screens/login.dart';

// ignore: camel_case_types
class landing extends StatelessWidget{
  const landing({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body:
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset("assets/images/HP_logo.png" ,height: 250,),
          const SizedBox(
            height: 50,
          ),
          const Center(
              child:
              Text("Haryana Police",
                style: TextStyle(
                  color: Color(0xFFa8a302),
                  fontWeight: FontWeight.bold,
                  fontSize: 30
              ),
              )
          ),
          const SizedBox(
            height: 5,
          ),
          const Center(
              child:
              Text("Department",
                style: TextStyle(
                    color: Color(0xFFa8a302),
                    fontWeight: FontWeight.bold,
                    fontSize: 30
                ),
              )
          ),
          const SizedBox(
            height: 50,
          ),
          SizedBox(
            width: 200,
            child: ElevatedButton(onPressed: (){
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => const login(),));
            },
                child: const Text("Enter"),
            ),
          )
        ],
      ),
    );
  }
}