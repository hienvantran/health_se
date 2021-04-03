class FoodRecord {
  final String foodCategory;
  final int foodAmount;
  final String timestamp;
  final String id;

  FoodRecord({this.foodAmount, this.foodCategory, this.timestamp, this.id});

  factory FoodRecord.fromJson(Map<String, dynamic> json) {
    return FoodRecord(
      id: json['_id'] as String,
      foodCategory: json['foodCategory'] as String,
      foodAmount: json['foodAmount'] as int,
      timestamp: json['timestamps'] as String,
    );
  }
}
