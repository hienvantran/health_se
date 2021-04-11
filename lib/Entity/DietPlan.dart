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

  List<int> getCompositionByString(String composition) {
    int i;
    for (i = 0; i <= dietCompositionList.length; i++) {
      if (dietCompositionList[i]["dietCompositionName"] == composition) break;
    }
    List<int> nutritionList = [
      dietCompositionList[i]['proteinPercentage'],
      dietCompositionList[i]['carbPercentage'],
      dietCompositionList[i]['fatPercentage']
    ];

    return nutritionList;
  }
}
