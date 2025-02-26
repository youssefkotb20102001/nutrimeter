import 'package:flutter/material.dart';
import 'package:nutrimeter/Classes/Clients_info.dart';
import 'package:nutrimeter/Signup/Activity_Level.dart';
import 'package:nutrimeter/Signup/BirthDate.dart';
import 'package:nutrimeter/Signup/Gender.dart';
import 'package:nutrimeter/Signup/Goal.dart';
import 'package:nutrimeter/Signup/Height.dart';
import 'package:nutrimeter/Signup/Setting_up_profile.dart';
import 'package:nutrimeter/Signup/Signup.dart';
import 'package:nutrimeter/Signup/Weight.dart';
import 'package:nutrimeter/Signup/weightLoss.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Signup_Scrollable extends StatefulWidget {
  @override
  _Signup_ScrollableState createState() => _Signup_ScrollableState();
}

class _Signup_ScrollableState extends State<Signup_Scrollable> {
  PageController _pageController = PageController();
  final _KGcontroller = TextEditingController();
  final _KGLosscontroller = TextEditingController();
  final _CMcontroller = TextEditingController();
  DateTime selectedDate = DateTime.now();
  var container_color = const Color.fromARGB(255, 255, 169, 41);
  bool _enable = true;
  int _currentPage = 0;
  final Clients_info client = Clients_info();

  @override
  void dispose() {
    _KGcontroller.dispose();
    _KGLosscontroller.dispose();
    _CMcontroller.dispose();
    super.dispose();
  }

  void nextpage() {
    _pageController.nextPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  void date(DateTime newDate) {
    setState(() {
      selectedDate = newDate;
    });
  }

  void changeColor(int page) {
    // if (container_color == Color.fromARGB(229, 171, 174, 174)) {
    //   setState(() {
    //     container_color = const Color.fromARGB(255, 255, 169, 41);
    //     _enable = true;
    //   });
    // } else {
    //   setState(() {
    //     container_color = Color.fromARGB(229, 171, 174, 174);
    //     _enable = false;
    //   });
    // }

    if (page == 0 || page == 7) {
      setState(() {
        container_color = const Color.fromARGB(255, 255, 169, 41);
        _enable = true;
      });
    } else {
      setState(() {
        container_color = Color.fromARGB(229, 171, 174, 174);
        _enable = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // var width = MediaQuery.of(context).size.width;
    var Height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        children: [
          // Page indicators (dots)
          Padding(
            padding: EdgeInsets.fromLTRB(0, Height * 0.1, 0, 0),
            child: SmoothPageIndicator(
              controller: _pageController,
              count: 8, // Number of pages
              effect: const WormEffect(
                dotHeight: 12.0,
                dotWidth: 12.0,
                spacing: 16.0,
                activeDotColor: Color.fromARGB(255, 118, 57, 19),
              ),
            ),
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
                changeColor(page);
              },
              children: <Widget>[
                _buildPage(
                    context,
                    '',
                    SettingProfile(
                      client: client,
                    )),
                _buildPage(
                    context,
                    '',
                    Goal(
                      client: client,
                      createContainer: (text, width, height, index) {
                        width = width * 0.9;
                        height = height * 0.05;
                        return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  client.goal = text;
                                });
                              },
                              child: Container(
                                width: width,
                                height: height,
                                decoration: BoxDecoration(
                                    color: container_color,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(text),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.3,
                            )
                          ],
                        );
                      },
                    )),
                _buildPage(
                    context,
                    '',
                    Weight(
                      controller: _KGcontroller,
                      client: client,
                    )),
                _buildPage(
                    context,
                    '',
                    WeightLoss(
                      controller: _KGLosscontroller,
                      client: client,
                    )),
                _buildPage(
                    context,
                    '',
                    GenderType(
                      client: client,
                    )),
                _buildPage(
                    context,
                    '',
                    ActivityLevel(
                      client: client,
                    )),
                _buildPage(
                    context,
                    '',
                    Heights(
                      controller: _CMcontroller,
                      client: client,
                    )),
                _buildPage(
                    context,
                    '',
                    BirthDate(
                      client: client,
                      date: selectedDate,
                      changedate: date,
                    )),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(Height * 0.1),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: container_color,
                      borderRadius: BorderRadius.circular(100)),
                  child: IconButton(
                      onPressed: () {
                        if (_enable == true) {
                          if (_currentPage == 7) {
                            client.height =
                                double.parse(_CMcontroller.value.text);
                            client.weight =
                                double.parse(_KGcontroller.value.text);
                            client.weightLoss =
                                double.parse(_KGLosscontroller.value.text);
                            client.dob = selectedDate.toString();
                            if (client.gender == 'Male' ||
                                client.gender == 'male') {
                              client.kcal = 2500;
                            } else {
                              client.kcal = 2000;
                            }

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Signup(
                                        client: client,
                                      )),
                            );
                          } else {
                            nextpage();
                          }
                        }
                      },
                      icon: const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      )),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?"),
                    TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Sign in",
                          style: TextStyle(
                              color: Colors.black,
                              decoration: TextDecoration.underline),
                        ))
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPage(BuildContext context, String title, Widget textField) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontSize: 24.0),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20.0),
          textField,
        ],
      ),
    );
  }
}
