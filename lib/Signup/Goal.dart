import 'package:flutter/material.dart';
import 'package:nutrimeter/Classes/Clients_info.dart';

// ignore: must_be_immutable
class Goal extends StatefulWidget {
  Goal({required this.client, required this.createContainer});
  final Clients_info client;
  Widget Function(String text, double width, double height, int index)
      createContainer;
  _GoalState createState() => _GoalState();
}

class _GoalState extends State<Goal> {
  var _selectedContainerIndex;
  var selected = 0;
  var container_color = Color.fromARGB(144, 96, 197, 233);
  Widget _buildContainer(int index, String text, double width, double height) {
    width = width * 0.9;
    height = height * 0.05;

    return GestureDetector(
        onTap: () {
          setState(() {
            widget.client.goal = text;
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
                child: Text(text),
              ),
            ),
            SizedBox(
              height: height * 0.3,
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var Height = MediaQuery.of(context).size.height;

    return Column(
      children: [
        const Text(
          "What is Your goal?",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: Height * 0.05,
        ),
        _buildContainer(0, "Weight gain", width, Height),
        _buildContainer(1, "Maintain my current waight", width, Height),
        _buildContainer(2, "Weight Loss", width, Height),
      ],
    );
  }
}
