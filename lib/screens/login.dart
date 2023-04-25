// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:haryana_police_department/screens/change_password.dart';
import 'package:haryana_police_department/screens/home.dart';
import 'package:haryana_police_department/ui_helper/widgets/round_btn_1.dart';
import 'package:firebase_auth/firebase_auth.dart';

// ignore: camel_case_types
class login extends StatefulWidget{
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late String errorMessage;
  Future sign_in() async{
    showDialog(
        context: context,
        builder: (context){
          return const Center(
            child: CircularProgressIndicator(
              color: Color(0xFF2F3374),
            )
          );
        }
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim()
      );
      Navigator.of(context).pop();
    } on Exception catch (e) {

      Navigator.of(context).pop();
      showDialog(
          context: context,
          builder: (context){
            return AlertDialog(
              title: const Text("Error"),
              content: const Text("You have entered invalid credentials. Please try again."),
              actions: <Widget>[
                TextButton(
                    onPressed:()=> Navigator.of(context).pop(),
                    child: const Text("OK")
                )
              ],
            );
          }
      );
    }
  }
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  @override

  Widget build(BuildContext context) {

    return Scaffold(
      body:
      SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(top:20, left: 20),
                  child: Text("Login",
                    style: TextStyle(
                        fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),


              Form(
                key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [


                      Padding(
                        padding: const EdgeInsets.only(top: 50, left: 25,right: 25),
                        child: SizedBox(
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
                                              child: Text("Email",
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
                                                controller: _emailController,
                                                validator: (value) {
                                                  if (value == null || value.isEmpty) {
                                                    return 'Please enter some text';
                                                  }
                                                  return null;
                                                },
                                                keyboardType: TextInputType.emailAddress,
                                                decoration: InputDecoration(
                                                    hintText: "Example@gmail.com",
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
                        ),
                      ), // Email


                      Padding(
                        padding: const EdgeInsets.only(left: 25,right: 25),
                        child: SizedBox(
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
                                              child: Text("Password",
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
                                                controller: _passwordController,
                                                validator: (value) {
                                                  if (value == null || value.isEmpty) {
                                                    return 'Please enter some text';
                                                  }
                                                  return null;
                                                },
                                                obscureText: true,
                                                obscuringCharacter: "*",
                                                keyboardType: TextInputType.text,
                                                decoration: InputDecoration(
                                                    hintText: "******",
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
                        ),
                      ), // Password


                      const SizedBox(
                          height: 30
                      ),


                      Padding (
                        padding: const EdgeInsets.only(left: 25,right: 25),
                        child: SizedBox(
                          height: 50,
                          child: Column(
                            children:   [
                              Flexible(
                                  flex: 8,
                                  fit: FlexFit.tight,
                                  child: InkWell(
                                    onTap: (){
                                      if (_formKey.currentState!.validate()) {
                                        sign_in();
                                      }
                                    },
                                    child: const rdn_button(
                                      BtnName: "Continue",
                                    ),
                                  )
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}