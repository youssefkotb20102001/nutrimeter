import 'package:flutter/material.dart';
import 'package:nutrimeter/Classes/Clients_info.dart';

class ActivityLevel extends StatefulWidget {
  ActivityLevel({required this.client});
  final Clients_info client;
  _ActivityLevelState createState() => _ActivityLevelState();
}

class _ActivityLevelState extends State<ActivityLevel> {
  var selected = 0;
  var container_color = Color.fromARGB(144, 96, 197, 233);
  var _selectedContainerIndex = -1;

  Widget createContainer(
      String text1, String text2, double width, double height, var index) {
    width = width * 0.9;
    height = height * 0.08;
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.client.activityLevel = text1;
          _selectedContainerIndex = index; // Update the selected index
        });
      },
      child: Column(
        children: [
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
                color: _selectedContainerIndex == index
                    ? const Color.fromARGB(255, 253, 181, 73)
                    : container_color,
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      text1,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(text2)
                  ]),
            ),
          ),
          SizedBox(
            height: height * 0.3,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var Height = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Text(
          "What is your activity level ?",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: Height * 0.05,
        ),
        createContainer(
            "Sedentary",
            "Daily activities require minimal effort such as resting, desk work or driving.",
            width,
            Height,
            0),
        createContainer(
            "Low Active",
            "Daily activities require some effort such as periods of standing, housework or some light exercise.",
            width,
            Height,
            1),
        createContainer(
            "Active",
            "Daily activities require responsible effort such as standing, physical work or regular moderate exercise.",
            width,
            Height,
            2),
        createContainer(
            "Very Active",
            "Daily activities require intense physical effort such as construction work or regular vigorous exercise. ",
            width,
            Height,
            3),
      ],
    );
  }
}
