import 'package:health_se/Entity/PointSchema.dart';

class InfectiousDiseaseSuggestion {
  final String suggestion;

  InfectiousDiseaseSuggestion({this.suggestion});

  factory InfectiousDiseaseSuggestion.fromJson(Map<String, dynamic> json) {
    return InfectiousDiseaseSuggestion(
      suggestion: json['suggestion'] as String,
    );
  }
}

class InfectiousDiseaseSuggestionList {
  final List<InfectiousDiseaseSuggestion> slist;

  InfectiousDiseaseSuggestionList({
    this.slist,
  });

  factory InfectiousDiseaseSuggestionList.fromJson(List<dynamic> parsedJson) {
    List<InfectiousDiseaseSuggestion> maps111 =
        new List<InfectiousDiseaseSuggestion>();
    print("TESTING!!");
    print(parsedJson);
    maps111 =
        parsedJson.map((i) => InfectiousDiseaseSuggestion.fromJson(i)).toList();
    return new InfectiousDiseaseSuggestionList(slist: maps111);
  }
}
