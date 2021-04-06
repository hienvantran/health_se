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
    print("percentange\n");
    print(nutritionList);
    return nutritionList;
  }

//  int getProteinPercentage(String composition) {
//    return getCompositionByString(composition)['proteinPercentage'];
//  }
//
//  int getCarbPercentage(String composition) {
//    return getCompositionByString(composition)['carbPercentage'];
//  }
//
//  int getFatPercentage(String composition) {
//    return getCompositionByString(composition)['fatPercentage'];
//  }
}
