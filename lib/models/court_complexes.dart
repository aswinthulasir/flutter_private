class CourtComplex {
  final String state;
  final String district;
  final List<String> courts;

  CourtComplex({
    required this.state,
    required this.district,
    required this.courts,
  });

  factory CourtComplex.fromMap(Map<String, dynamic> data) {
    return CourtComplex(
      state: data['state'],
      district: data['district'],
      courts: List<String>.from(data['courts']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'state': state,
      'district': district,
      'courts': courts,
    };
  }
}
