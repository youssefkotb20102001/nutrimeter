import 'package:flutter/material.dart';
import 'package:nutrimeter/Classes/Clients_info.dart';
import 'package:nutrimeter/Classes/Meal_info.dart';
import 'package:nutrimeter/Data/Clients.dart';

class Cards extends StatelessWidget {
  Cards(
      {super.key,
      required this.meal,
      required this.addMeal,
      required this.client});
  final Meal_Info meal;
  Function(Meal_Info meal) addMeal;
  Clients_info client;

  String image() {
    if (meal.meal == "Breakfast") {
      return "lib/Assets/buritto 2.png";
    } else if (meal.meal == "Lunch") {
      return "lib/Assets/pizza 1.png";
    } else if (meal.meal == "Dinner") {
      return "lib/Assets/steak 2.png";
    } else if (meal.meal == "Snacks") {
      return 'lib/Assets/fries 1.png';
    } else {
      return 'Error';
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Database database = Database();
        database.saveUsersFood(client, meal);
        addMeal(meal);
      },
      child: Card(
          child: Padding(
              padding: EdgeInsets.symmetric(),
              child: Row(
                children: [
                  Image.asset(image()),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        meal.name!,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                          "${meal.kcAl} Kcal  ${meal.carbs}g Carbs ${meal.proteins}g Proteins  ${meal.fats}g Fats"),
                    ],
                  ),
                  Spacer(),
                  Icon(
                    Icons.add_circle,
                    color: Colors.orange,
                  )
                ],
              ))),
    );
  }
}
