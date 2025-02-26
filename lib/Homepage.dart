import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nutrimeter/Classes/Clients_info.dart';
import 'package:nutrimeter/Classes/Meal_info.dart';
import 'package:nutrimeter/Tabs.dart';
import 'package:nutrimeter/Widgets/Cards.dart';

class Homepage extends StatefulWidget {
  Homepage(
      {required this.client, required this.meals, required this.initialize});
  Clients_info client;
  final List<Card> meals;
  final Function() initialize;
  @override
  State<Homepage> createState() {
    return _HomepageState();
  }
}

class _HomepageState extends State<Homepage> with RouteAware {
  var index = 0;

  Widget progressbar(double progressValue) {
    return LinearProgressIndicator(
      borderRadius: BorderRadius.circular(30),
      value: progressValue, // Set progress based on the value
      minHeight: 10, // You can customize the height of the progress bar
      backgroundColor: const Color.fromARGB(255, 255, 251, 251),
      color: Colors.blue, // The color of the progress bar
    );
  }

  // @override
  // void initState() {
  //   widget.initialize();
  //   // TODO: implement initState
  //   super.initState();
  // }

  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   setState(() {
  //     widget.initialize();
  //   });
  // }

  String total_cal() {
    int totalcal = 0;
    if (widget.client.gender == "Male") {
      totalcal = (2500 - widget.client.kcal!);
    } else {
      totalcal = (2000 - widget.client.kcal!);
    }

    if (totalcal <= 0) {
      return "Done";
    }
    return totalcal.toString();
  }

  @override
  Widget build(BuildContext context) {
    if (index == 0) {
      setState(() {
        index = 1;
      });
      widget.initialize();
    }
    var width = MediaQuery.of(context).size.width;
    var Height = MediaQuery.of(context).size.height;

    var active = Expanded(
      child: SizedBox(
        width: width * 0.8,
        //   height: Height * 0.1,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                20.0), // Adjust the value for desired roundness
          ),
          elevation: 10,
          shadowColor: Colors.black.withOpacity(1),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Image.asset("lib/Assets/3D Food Icon by @Odafe_UI.png"),
                const Spacer(),
                const Text("Add your First Meals here!")
              ],
            ),
          ),
        ),
      ),
    );

    if (widget.meals.isNotEmpty) {
      active = Expanded(
        child: ListView.builder(
          itemCount: widget.meals.length,
          itemBuilder: ((context, index) => Dismissible(
              background: Container(
                color: Theme.of(context).colorScheme.error.withOpacity(0.75),
                // margin: EdgeInsets.symmetric(
                //     horizontal: Theme.of(context).cardTheme.margin!.horizontal),
              ),
              key: ValueKey(widget.meals[index]),
              onDismissed: ((direction) {
                widget.meals.remove(widget.meals[index]);
              }),
              child: widget.meals[index])),
        ),
      );
    }

    //var navcolor = Colors.orange;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.account_circle,
              color: Colors.black,
            )),
        title: Center(
          child: Column(
            children: [
              const Text(
                "Welcome again",
                style: TextStyle(color: Colors.black),
              ),
              Text(
                widget.client.username == null ? '' : widget.client.username!,
                style: const TextStyle(color: Colors.black),
              )
            ],
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.menu,
                color: Colors.black,
              ))
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(width * 0.05, 0, width * 0.05, 0),
            child: Row(
              children: [
                const Column(
                  children: [
                    Text(
                      "Today",
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(
                      "Thursday",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    )
                  ],
                ),
                const Spacer(),
                Container(
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 111, 188, 251),
                      borderRadius: BorderRadius.circular(10)),
                  child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.calendar_month_outlined)),
                )
              ],
            ),
          ),
          SizedBox(
            height: Height * 0.05,
          ),
          SizedBox(
            height: Height * 0.3,
            width: width * 0.8,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Card(
                color: const Color.fromARGB(255, 138, 196, 244),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(width * 0.1, 0, width * 0.1, 0),
                  child: Row(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          // Circular Progress Indicator
                          SizedBox(
                            width: width * 0.2,
                            height: Height * 0.125,
                            child: CircularProgressIndicator(
                              value: widget.client.gender == "Male"
                                  ? widget.client.kcal! / 2500
                                  : widget.client.kcal! /
                                      2000, // Set progress based on the value
                              backgroundColor: Colors.grey[300],
                              color: const Color.fromARGB(255, 195, 254,
                                  0), // The color of the progress bar
                              strokeWidth:
                                  8, // Thickness of the progress indicator
                            ),
                          ),
                          SizedBox(
                            width: width * 0.17,
                            height: Height * 0.105,
                            child: CircularProgressIndicator(
                              value: 0, // Set progress based on the value
                              backgroundColor: Colors.grey[300],
                              color: const Color.fromARGB(255, 195, 254,
                                  0), // The color of the progress bar
                              strokeWidth:
                                  8, // Thickness of the progress indicator
                            ),
                          ),
                          // Text in the Center
                          Padding(
                            padding: EdgeInsets.only(top: width * 0.18),
                            child: Column(
                              children: [
                                const Icon(
                                  Icons.electric_bolt_outlined,
                                  color: Colors.white,
                                ),
                                Text(total_cal()),
                                const Text("KCAL LEFT")
                              ],
                            ),
                          )
                        ],
                      ),
                      const Spacer(),
                      Padding(
                        padding: EdgeInsets.only(top: Height * 0.03),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Carb",
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(
                                width: width * 0.3,
                                child: progressbar(widget.client.carbs! / 300)),
                            Text(
                              300 - widget.client.carbs! != 0
                                  ? "${300 - widget.client.carbs!}g Left"
                                  : "Done",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: Height * 0.02,
                            ),
                            const Text(
                              "Protein",
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(
                                width: width * 0.3,
                                child:
                                    progressbar(widget.client.proteins! / 300)),
                            Text(
                              300 - widget.client.proteins! != 0
                                  ? "${300 - widget.client.proteins!}g Left"
                                  : "Done",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: Height * 0.02,
                            ),
                            const Text(
                              "Fats",
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(
                                width: width * 0.3,
                                child: progressbar(widget.client.fats! / 300)),
                            Text(
                              300 - widget.client.fats! != 0
                                  ? "${300 - widget.client.fats!}g Left"
                                  : "Done",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: Height * 0.01,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: width * 0.3,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(children: [
                      const Row(
                        children: [
                          Text(
                            "eaten",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                          Icon(
                            Icons.fastfood,
                            color: Colors.orange,
                          )
                        ],
                      ),
                      const Text("960"),
                      SizedBox(
                        height: Height * 0.01,
                      ),
                      const Text("KCAL"),
                      SizedBox(
                          width: width * 0.2,
                          child: LinearProgressIndicator(
                            borderRadius: BorderRadius.circular(30),
                            value: 0.7, // Set progress based on the value
                            minHeight:
                                10, // You can customize the height of the progress bar
                            backgroundColor:
                                const Color.fromARGB(255, 195, 193, 193),
                            color: Colors.blue, // The color of the progress bar
                          ))
                    ]),
                  ),
                ),
              ),
              SizedBox(
                width: width * 0.3,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(children: [
                      const Row(
                        children: [
                          Text(
                            "Burned",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                          Icon(
                            Icons.local_fire_department_outlined,
                            color: Colors.blue,
                          )
                        ],
                      ),
                      const Text("180"),
                      SizedBox(
                        height: Height * 0.01,
                      ),
                      const Text("KCAL"),
                      SizedBox(
                          width: width * 0.2,
                          child: LinearProgressIndicator(
                            borderRadius: BorderRadius.circular(30),
                            value: 0.3, // Set progress based on the value
                            minHeight:
                                10, // You can customize the height of the progress bar
                            backgroundColor:
                                const Color.fromARGB(255, 195, 193, 193),
                            color: Colors.blue, // The color of the progress bar
                          ))
                    ]),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: Height * 0.04,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.fromLTRB(width * 0.1, 0, 0, 0),
              child: const Text(
                "Daily meals",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
              ),
            ),
          ),
          active
        ],
      ),
    );
  }
}
