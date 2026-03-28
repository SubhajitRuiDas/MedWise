class FitnessDataModel {
  final int? id;
  final String type;
  final int value;
  final String date;

  FitnessDataModel ({
    this.id,
    required this.type,
    required this.value,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'value': value,
      'date': date,
    };
  }

  factory FitnessDataModel.fromMap(Map<String, dynamic> map) {
    return FitnessDataModel(
      id: map['id'],
      type: map['type'],
      value: map['value'],
      date: map['date'],
    );
  }
}