import 'package:court_project/models/court_complexes.dart';

class CourtController {
  List<CourtComplex> courtComplexes = [
    CourtComplex(state: "Kerala", district: "Alappuzha", courts: [
      "Alappuzha District Court",
      "Cherthala Sub-District Court",
      "Mavelikkara Sub-District Court",
    ]),
    CourtComplex(state: "Kerala", district: "Ernakulam", courts: [
      "Ernakulam District Court",
      "Kakkanad Sub-District Court",
      "Aluva Sub-District Court",
    ]),
    CourtComplex(state: "Kerala", district: "Idukki", courts: [
      "Idukki District Court",
      "Thodupuzha Sub-District Court",
      "Devikulam Sub-District Court",
    ]),
    CourtComplex(state: "Kerala", district: "Kannur", courts: [
      "Kannur District Court",
      "Thalassery Sub-District Court",
      "Iritty Sub-District Court",
    ]),
    CourtComplex(state: "Kerala", district: "Kasaragod", courts: [
      "Kasaragod District Court",
      "Kanhangad Sub-District Court",
      "Kasaragod Sub-District Court",
    ]),
    CourtComplex(state: "Kerala", district: "Kollam", courts: [
      "Kollam District Court",
      "Karunagappally Sub-District Court",
      "Kunnathur Sub-District Court",
    ]),
    CourtComplex(state: "Kerala", district: "Kottayam", courts: [
      "Kottayam District Court",
      "Kanjirappally Sub-District Court",
      "Changanassery Sub-District Court",
    ]),
    CourtComplex(state: "Kerala", district: "Kozhikode", courts: [
      "Kozhikode District Court",
      "Vadakara Sub-District Court",
      "Koyilandy Sub-District Court",
    ]),
    CourtComplex(state: "Kerala", district: "Malappuram", courts: [
      "Malappuram District Court",
      "Perinthalmanna Sub-District Court",
      "Manjeri Sub-District Court",
    ]),
    CourtComplex(state: "Kerala", district: "Palakkad", courts: [
      "Palakkad District Court",
      "Ottapalam Sub-District Court",
      "Mannarkkad Sub-District Court",
    ]),
    CourtComplex(state: "Kerala", district: "Pathanamthitta", courts: [
      "Pathanamthitta District Court",
      "Adoor Sub-District Court",
      "Ranni Sub-District Court",
    ]),
    CourtComplex(state: "Kerala", district: "Thiruvananthapuram", courts: [
      "Thiruvananthapuram District Court",
      "Nedumangad Sub-District Court",
      "Neyyattinkara Sub-District Court",
    ]),
    CourtComplex(state: "Kerala", district: "Thrissur", courts: [
      "Thrissur District Court",
      "Irinjalakuda Sub-District Court",
      "Chalakudy Sub-District Court",
    ]),
    CourtComplex(state: "Kerala", district: "Wayanad", courts: [
      "Wayanad District Court",
      "Mananthavady Sub-District Court",
      "Sulthan Bathery Sub-District Court",
    ]),
  ];

  List<String> getListOfDistricts(String state) {
    return courtComplexes
        .where((element) => element.state == state)
        .map((e) => e.district)
        .toList();
  }

  List<String> getListOfCourts(String district) {
    return courtComplexes
        .firstWhere((element) => element.district == district)
        .courts;
  }
}
