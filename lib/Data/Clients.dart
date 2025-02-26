import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nutrimeter/Classes/Clients_info.dart';
import 'package:nutrimeter/Classes/Meal_info.dart';

class Database {
  List<Map<String, String>> foodChosen = [];
  List<Meal_Info> costommeals = [];
  Meal_Info food = Meal_Info();
  void SaveClient(Clients_info client) async {
    await FirebaseFirestore.instance.collection('Users').doc(client.mail).set({
      'Username': client.username,
      'Password': client.password,
      'Date of Birth': client.dob,
      'Goal': client.goal,
      'Gender': client.gender,
      'Activity level': client.activityLevel,
      'Height': client.height,
      'Weight': client.weight,
      'Weight Loss': client.weightLoss,
      'Kcal': 0,
      'Carbs': 0,
      'Proteins': 0,
      'Fats': 0,
      'Mail': client.mail
    });
  }

  void GetClients() async {
    final usersdata =
        await FirebaseFirestore.instance.collection('Users').get();
    print(usersdata);
  }

  void updatefood(Clients_info client, Meal_Info meal) async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(client.mail) // Specify the document ID
        .update({
      'Kcal': meal.kcAl, // Update this field with the new value
      'Carbs': meal.carbs,
      'Fats': meal.fats,
      'Proteins': meal.proteins
    });
  }

  void updateClient(Clients_info client, Meal_Info meal) async {
    final userdata = await FirebaseFirestore.instance
        .collection('Users')
        .doc(client.mail)
        .get();

    Clients_info clientdetails = await Clients_info.fromMap(userdata.data()!);

    await FirebaseFirestore.instance
        .collection('Users')
        .doc(client.mail)
        .update({
      'Carbs': clientdetails.carbs! + meal.carbs!.toInt(),
      'Fats': clientdetails.fats! + meal.fats!.toInt(),
      'Proteins': clientdetails.proteins! + meal.proteins!.toInt(),
      'Kcal': clientdetails.kcal! + meal.kcAl!.toInt(),
    });
  }

  Future<Meal_Info> GetFood(String Type, String name) async {
    final Fooddata = await FirebaseFirestore.instance
        .collection('Food')
        .doc(Type)
        .collection(name)
        .doc("Data")
        .get();

    food = Meal_Info.fromMap(Fooddata.data()!);
    return food;
  }

  void saveUsersFood(Clients_info client, Meal_Info meal) async {
    await FirebaseFirestore.instance
        .collection('User-Food')
        .doc()
        .set({"Meal": meal.meal, "Food": meal.name, "Mail": client.mail});
    updateClient(client, meal);
  }

  Future<List<Map<String, String>>> getUsersFood(Clients_info client) async {
    final Usersfood =
        await FirebaseFirestore.instance.collection('User-Food').get();
    for (var item in Usersfood.docs) {
      var client_meal = item.data()['Mail'];
      if (client_meal == client.mail) {
        Map<String, String> map = {item.data()['Meal']: item.data()['Food']};
        foodChosen.add(map);
      }
    }
    return foodChosen;
  }

  void SaveCostomFood(Clients_info client, Meal_Info meal) async {
    await FirebaseFirestore.instance.collection('CostomFood').doc().set({
      'Client': client.mail,
      'Name': meal.name,
      'Kcal': meal.kcAl,
      'Fats': meal.fats,
      'Carbs': meal.carbs,
      'Protein': meal.proteins,
      'Type': meal.meal
    });
  }

  Future<List<Meal_Info>> GetCostomFood(Clients_info client) async {
    final Usersfood =
        await FirebaseFirestore.instance.collection('CostomFood').get();
    for (var item in Usersfood.docs) {
      var client_meal = item.data()['Client'];
      if (client_meal == client.mail) {
        Meal_Info meal = Meal_Info(
            carbs: item.data()['Carbs'],
            fats: item.data()['Fats'],
            kcAl: item.data()['Kcal'],
            meal: item.data()['Type'],
            name: item.data()['Name'],
            proteins: item.data()['Protein']);
        costommeals.add(meal);
      }
    }
    return costommeals;
  }
}
