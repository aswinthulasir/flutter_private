class CourtComplex {
  final String district;
  final List<String> courts;

  CourtComplex({
    required this.district,
    required this.courts,
  });

  factory CourtComplex.fromMap(Map<String, dynamic> data) {
    return CourtComplex(
      district: data['district'],
      courts: List<String>.from(data['courts']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'district': district,
      'courts': courts,
    };
  }
}
