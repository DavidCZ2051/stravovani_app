// packages
import 'package:flutter/material.dart';
// files
import 'package:stravovani_app/classes.dart';
// widgets
import 'package:stravovani_app/widgets/drawer.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: AppBar(
        title: const Text("Stravování"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            for (Day day in menu)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  color: Colors.purple[800],
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          day.name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        for (FoodType foodType in day.foodTypes)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Divider(
                                color: Colors.black38,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 30),
                                child: Text(
                                  foodType.name,
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ),
                              RadioListTile(
                                value: 0,
                                groupValue: foodType.selectedFood,
                                onChanged: (value) {
                                  setState(() {
                                    foodType.selectedFood = value as int;
                                  });
                                },
                                title: const Text(
                                  "Neobjednáno",
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                              for (Food food in foodType.foods)
                                RadioListTile(
                                  value: food.number,
                                  groupValue: foodType.selectedFood,
                                  onChanged: (value) {
                                    setState(() {
                                      foodType.selectedFood = value as int;
                                    });
                                  },
                                  title: Text(
                                      "${food.name} ${food.allergensString}"),
                                ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
