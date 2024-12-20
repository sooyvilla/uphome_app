import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uphome_app/domain/datasource/agency_datasource.dart';
import 'package:uphome_app/domain/entities/agency.dart';
import 'package:uphome_app/domain/mappers/agency_mapper.dart';

class LocalAgencyDatasource implements AgencyDatasource {
  static final LocalAgencyDatasource _instance =
      LocalAgencyDatasource._internal();

  LocalAgencyDatasource._internal();

  factory LocalAgencyDatasource(Database database) {
    _instance._database = database;
    return _instance;
  }

  Database? _database;

  static const nameTable = 'agencies';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'database.db');
    return await openDatabase(path);
  }

  @override
  Future<List<Agency>> getAgencies() async {
    final db = await database;
    final List<Map<String, dynamic>> agencies = await db.query(nameTable);

    return agencies.map((agency) {
      return AgencyMapper.fromMap(agency);
    }).toList();
  }

  @override
  Future<Agency> getAgencyById(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(nameTable);

    if (maps.isEmpty || maps.length > 1) {
      throw Exception('Error with search or item not found');
    }

    final item = AgencyMapper.fromMap(maps.first);

    return item;
  }
}
