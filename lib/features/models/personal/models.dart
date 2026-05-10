class Medicine {
  final String name;
  final int doseCount;
  final List<String> times;
  final DateTime startDate;
  final DateTime? endDate;
  final String image;
  
  

  Medicine({
    required this.name,
    required this.doseCount,
    required this.times,
    required this.startDate,
    required  this.endDate, 
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'doseCount': doseCount,
      'times': times,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'image':image
    };
  }

  // تحويل من Map لـ Medicine
  factory Medicine.fromMap(Map<String, dynamic> map) {
    return Medicine(
      name: map['name'] as String,
      doseCount: map['doseCount'] as int,
      times: List<String>.from(map['times'] as List<dynamic>),
      startDate: DateTime.parse(map['startDate'] as String),
      endDate: map['endDate'] != null ? DateTime.parse(map['endDate'] as String) : null,
       image: map['image'],
    );
  }
}

