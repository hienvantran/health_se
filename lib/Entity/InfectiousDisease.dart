class InfectiousDisease {
  final String diseaseName;
  final List<dynamic> suggestions;
  final List<dynamic> measures;
  final String id;

  InfectiousDisease(
      {this.diseaseName, this.suggestions, this.measures, this.id});

  factory InfectiousDisease.fromJson(Map<String, dynamic> json) {
    return InfectiousDisease(
      id: json['_id'] as String,
      diseaseName: json['diseaseName'] as String,
      suggestions: json['suggestion'] as List<dynamic>,
      measures: json['measure'] as List<dynamic>,
    );
  }

  String getDiseaseName() {
    return diseaseName;
  }
}
