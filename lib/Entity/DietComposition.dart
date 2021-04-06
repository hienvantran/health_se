class DietComposition {
  final String dietCompositionName; //high, low or moderate carbs
  final int carbPercentage;
  final int fatPercentage;
  final int proteinPercentage;

  DietComposition(
      {this.carbPercentage,
      this.dietCompositionName,
      this.fatPercentage,
      this.proteinPercentage});

//  DietComposition.contructor1(String name, int carb, int fat, int protein) {
//    this.dietCompositionName = name;
//    this.carbPercentage = carb;
//    this.fatPercentage = fat;
//    this.proteinPercentage = protein;
//  }

  factory DietComposition.fromJson(Map<String, dynamic> json) {
    return DietComposition(
      dietCompositionName: json['dietCompositionName'] as String,
      carbPercentage: json['carbPercentage'] as int,
      fatPercentage: json['fatPercentage'] as int,
      proteinPercentage: json['proteinPercentage'] as int,
    );
  }
}
