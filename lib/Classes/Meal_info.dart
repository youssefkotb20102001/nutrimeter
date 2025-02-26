enum Meal { Breakfast, Lunch, Snack, Dinner }

const AllBreakfast = ["Eggs", "Sandwich"];
const AllDinner = ["Pasta"];
const AllLunch = ["Pizza", "Burger"];
const AllSnacks = [
  "Fries",
];

class Meal_Info {
  const Meal_Info(
      {this.meal, this.name, this.fats, this.kcAl, this.proteins, this.carbs});

  factory Meal_Info.fromMap(Map<String, dynamic> data) {
    return Meal_Info(
      carbs: data['Carbs'],
      fats: data['Fats'],
      kcAl: data['Kcal'],
      meal: data['Type'],
      name: data['Name'],
      proteins: data['Protein'],
    );
  }
  final String? meal;
  final String? name;
  final int? kcAl;
  final int? proteins;
  final int? fats;
  final int? carbs;
}
