import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nutrimeter/Classes/Clients_info.dart';
import 'package:nutrimeter/Classes/Meal_info.dart';
import 'package:nutrimeter/Data/Clients.dart';
import 'package:nutrimeter/Food.dart';
import 'package:nutrimeter/Widgets/Cardlist.dart';

// ignore: must_be_immutable
class Food extends StatefulWidget {
  Food({required this.client, required this.type, required this.addMeal});
  Clients_info client;
  String type;
  Function(Meal_Info meal) addMeal;
  @override
  State<Food> createState() {
    return _UploadState();
  }
}

class _UploadState extends State<Food> {
  List<Meal_Info> meals = [];
  @override
  void initState() {
    initialize();
    super.initState();
  }

  void initialize() async {
    if (widget.type == "Breakfast") {
      for (var food in AllBreakfast) {
        final userdata = await FirebaseFirestore.instance
            .collection('Food')
            .doc(widget.type)
            .collection(food)
            .doc("Data")
            .get();
        var meal = Meal_Info.fromMap(userdata.data()!);
        setState(() {
          meals.add(meal);
        });
      }
    } else if (widget.type == "Dinner") {
      for (var food in AllDinner) {
        final userdata = await FirebaseFirestore.instance
            .collection('Food')
            .doc(widget.type)
            .collection(food)
            .doc("Data")
            .get();
        var meal = Meal_Info.fromMap(userdata.data()!);
        setState(() {
          meals.add(meal);
        });
      }
    } else if (widget.type == "Lunch") {
      for (var food in AllLunch) {
        final userdata = await FirebaseFirestore.instance
            .collection('Food')
            .doc(widget.type)
            .collection(food)
            .doc("Data")
            .get();
        var meal = Meal_Info.fromMap(userdata.data()!);
        setState(() {
          meals.add(meal);
        });
      }
    } else if (widget.type == "Snacks") {
      for (var food in AllSnacks) {
        final userdata = await FirebaseFirestore.instance
            .collection('Food')
            .doc(widget.type)
            .collection(food)
            .doc("Data")
            .get();
        var meal = Meal_Info.fromMap(userdata.data()!);
        setState(() {
          meals.add(meal);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var Height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        actions: const [],
        centerTitle: true,
        title: const Text(
          "Food",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: Height * 0.01),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SearchBar(),
            Padding(
              padding: EdgeInsets.only(top: Height * 0.05),
              child: Text(
                widget.type,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
                child: CardList(
              client: widget.client,
              list: meals,
              addMeal: widget.addMeal,
            ))
          ],
        ),
      ),
    );
  }
}
