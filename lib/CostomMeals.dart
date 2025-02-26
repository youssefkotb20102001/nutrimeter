import 'package:flutter/material.dart';
import 'package:nutrimeter/Classes/Clients_info.dart';
import 'package:nutrimeter/Classes/Meal_info.dart';
import 'package:nutrimeter/Data/Clients.dart';
import 'package:nutrimeter/Widgets/Cardlist.dart';

class CostomPage extends StatefulWidget {
  CostomPage(
      {required this.client, required this.addMeal, required this.meals});
  Clients_info client;
  List<Meal_Info> meals;
  Function(Meal_Info meal) addMeal;
  @override
  State<CostomPage> createState() {
    return _HomepageState();
  }
}

class _HomepageState extends State<CostomPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Costom Meals"),
      ),
      body: Column(
        children: [
          Expanded(
            child: CardList(
                list: widget.meals,
                addMeal: widget.addMeal,
                client: widget.client),
          ),
        ],
      ),
    );
  }
}
