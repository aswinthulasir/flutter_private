class CourtComplex {
  final String district;
  final String courtComplex;

  CourtComplex({
    required this.district,
    required this.courtComplex,
  });

  Map<String, dynamic> toMap() {
    return {
      'District': district,
      'CourtComplexName': courtComplex,
    };
  }
}
