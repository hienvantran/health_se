class DietPlan {
  final String dietPlan; //cutting, bulking or maintainence
  final List<dynamic> dietCompositionList; //can try List<DietComposition>

  DietPlan({this.dietPlan, this.dietCompositionList});

  factory DietPlan.fromJson(Map<String, dynamic> json) {
    return DietPlan(
      dietPlan: json['dietPlan'] as String,
      dietCompositionList: json['dietComposition'] as List<dynamic>,
    );
  }
}
