import 'package:flutter/material.dart';
import 'package:nutrimeter/Classes/Clients_info.dart';
import 'package:nutrimeter/Classes/Meal_info.dart';
import 'package:nutrimeter/Food.dart';

// ignore: must_be_immutable
class Upload extends StatefulWidget {
  Upload({required this.client, required this.addMeal});
  Clients_info client;
  Function(Meal_Info meal) addMeal;
  @override
  State<Upload> createState() {
    return _UploadState();
  }
}

class _UploadState extends State<Upload> {
  InkWell meal(double width, String mealname, int kcal) {
    return InkWell(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Food(
                    client: widget.client,
                    type: mealname,
                    addMeal: widget.addMeal,
                  )),
        );
      },
      child: Container(
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 233, 231, 231),
            borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: width * 0.2,
            child: Column(
              children: [
                const Icon(
                  Icons.add_circle,
                  color: Colors.orange,
                ),
                Text(
                  mealname,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  kcal.toString(),
                  style: TextStyle(color: Colors.brown),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var Height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: Height * 0.4,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    Container(
                      child: Text("meal"),
                    ),
                    Spacer(),
                    Text("water")
                  ],
                ),
              ),
            ),
            SizedBox(
              height: Height * 0.05,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                meal(width, "Breakfast", 440),
                SizedBox(
                  width: width * 0.2,
                ),
                meal(width, "Lunch", 440),
              ],
            ),
            SizedBox(
              height: Height * 0.05,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                meal(width, "Snacks", 440),
                SizedBox(
                  width: width * 0.2,
                ),
                meal(width, "Dinner", 440),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
