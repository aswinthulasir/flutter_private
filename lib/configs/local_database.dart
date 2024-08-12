import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalDatabase {
  static void initialise() async {
    var db = await openDatabase(
        join(
          await getDatabasesPath(),
          "local.db",
        ), onCreate: (db, version) {
      return db.execute(
        '''CREATE TABLE KeralaCourtComplexes (District VARCHAR(50),CourtComplexName VARCHAR(100));

          INSERT INTO KeralaCourtComplexes (District, CourtComplexName) VALUES ('Alappuzha', 'Alappuzha District Court');
          INSERT INTO KeralaCourtComplexes (District, CourtComplexName) VALUES ('Ernakulam', 'Ernakulam District Court');
          INSERT INTO KeralaCourtComplexes (District, CourtComplexName) VALUES ('Idukki', 'Idukki District Court');
          INSERT INTO KeralaCourtComplexes (District, CourtComplexName) VALUES ('Kannur', 'Kannur District Court');
          INSERT INTO KeralaCourtComplexes (District, CourtComplexName) VALUES ('Kasaragod', 'Kasaragod District Court');
          INSERT INTO KeralaCourtComplexes (District, CourtComplexName) VALUES ('Kollam', 'Kollam District Court');
          INSERT INTO KeralaCourtComplexes (District, CourtComplexName) VALUES ('Kottayam', 'Kottayam District Court');
          INSERT INTO KeralaCourtComplexes (District, CourtComplexName) VALUES ('Kozhikode', 'Kozhikode District Court');
          INSERT INTO KeralaCourtComplexes (District, CourtComplexName) VALUES ('Malappuram', 'Malappuram District Court');
          INSERT INTO KeralaCourtComplexes (District, CourtComplexName) VALUES ('Palakkad', 'Palakkad District Court');
          INSERT INTO KeralaCourtComplexes (District, CourtComplexName) VALUES ('Pathanamthitta', 'Pathanamthitta District Court');
          INSERT INTO KeralaCourtComplexes (District, CourtComplexName) VALUES ('Thiruvananthapuram', 'Thiruvananthapuram District Court');
          INSERT INTO KeralaCourtComplexes (District, CourtComplexName) VALUES ('Thrissur', 'Thrissur District Court');
          INSERT INTO KeralaCourtComplexes (District, CourtComplexName) VALUES ('Wayanad', 'Wayanad District Court');
        ''',
      );
    }, version: 1);
  }

  Future<List<Map<String, dynamic>>> getKeralaCourtComplexes() async {
    var db = await openDatabase(
      join(
        await getDatabasesPath(),
        "local.db",
      ),
    );

    var result = await db.query("KeralaCourtComplexes");

    db.close();

    return result;
  }
}
