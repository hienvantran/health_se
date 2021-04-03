class FoodChoices {
  final String food;
  final int caloriePerServing;
  final String id;

  FoodChoices({this.food, this.caloriePerServing, this.id});

  factory FoodChoices.fromJson(Map<String, dynamic> json) {
    return FoodChoices(
      id: json['_id'] as String,
      food: json['foodChoices'] as String,
      caloriePerServing: json['caloriePerServing'] as int,
    );
  }

  String getName() {
    return food;
  }
}
