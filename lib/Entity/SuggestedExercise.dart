class SuggestedExercise {
  final String name;
  final int calorieBurn;
  final int duration;

  SuggestedExercise({this.calorieBurn, this.duration, this.name});

  factory SuggestedExercise.fromJson(Map<String, dynamic> json) {
    return SuggestedExercise(
      name: json['name'] as String,
      calorieBurn: json['caloriesBurn'] as int,
      duration: json['duration'] as int,
    );
  }

  String getName() {
    return name;
  }

  int getCalorieBurnPerMin() {
    return (calorieBurn / 60).toInt();
  }
}
