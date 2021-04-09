import 'package:health_se/Entity/InfectiousDiseaseSuggestion.dart';

class InfectiousDisease {
  final String diseaseName;
  final InfectiousDiseaseSuggestionList suggestions;
  final List<dynamic> measures;
  final String id;
  String risk;

  InfectiousDisease(
      {this.diseaseName, this.suggestions, this.measures, this.id});

  factory InfectiousDisease.fromJson(Map<String, dynamic> json) {
    InfectiousDiseaseSuggestionList mList =
        InfectiousDiseaseSuggestionList.fromJson(json['suggestion']);
    return InfectiousDisease(
      id: json['_id'] as String,
      diseaseName: json['diseaseName'] as String,
      suggestions: mList,
      measures: json['measure'] as List<dynamic>,
    );
  }

  void setRisk(String risk) {
    this.risk = risk;
  }

  String getRisk() {
    return risk;
  }

  String getDiseaseName() {
    return diseaseName;
  }

  List<dynamic> getMeasures() {
    return measures;
  }
}
