import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nutrimeter/Classes/Clients_info.dart';

// ignore: must_be_immutable
class BirthDate extends StatefulWidget {
  BirthDate(
      {required this.client, required this.date, required this.changedate});
  final Clients_info client;
  DateTime date;
  void Function(DateTime date) changedate;
  _BirthDateState createState() => _BirthDateState();
}

class _BirthDateState extends State<BirthDate> {
  final _CMcontroller = TextEditingController();

  void dispose() {
    _CMcontroller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // var width = MediaQuery.of(context).size.width;
    var Height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        const Text(
          "What is your date of birth",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: Height * 0.1),
        Center(
          child: Container(
            height: 200,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: widget.date,
              onDateTimeChanged: widget.changedate,
              use24hFormat: true,
              minimumDate: DateTime(1900),
              maximumDate: DateTime(2100),
            ),
          ),
        ),
      ],
    );
  }
}
