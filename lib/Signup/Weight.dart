import 'package:flutter/material.dart';
import 'package:nutrimeter/Classes/Clients_info.dart';

class Weight extends StatefulWidget {
  Weight({required this.client, required this.controller});
  final Clients_info client;
  final TextEditingController controller;
  _WeightState createState() => _WeightState();
}

class _WeightState extends State<Weight> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var Height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        const Text(
          "What is your current weight",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: Height * 0.1),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: width * 0.1,
              height: Height * 0.05,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromARGB(144, 96, 197, 233)),
                child: TextField(
                  decoration: InputDecoration(border: InputBorder.none),
                  controller: widget.controller,
                  keyboardType: TextInputType.number,
                ),
              ),
            ),
            SizedBox(
              width: width * 0.05,
            ),
            SizedBox(
              width: width * 0.1,
              height: Height * 0.05,
              child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromARGB(144, 96, 197, 233)),
                  child: Text(
                    "KG",
                    style: TextStyle(fontSize: 24),
                  )),
            ),
          ],
        )
      ],
    );
  }
}
