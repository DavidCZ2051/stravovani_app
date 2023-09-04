enum Allergens {
  // Alergeny seřazeny podle dokumentu EU 32011R1169
  gluten,
  crusteceans,
  eggs,
  fish,
  peanuts,
  soybeans,
  milk,
  nuts,
  celery,
  mustard,
  sesameSeeds,
  sulphurDioxideAndSulphites,
  lupin,
  molluscs;

  String get number {
    switch (this) {
      case Allergens.gluten:
        return "1";
      case Allergens.crusteceans:
        return "2";
      case Allergens.eggs:
        return "3";
      case Allergens.fish:
        return "4";
      case Allergens.peanuts:
        return "5";
      case Allergens.soybeans:
        return "6";
      case Allergens.milk:
        return "7";
      case Allergens.nuts:
        return "8";
      case Allergens.celery:
        return "9";
      case Allergens.mustard:
        return "10";
      case Allergens.sesameSeeds:
        return "11";
      case Allergens.sulphurDioxideAndSulphites:
        return "12";
      case Allergens.lupin:
        return "13";
      case Allergens.molluscs:
        return "14";
    }
  }
}

class Food {
  int number;
  String name;
  List<Allergens>? allergens;

  String get allergensString {
    if (allergens == null) return "";

    return "A: ${allergens!.map((e) => e.number).join(", ")}";
  }

  Food(this.name, this.number, {this.allergens});
}

class FoodType {
  int number;
  String name;
  List<Food> foods;
  int selectedFood;

  FoodType(this.name, this.number,
      {required this.foods, required this.selectedFood});
}

class Day {
  String name;
  List<FoodType> foodTypes;

  Day(this.name, {required this.foodTypes});
}

List<Day> menu = [
  Day(
    "Úterý",
    foodTypes: [
      FoodType(
        "Snídaně",
        0,
        foods: [
          Food(
            "Houska, sýrová houska, chléb z kamenné pece, máslo, nutella, budapešťská pomazánka, salám, ovocný jogurt",
            1,
          ),
        ],
        selectedFood: 1,
      ),
      FoodType(
        "Oběd",
        1,
        foods: [
          Food(
            "Mexický guláš z hovězího masa sypaný sýrem, petrželková rýže",
            1,
            allergens: [Allergens.gluten, Allergens.eggs, Allergens.milk],
          ),
          Food(
            "Řecký salát s olivami a balkánským sýrem, selský rohlík",
            2,
            allergens: [
              Allergens.gluten,
              Allergens.eggs,
              Allergens.soybeans,
              Allergens.milk,
              Allergens.sesameSeeds
            ],
          ),
        ],
        selectedFood: 2,
      ),
      FoodType(
        "Večeře",
        2,
        foods: [
          Food(
            "Špecle s anglickou slaninou a kysaným zelím, ovoce",
            1,
            allergens: [Allergens.gluten, Allergens.eggs, Allergens.milk],
          ),
        ],
        selectedFood: 0,
      ),
    ],
  ),
];
