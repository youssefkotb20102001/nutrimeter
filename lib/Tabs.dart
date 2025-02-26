import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:nutrimeter/Classes/Clients_info.dart';
import 'package:nutrimeter/Classes/Meal_info.dart';
import 'package:nutrimeter/CostomMeals.dart';
import 'package:nutrimeter/Data/Clients.dart';
import 'package:nutrimeter/Homepage.dart';
import 'package:nutrimeter/Upload.dart';
import 'package:nutrimeter/profile.dart';
import 'package:nutrimeter/scan.dart';

// ignore: must_be_immutable
class Tabs extends StatefulWidget {
  Tabs({required this.client});
  Clients_info client;
  @override
  State<Tabs> createState() {
    return _TabsState();
  }
}

class _TabsState extends State<Tabs> {
  var _pageIndex = 0;
  Widget activescreen = const Text('');
  List<Card> meals = [];
  List<Meal_Info> costommeals = [];

  var selectedpageindex = 0;
  @override
  void initState() {
    GetMeals();
    listofmeals();
    super.initState();
  }

  void _selectpage(int index) {
    if (index == 3) {
      _OpenAddExpenseOverlay();
    } else {
      setState(() {
        selectedpageindex = index;
      });
    }
  }

  void addMeal(Meal_Info meal) {
    var card = Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Column(
              children: [
                Text(
                  meal.meal!,
                  style: TextStyle(color: Colors.orange, fontSize: 18),
                ),
                Text(meal.name!),
                Text(
                  "${meal.kcAl.toString()} Kcal",
                  style: const TextStyle(
                      color: Color.fromARGB(176, 158, 158, 158)),
                )
              ],
            ),
            Spacer(),
            if (meal.meal == "Breakfast")
              Image.asset("lib/Assets/buritto 2.png")
            else if (meal.meal == "Lunch")
              Image.asset("lib/Assets/pizza 1.png")
            else if (meal.meal == "Snacks")
              Image.asset("lib/Assets/fries 1.png")
            else if (meal.meal == "Dinner")
              Image.asset("lib/Assets/steak 2.png")
          ],
        ),
      ),
    );
    setState(() {
      meals.add(card);
    });
  }

  void listofmeals() async {
    Database database = Database();
    List<Map<String, String>> map = await database.getUsersFood(widget.client);
    for (var item in map) {
      item.forEach((key, value) async {
        Meal_Info meal = await database.GetFood(key, item[key]!);
        addMeal(meal);
      });
    }
  }

  void GetMeals() async {
    Database database = Database();
    costommeals = await database.GetCostomFood(widget.client);
  }

  void _OpenAddExpenseOverlay() {
    showModalBottomSheet(

        //useRootNavigator: true,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        context: context,
        builder: ((ctx) {
          return Upload(
            client: widget.client,
            addMeal: addMeal,
          );
        }));
  }

  void initialize() async {
    var userdata = await FirebaseFirestore.instance
        .collection('Users')
        .doc(widget.client.mail!)
        .get();

    setState(() {
      widget.client = Clients_info.fromMap(userdata.data()!);
    });
  }

  @override
  Widget build(BuildContext context) {
    var navcolor = Colors.orange;
    if (selectedpageindex == 0) {
      initialize();
      setState(() {
        activescreen = Homepage(
          client: widget.client,
          meals: meals,
          initialize: initialize,
        );
      });
    } else if (selectedpageindex == 1) {
      GetMeals();
      activescreen = CostomPage(
        client: widget.client,
        addMeal: addMeal,
        meals: costommeals,
      );
    } else if (selectedpageindex == 2) {
      setState(() {
        activescreen = ScanFood(client: widget.client);
      });
    } else if (selectedpageindex == 4) {
      setState(() {
        activescreen = ProfileScreen(
          client: widget.client,
        );
      });
    }
    return Scaffold(
      body: activescreen,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        fixedColor: navcolor,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        currentIndex:
            selectedpageindex, //this made the selected category highlighted...
        onTap: _selectpage,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.fastfood_rounded), label: 'Costom'),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner_outlined),
            label: 'Scan',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_rounded), label: 'Upload'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: 'Profile'),
        ],
      ),
    );
  }
}
