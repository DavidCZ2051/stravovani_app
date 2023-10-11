// packages
import 'package:flutter/material.dart';
// files
import 'package:stravovani_app/classes.dart';
import 'package:stravovani_app/globals.dart' as globals;
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
      body: RefreshIndicator(
        onRefresh: () async {
          // TODO: refresh the menu
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              for (Day day in menu)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DayWidget(day: day),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class FoodInfo extends StatefulWidget {
  const FoodInfo(this.food, {super.key});

  final Food food;

  @override
  State<FoodInfo> createState() => _FoodInfoState();
}

class _FoodInfoState extends State<FoodInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(28),
              topRight: Radius.circular(28),
            ),
            child: Image.asset(
              "assets/images/jidlo.jpg",
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  widget.food.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  widget.food.allergensString,
                  style: const TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DayWidget extends StatefulWidget {
  const DayWidget({super.key, required this.day});

  final Day day;

  @override
  State<DayWidget> createState() => _DayWidgetState();
}

class _DayWidgetState extends State<DayWidget> {
  void showFoodInfo(Food food) {
    showBottomSheet(
      context: context,
      builder: (context) => FoodInfo(food),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.day.name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            for (FoodType foodType in widget.day.foodTypes)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(
                    color: Theme.of(context).dividerColor,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 2),
                    child: Text(
                      foodType.name,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                  RadioListTile(
                    value: 0,
                    groupValue: foodType.selectedFood,
                    onChanged: widget.day.canBeChanged
                        ? (value) {
                            setState(() {
                              foodType.selectedFood = value as int;
                            });
                          }
                        : null,
                    title: Text(
                      "Neobjednáno",
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontWeight:
                            foodType.selectedFood == 0 ? FontWeight.bold : null,
                        fontSize: 17,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    tileColor: foodType.selectedFood == 0
                        ? Theme.of(context).highlightColor.withOpacity(
                              Theme.of(context).brightness == Brightness.dark
                                  ? 0.05
                                  : 0.2,
                            )
                        : null,
                  ),
                  for (Food food in foodType.foods)
                    InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onLongPress: () {
                        showFoodInfo(food);
                      },
                      child: RadioListTile(
                        value: food.number,
                        groupValue: foodType.selectedFood,
                        onChanged: widget.day.canBeChanged
                            ? (value) {
                                setState(() {
                                  foodType.selectedFood = value as int;
                                });
                              }
                            : null,
                        title: Text(
                          food.name,
                          style: foodType.selectedFood == food.number
                              ? const TextStyle(
                                  fontWeight: FontWeight.bold,
                                )
                              : null,
                        ),
                        subtitle: Text(food.allergensString),
                        isThreeLine: true,
                        secondary:
                            food.containsUsersUnwantedAllergens(globals.user)
                                ? const Tooltip(
                                    message:
                                        "Toto jídlo obsahuje alergeny, na které máte alergii.",
                                    triggerMode: TooltipTriggerMode.tap,
                                    child: Icon(
                                      Icons.warning_amber,
                                      color: Colors.orange,
                                    ),
                                  )
                                : null,
                        tileColor: foodType.selectedFood == food.number
                            ? food.containsUsersUnwantedAllergens(globals.user)
                                ? Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.orange[700]!.withOpacity(0.25)
                                    : Colors.orange[100]
                                : Theme.of(context).highlightColor.withOpacity(
                                      Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? 0.05
                                          : 0.2,
                                    )
                            : null,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        visualDensity: VisualDensity.compact,
                      ),
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
