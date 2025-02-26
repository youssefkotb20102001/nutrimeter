import 'package:flutter/material.dart';
import 'package:nutrimeter/Classes/Clients_info.dart';
import 'package:nutrimeter/Classes/Meal_info.dart';
import 'package:nutrimeter/Widgets/Cards.dart';

// ignore: must_be_immutable
class CardList extends StatelessWidget {
  CardList(
      {super.key,
      required this.list,
      required this.addMeal,
      required this.client});

  List<Meal_Info> list;
  Function(Meal_Info meal) addMeal;
  Clients_info client;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: ((context, index) => Dismissible(
          background: Container(
            color: Theme.of(context).colorScheme.error.withOpacity(0.75),
            // margin: EdgeInsets.symmetric(
            //     horizontal: Theme.of(context).cardTheme.margin!.horizontal),
          ),
          key: ValueKey(list[index]),
          onDismissed: ((direction) {
            list.remove(list[index]);
          }),
          child: Cards(
            meal: list[index],
            addMeal: addMeal,
            client: client,
          ))),
    );
  }
}

//  final Map<String, dynamic> item = entry.value;
//       if (patient.phone == item['رقم للتواصل به واتساب']) {
//         final String urlex = entry.key;
//         final Url2 = Uri.https('test2-20d77-default-rtdb.firebaseio.com',
//             'test-list1tDnKF_ZMWMWZiEMCyj4ZFI7tSMHJuWtqDQ1zwbOxQAo/Form Responses 1/$urlex.json');
//         http.patch(Url2,
//             // headers: {
//             //   'Content-Type': 'application/json',
//             // },
//             body: json.encode({
//               'exists': 1,
//             }));
//       }
