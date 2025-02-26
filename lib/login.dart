import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nutrimeter/Classes/Clients_info.dart';
import 'package:nutrimeter/Tabs.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() {
    return _LoginState();
  }
}

class _LoginState extends State<Login> {
  final _Passwordcontroller = TextEditingController();
  final _Emailcontroller = TextEditingController();
  bool _isObscured = true;
  bool _remember = false;
  bool _isLoading = false;

  void dispose() {
    _Passwordcontroller.dispose();
    _Emailcontroller.dispose();
    super.dispose();
  }

  Widget textfeild(TextEditingController controller) {
    return Container(
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 236, 235, 235),
            borderRadius: BorderRadius.circular(15)),
        child: TextField(
          decoration: InputDecoration(border: InputBorder.none),
          controller: controller,
          keyboardType: TextInputType.text,
        ));
  }

  void _onButtonPressed() async {
    setState(() {
      _isLoading = true;
    });
  }

  void showerrormessage() {
    showDialog(
        context: context,
        builder: ((ctx) => AlertDialog(
              title: const Text('Incorrect Username or Password'),
              content: const Text(
                  'Data you entered is not valid or check your internet connection and try again'),
              actions: [
                TextButton(
                    onPressed: (() {
                      Navigator.pop(ctx);
                    }),
                    child: const Text('Close'))
              ],
            )));
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var Height = MediaQuery.of(context).size.height;
    var maincolor = Color.fromARGB(255, 171, 235, 246);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: maincolor,
        foregroundColor: Colors.black,
        shadowColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: width,
              height: Height * 0.2,
              child: Container(
                decoration: BoxDecoration(
                    color: maincolor,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(40))),
                child: Padding(
                  padding:
                      EdgeInsets.fromLTRB(width * 0.2, Height * 0.04, 0, 0),
                  child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Welcome Back!",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold)),
                        Text("  Lets Continue the journey",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold))
                      ]),
                ),
              ),
            ),
            SizedBox(height: Height * 0.1),
            Center(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Email Address:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: Height * 0.01,
                    ),
                    SizedBox(
                        width: width * 0.5, child: textfeild(_Emailcontroller)),
                    SizedBox(
                      height: Height * 0.02,
                    ),
                    SizedBox(
                      width: width * 0.5,
                      child: Row(
                        children: [
                          const Text(
                            "Password:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                          GestureDetector(
                            onLongPress: () {
                              setState(() {
                                _isObscured = false;
                              });
                            },
                            onLongPressUp: () {
                              setState(() {
                                _isObscured = true;
                              });
                            },
                            child: IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.remove_red_eye_outlined)),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Height * 0.01,
                    ),
                    SizedBox(
                        width: width * 0.5,
                        child: Container(
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 236, 235, 235),
                                borderRadius: BorderRadius.circular(15)),
                            child: TextField(
                              obscureText: _isObscured,
                              decoration:
                                  InputDecoration(border: InputBorder.none),
                              controller: _Passwordcontroller,
                              keyboardType: TextInputType.text,
                            ))),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: width * 0.5,
              child: Row(
                children: [
                  Checkbox(
                    value: _remember,
                    onChanged: (bool? newValue) {
                      setState(() {
                        _remember = newValue ?? false;
                      });
                    },
                    activeColor: maincolor,
                    checkColor: Colors.black,
                  ),
                  Text("Remember Me")
                ],
              ),
            ),
            SizedBox(
              width: width * 0.5,
              child: ElevatedButton(
                  onPressed: _isLoading
                      ? null
                      : () {
                          _onButtonPressed();
                          //Navigate to the second screen when the button is pressed
                          FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: _Emailcontroller.text.trim(),
                                  password: _Passwordcontroller.text)
                              .then((value) async {
                            final userdata = await FirebaseFirestore.instance
                                .collection('Users')
                                .doc(_Emailcontroller.text.trim())
                                .get();

                            Clients_info client =
                                Clients_info.fromMap(userdata.data()!);

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Tabs(
                                        client: client,
                                      )),
                            );
                          }).onError(
                            (error, stackTrace) {
                              showerrormessage();
                              _isLoading = false;
                            },
                          );
                        },
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.orange, //background color of button

                      elevation: 3, //elevation of button
                      shape: RoundedRectangleBorder(
                          //to set border radius to button
                          borderRadius: BorderRadius.circular(20)),
                      padding: const EdgeInsets.all(
                          20) //content padding inside button

                      ),
                  child: _isLoading
                      ? const Row(
                          children: [
                            const Text(
                              "Sign in",
                              style: TextStyle(color: Colors.black),
                            ),
                            Spacer(),
                            CircularProgressIndicator(
                              strokeWidth: 2.0,
                              color: Colors.white,
                            ),
                          ],
                        )
                      : Text(
                          "Sign in",
                          style: TextStyle(color: Colors.black),
                        )),
            ),
            TextButton(
                onPressed: () {},
                child: const Text(
                  "forget Password?",
                  style: TextStyle(
                      color: Colors.black,
                      decoration: TextDecoration.underline),
                ))
          ],
        ),
      ),
    );
  }
}
