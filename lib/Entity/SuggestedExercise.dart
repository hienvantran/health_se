class SuggestedExercise {
  final String name;
  final int calorieBurn;
  final int duration;

  SuggestedExercise({this.calorieBurn, this.duration, this.name});

  factory SuggestedExercise.fromJson(Map<String, dynamic> json) {
    return SuggestedExercise(
      name: json['name'] as String,
      calorieBurn: json['calorieBurn'] as int,
      duration: json['duration'] as int,
    );
  }
}
