import 'package:flutter/material.dart';
import 'package:nutrimeter/Classes/Clients_info.dart';

class SettingProfile extends StatelessWidget {
  SettingProfile({required this.client});
  final Clients_info client;
  @override
  Widget build(BuildContext context) {
    //var width = MediaQuery.of(context).size.width;
    var Height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Text(
          "Setting Up Your Profile",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: Height * 0.1,
        ),
        Text(
            "Welcome! Ready to get started? Let's figure out your Recommended Daily Intake (RDI). Your RDI depends on things like your goals, how active you are, your age, and height. It's like your personal guide to how much food you need each day! This helps us tailor your calorie intake to fit your unique goals. Let's set up your profile for personalized nutritional advice!"),
        SizedBox(
          height: Height * 0.1,
        ),
      ],
    );
  }
}
