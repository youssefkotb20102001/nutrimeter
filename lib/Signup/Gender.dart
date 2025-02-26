import 'package:flutter/material.dart';
import 'package:nutrimeter/Classes/Clients_info.dart';

class GenderType extends StatefulWidget {
  GenderType({required this.client});
  final Clients_info client;
  _GenderState createState() => _GenderState();
}

class _GenderState extends State<GenderType> {
  var _selectedContainerIndex = -1;
  @override
  Widget build(BuildContext context) {
    //var width = MediaQuery.of(context).size.width;
    var Height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Expanded(
        child: Column(
          children: [
            Text("What is your gender"),
            SizedBox(height: Height * 0.1),
            _buildContainer(0, "lib/Assets/Male.png", "Male"),
            SizedBox(height: Height * 0.04),
            _buildContainer(1, "lib/Assets/Female.png", "Female")
          ],
        ),
      ),
    );
  }

  Widget _buildContainer(int index, String image, String text) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.client.gender = text;
          _selectedContainerIndex = index; // Update the selected index
        });
      },
      child: Container(
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 240, 197, 140),
            border: Border.all(
              color: _selectedContainerIndex == index
                  ? Colors.orange
                  : Colors.transparent, // Border color change
              width: 2,
            ),
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            Image.asset(image),
            Text(text),
          ],
        ),
      ),
    );
  }
}
