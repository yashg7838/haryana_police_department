// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:haryana_police_department/screens/change_password.dart';
import 'package:haryana_police_department/screens/home.dart';
import 'package:haryana_police_department/ui_helper/widgets/round_btn_1.dart';
import 'package:firebase_auth/firebase_auth.dart';

// ignore: camel_case_types
class web_login extends StatefulWidget{
  const web_login({super.key});

  @override
  State<web_login> createState() => _web_loginState();
}

class _web_loginState extends State<web_login> {
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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body:
      SafeArea(
        child: Container(
          height: height,
          width: width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bg_image.png"),
              fit: BoxFit.fitHeight
            )
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: width*0.6,
                height: height,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black.withOpacity(0.6)
                          ),
                          height: 300,
                          width: width*0.3,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            // crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Text("Welcome! Please Login.",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Form(
                                  key: _formKey,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: width*0.02, right: width*0.02),
                                        child: SizedBox(
                                          height: 50,
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
                                                            Container(
                                                              decoration: BoxDecoration(
                                                                color: Colors.white,
                                                                borderRadius: BorderRadius.circular(4)
                                                              ),
                                                              height: 40,
                                                              child: TextFormField(
                                                                cursorColor: Colors.white,
                                                                controller: _emailController,
                                                                validator: (value) {
                                                                  if (value == null || value.isEmpty) {
                                                                    return 'Please enter some text';
                                                                  }
                                                                  return null;
                                                                },
                                                                keyboardType: TextInputType.emailAddress,
                                                                decoration: InputDecoration(
                                                                    hintText: "Enter Email ID",
                                                                    hintStyle: const TextStyle(
                                                                      fontSize: 13
                                                                    ),
                                                                    enabledBorder: OutlineInputBorder(
                                                                        borderRadius: BorderRadius.circular(4),
                                                                        borderSide: const BorderSide(
                                                                          color: Color(0xFFD9D9D9),
                                                                          // width: 2
                                                                        )
                                                                    ),
                                                                    errorBorder: OutlineInputBorder(
                                                                        borderRadius: BorderRadius.circular(4),
                                                                        borderSide: const BorderSide(
                                                                          color: Colors.red,
                                                                          // width: 2
                                                                        )
                                                                    ),
                                                                    focusedBorder: OutlineInputBorder(
                                                                        borderRadius: BorderRadius.circular(4),
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


                                      const SizedBox(
                                        height: 10,
                                      ),


                                      Padding(
                                        padding: EdgeInsets.only(left: width*0.02, right: width*0.02),
                                        child: SizedBox(
                                          height: 50,
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
                                                            Container(
                                                              decoration: BoxDecoration(
                                                                color: Colors.white,
                                                                borderRadius: BorderRadius.circular(4)
                                                              ),
                                                              height: 40,
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
                                                                    hintStyle: const TextStyle(
                                                                      fontSize: 13
                                                                    ),
                                                                    enabledBorder: OutlineInputBorder(
                                                                        borderRadius: BorderRadius.circular(4),
                                                                        borderSide: const BorderSide(
                                                                          color: Color(0xFFD9D9D9),
                                                                          // width: 2
                                                                        )
                                                                    ),
                                                                    errorBorder: OutlineInputBorder(
                                                                        borderRadius: BorderRadius.circular(4),
                                                                        borderSide: const BorderSide(
                                                                          color: Colors.red,
                                                                          // width: 2
                                                                        )
                                                                    ),
                                                                    focusedBorder: OutlineInputBorder(
                                                                        borderRadius: BorderRadius.circular(4),
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
                                          height: 20
                                      ),


                                      Padding(
                                        padding: EdgeInsets.only(left: width*0.02, right: width*0.02),
                                        child: SizedBox(
                                          height: 40,
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
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}