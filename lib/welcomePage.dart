import 'package:flutter/material.dart';

import 'package:nutrimeter/Signup/scrollable.dart';
import 'package:nutrimeter/login.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var Height = MediaQuery.of(context).size.height;
    var button_color = Colors.orange;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("lib/Assets/welcomepagebackground.png"),
                    opacity: 0.85,
                    fit: BoxFit.fill)),
          ),
          Column(
            children: [
              SizedBox(
                height: Height * 0.2,
              ),
              Row(
                children: [
                  SizedBox(
                    width: width * 0.4,
                  ),
                  const Text(
                    "Meal Plans",
                    style: TextStyle(
                        color: Color.fromARGB(255, 82, 81, 81),
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Divider(
                color: const Color.fromARGB(255, 63, 63, 63), // Line color
                thickness: 4, // Line thickness
                indent: 0, // Left spacing
                endIndent: width * 0.39, // Right spacing
              ),
            ],
          ),
          Positioned(
              top: Height * 0.6,
              bottom: 0,
              child: SizedBox(
                width: width,
                child: Opacity(
                  opacity: 0.85,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 171, 235, 246),
                      borderRadius: BorderRadius.circular(60),
                      shape: BoxShape.rectangle,
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: Height * 0.1,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                              width * 0.08, 0, width * 0.08, Height * 0.04),
                          child: const Text(
                            "Your ultimate nutrition guide. Sign in to start or if you still didn’t create an account Go Ahead and create it one !!",
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          width: width * 0.7,
                          child: ElevatedButton(
                              onPressed: () {
                                // Navigate to the second screen when the button is pressed
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Signup_Scrollable()),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      button_color, //background color of button

                                  elevation: 3, //elevation of button
                                  shape: RoundedRectangleBorder(
                                      //to set border radius to button
                                      borderRadius: BorderRadius.circular(20)),
                                  padding: const EdgeInsets.all(
                                      20) //content padding inside button

                                  ),
                              child: const Text(
                                "I am a new user",
                                style: TextStyle(color: Colors.black),
                              )),
                        ),
                        SizedBox(
                          height: Height * 0.02,
                        ),
                        SizedBox(
                          width: width * 0.7,
                          child: ElevatedButton(
                              onPressed: () {
                                // Navigate to the second screen when the button is pressed
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Login()),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Colors.white, //background color of button
                                  //border width and color
                                  elevation: 3, //elevation of button
                                  shape: RoundedRectangleBorder(
                                      //to set border radius to button
                                      borderRadius: BorderRadius.circular(20)),
                                  padding: const EdgeInsets.all(
                                      20) //content padding inside button

                                  ),
                              child: const Text(
                                "I already have an account",
                                style: TextStyle(color: Colors.black),
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
